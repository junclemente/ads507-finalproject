#!/usr/bin/env python3

import pandas as pd
import json
import logging
import os
import requests

from dotenv import load_dotenv
from time import sleep
from sqlalchemy import create_engine, text

# load the .env file
load_dotenv()

# API variables
api_key = os.getenv("API_KEY")

# MySQL database variables
db_user = os.getenv("AZURE_USERNAME")
db_pwd = os.getenv("AZURE_PWD")
db_host = os.getenv("AZURE_URL")
db_port = os.getenv("AZURE_PORT")
db_database = os.getenv("AZURE_DB")

TRAVEL_TIMES_URL = "http://wsdot.wa.gov/Traffic/api/TravelTimes/TravelTimesREST.svc/GetTravelTimesAsJson?AccessCode={ACCESSCODE}"

TRAFFIC_ALERTS_URL = "http://www.wsdot.wa.gov/Traffic/api/HighwayAlerts/HighwayAlertsREST.svc/GetAlertsAsJson?AccessCode={ACCESSCODE}"

WEATHER_INFORMATION_URL = "http://wsdot.wa.gov/Traffic/api/WeatherInformation/WeatherInformationREST.svc/GetCurrentWeatherInformationAsJson?AccessCode={ACCESSCODE}"

# Database engine
connection_url = (
    f"mysql+pymysql://{db_user}:{db_pwd}" f"@{db_host}:{db_port}/{db_database}"
)
engine = create_engine(connection_url)


# Custom logging handler
class MySQLLogHandler(logging.Handler):

    def __init__(self, db_engine):
        super().__init__()
        self.engine = db_engine
        self.formatter = logging.Formatter("%(asctime)s - %(levelname)s - %(message)s")

    def emit(self, record):
        """Inserts log records into MySQL in real time."""
        try:
            # log_time = self.formatter.formatTime(record, self.formatter.datefmt)
            log_level = record.levelname
            log_message = self.format(record)

            with self.engine.begin() as conn:
                query = """
                    INSERT INTO application_logs (log_timestamp, log_level, log_message)
                    VALUES (NOW(), :log_level, :log_message)
                """
                conn.execute(
                    text(query), {"log_level": log_level, "log_message": log_message}
                )
        except Exception as e:
            print(f"Failed to insert log into MySQL: {e}")


logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    handlers=[
        MySQLLogHandler(engine),
        # logging.FileHandler("app.log"),
        logging.StreamHandler(),
    ],
    force=True,
)


# customer function to get api data
def get_api_data(url, access_key):
    # create the url with the access key
    url_api = url.format(ACCESSCODE=access_key)
    response = requests.get(url_api)

    # check if request was successful
    if response.status_code == 200:
        logging.info("Data fetched successfully.")
        data = response.json()
        df = pd.DataFrame(data)
    else:
        logging.error(f"Failed to fetch data. Status code: {response.status_code}")

    # return the dataframe and the status code
    return df, response.status_code


# function to convert dictionary columns from api to json
def convert_dict_to_json(dataframe):

    for col in dataframe.columns:
        if dataframe[col].apply(lambda x: isinstance(x, dict)).all():
            dataframe[col] = dataframe[col].apply(lambda x: json.dumps(x))


def upload_dataframe(dataframe, table_name, conn, mode="append"):
    try:
        dataframe.to_sql(
            table_name,
            con=conn,
            if_exists=mode,
            index=False,
        )
        logging.info(f"{table_name} ({mode}) uploaded successfully.")
    except Exception as e:
        logging.error(f"Failed to upload {table_name}. Error: {e}")


# function to get api data
def api_update(
    travel_times_url, traffic_alerts_url, weather_information_url, access_key
):

    # Get current time
    timestamp = pd.Timestamp.now()
    df_tt, response_tt = get_api_data(travel_times_url, access_key)
    df_ta, response_ta = get_api_data(traffic_alerts_url, access_key)
    df_wa, response_wa = get_api_data(weather_information_url, access_key)

    if response_tt == 200 and response_ta == 200 and response_wa == 200:
        status = "Success"
        logging.info(status)
    else:
        status = "Failed"
        logging.error(status)

    # add pull_date_time
    df_tt["timestamp"] = timestamp
    df_ta["timestamp"] = timestamp
    df_wa["timestamp"] = timestamp

    # convert dict columns to json
    convert_dict_to_json(df_tt)
    convert_dict_to_json(df_ta)
    convert_dict_to_json(df_wa)

    df_api_fetch = pd.DataFrame(
        [
            {
                "timestamp": timestamp,
                "travel_times_response": response_tt,
                "traffic_alerts_response": response_ta,
                "weather_alerts_response": response_wa,
                "status": status,
            }
        ]
    )

    return df_api_fetch, df_tt, df_ta, df_wa, status


def extract_load_transform():
    SLEEP_TIME = 5

    try:
        # fetch data
        df_api_fetch, df_tt, df_ta, df_wa, status = api_update(
            TRAVEL_TIMES_URL, TRAFFIC_ALERTS_URL, WEATHER_INFORMATION_URL, api_key
        )

        # connect to database
        with engine.connect() as conn:
            logging.info("*** Connected to database ***")

            # Append history tables
            logging.info("*** Appending to history tables ***")
            history_tables = {
                "api_fetch_hist": df_api_fetch,
                "time_travel_hist": df_tt,
                "traffic_alerts_hist": df_ta,
                "weather_alerts_hist": df_wa,
            }
            for table, df in history_tables.items():
                upload_dataframe(df, table, conn, "append")

            if status != "Success":
                logging.warning(
                    "API update was unsuccessful. Skipping raw table updates."
                )
                return None

            # Update raw tables
            logging.info("*** Updating raw tables ***")
            raw_tables = {
                "api_fetch": df_api_fetch,
                "time_travel_raw": df_tt,
                "traffic_alerts_raw": df_ta,
                "weather_alerts_raw": df_wa,
            }
            for table, df in raw_tables.items():
                upload_dataframe(df, table, conn, "replace")

            # Wait before calling stored procedures
            sleep(SLEEP_TIME)

            # Call stored procedures
            stored_procedures = [
                "CALL TransformTravelTime",
                "CALL TransformTrafficAlerts",
                "CALL TransformWeatherAlerts",
            ]
            results = [conn.execute(text(sp)) for sp in stored_procedures]

            # Print results
            for sp, result in zip(stored_procedures, results):
                logging.info(f"{sp} result: {result}")

    except Exception as e:
        logging.info("Database operation failed: ", e)
        return None

    return None


extract_load_transform()
