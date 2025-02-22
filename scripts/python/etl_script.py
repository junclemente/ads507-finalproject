#!/usr/bin/env python3


# %% [markdown]
# # Washington State DOT Traffic API
#
# source: [https://wsdot.wa.gov/traffic/api](https://wsdot.wa.gov/traffic/api)
#

# %% [markdown]
# ## Import libraries
#

# %%
import pandas as pd
import json
import logging
import os
import requests

from dotenv import load_dotenv
from time import sleep
from sqlalchemy import create_engine, text

# %% [markdown]
# ## Import env variables
#

# %%
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

# %% [markdown]
# ## URLs to Access APIs
#

# %%
TRAVEL_TIMES_URL = "http://wsdot.wa.gov/Traffic/api/TravelTimes/TravelTimesREST.svc/GetTravelTimesAsJson?AccessCode={ACCESSCODE}"

TRAFFIC_ALERTS_URL = "http://www.wsdot.wa.gov/Traffic/api/HighwayAlerts/HighwayAlertsREST.svc/GetAlertsAsJson?AccessCode={ACCESSCODE}"

WEATHER_INFORMATION_URL = "http://wsdot.wa.gov/Traffic/api/WeatherInformation/WeatherInformationREST.svc/GetCurrentWeatherInformationAsJson?AccessCode={ACCESSCODE}"

# %%
# Database engine
connection_url = (
    f"mysql+pymysql://{db_user}:{db_pwd}" f"@{db_host}:{db_port}/{db_database}"
)
engine = create_engine(connection_url)

# %% [markdown]
# # Classes and Functions
#

# %% [markdown]
# ## Class: MySQLLogHandler
#


# %%
class MySQLLogHandler(logging.Handler):
    """
    A custom logging handler that stores log records in a MySQL database
    developed with the help of ChatGPT.

    This handler extends `logging.Handler` and writes log messages to a MySQL table
    in real time. It utilizes an SQLAlchemy database engine for executing inserts.

    Attributes:
        engine (sqlalchemy.engine.base.Engine): The SQLAlchemy database engine used
            to establish a connection with the MySQL database.
        formatter (logging.Formatter): The formatter used to format log messages.

    Methods:
        emit(record):
            Inserts a log record into the `application_logs` table in the MySQL database.
            Logs include timestamp, log level, and formatted message.

    Example:
        ```python
        import logging
        from sqlalchemy import create_engine
        from your_module import MySQLLogHandler

        engine = create_engine("mysql+pymysql://user:password@localhost/dbname")

        logger = logging.getLogger("app_logger")
        logger.setLevel(logging.INFO)

        db_handler = MySQLLogHandler(engine)
        logger.addHandler(db_handler)

        logger.info("This is an info log message.")
        ```

    Docstring by ChatGPT.
    """

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


# %% [markdown]
# ### Logging configuration
#

# %%
# Configure logging to use MySQLLogHandler
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

# %% [markdown]
# ## Function: get_api_data
#


# %%
def get_api_data(url, access_key):
    """
    Fetches data from an API and returns it as a Pandas DataFrame.

    This function sends a GET request to the specified API endpoint using the provided
    access key. If the request is successful (status code 200), the JSON response is
    converted into a Pandas DataFrame. Otherwise, an error message is logged.

    Args:
        url (str): The API endpoint URL containing a placeholder `{ACCESSCODE}`
            for the access key.
        access_key (str): The access key required for authentication with the API.

    Returns:
        tuple: A tuple containing:
            - pd.DataFrame: The retrieved data as a Pandas DataFrame if the request is successful.
            - int: The HTTP response status code.

    Example:
        ```python
        url = "https://api.example.com/data?key={ACCESSCODE}"
        access_key = "your_api_key"

        df, status_code = get_api_data(url, access_key)

        if status_code == 200:
            print("Data fetched successfully!")
            print(df.head())
        else:
            print(f"Failed to fetch data. Status code: {status_code}")
        ```

    Docstring by ChatGPT.
    """

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


# %% [markdown]
# ## Function: convert_dict_to_json
#


# %%
def convert_dict_to_json(dataframe):
    """
    Converts dictionary-type values in a Pandas DataFrame to JSON strings.
    Developed with help of ChatGPT.

    This function iterates through each column in the DataFrame and checks if all
    values in the column are dictionaries. If a column contains only dictionaries,
    it converts each dictionary into a JSON-formatted string.

    Args:
        dataframe (pd.DataFrame): The DataFrame containing potential dictionary-type values.

    Returns:
        None: The function modifies the DataFrame in place.

    Example:
        ```python
        import pandas as pd

        data = {
            "col1": [{"key1": "value1"}, {"key2": "value2"}],
            "col2": [123, 456]
        }
        df = pd.DataFrame(data)

        convert_dict_to_json(df)

        print(df)
        # Output:
        #                           col1  col2
        # 0  {"key1": "value1"}   123
        # 1  {"key2": "value2"}   456
        ```

    Docstring by ChatGPT.
    """

    for col in dataframe.columns:
        if dataframe[col].apply(lambda x: isinstance(x, dict)).all():
            dataframe[col] = dataframe[col].apply(lambda x: json.dumps(x))


# %% [markdown]
# ## Function: upload_dataframe
#


# %%
def upload_dataframe(dataframe, table_name, conn, mode="append"):
    """
    Uploads a Pandas DataFrame to a SQL database table.

    This function inserts data from a Pandas DataFrame into a specified SQL table
    using SQLAlchemy. It supports different insertion modes, such as 'append' or
    'replace'. If the upload is successful, a log message is recorded. If an error
    occurs, an error message is logged.

    Args:
        dataframe (pd.DataFrame): The DataFrame to be uploaded to the database.
        table_name (str): The name of the target SQL table.
        conn (sqlalchemy.engine.base.Engine or sqlalchemy.Connection):
            The SQLAlchemy database connection or engine.
        mode (str, optional): Specifies the insertion mode:
            - `"append"` (default): Adds new records without removing existing ones.
            - `"replace"`: Drops the table and creates a new one with the DataFrame.
            - `"fail"`: Raises an error if the table already exists.

    Returns:
        None: The function uploads data to the database but does not return a value.

    Example:
        ```python
        import pandas as pd
        from sqlalchemy import create_engine

        # Sample data
        data = {"id": [1, 2, 3], "name": ["Alice", "Bob", "Charlie"]}
        df = pd.DataFrame(data)

        # Create SQLAlchemy engine
        engine = create_engine("sqlite:///example.db")

        # Upload DataFrame to SQL table
        upload_dataframe(df, "users", engine, mode="append")
        ```

    Docstring by ChatGPT.
    """
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


# %% [markdown]
# ## Function: api_update
#


# %%
def api_update(
    travel_times_url, traffic_alerts_url, weather_information_url, access_key
):
    """
    Fetches and updates travel times, traffic alerts, and weather information from APIs.

    This function retrieves data from three API endpoints (travel times, traffic alerts,
    and weather information) using the provided access key. The retrieved data is
    processed, timestamped, and formatted before being returned.

    Args:
        travel_times_url (str): The API URL for fetching travel time data.
        traffic_alerts_url (str): The API URL for fetching traffic alert data.
        weather_information_url (str): The API URL for fetching weather information.
        access_key (str): The API access key required for authentication.

    Returns:
        tuple: A tuple containing:
            - pd.DataFrame: `df_api_fetch` - A summary DataFrame containing response
              statuses and timestamps.
            - pd.DataFrame: `df_tt` - The travel times data with a timestamp column.
            - pd.DataFrame: `df_ta` - The traffic alerts data with a timestamp column.
            - pd.DataFrame: `df_wa` - The weather information data with a timestamp column.
            - str: The status of the API fetch operation ("Success" or "Failed").

    Example:
        ```python
        travel_url = "https://api.example.com/travel_times?key={ACCESSCODE}"
        traffic_url = "https://api.example.com/traffic_alerts?key={ACCESSCODE}"
        weather_url = "https://api.example.com/weather_info?key={ACCESSCODE}"
        access_key = "your_api_key"

        df_api_fetch, df_tt, df_ta, df_wa, status = api_update(
            travel_url, traffic_url, weather_url, access_key
        )

        print(df_api_fetch)
        print(f"API update status: {status}")
        ```

    Docstring by ChatGPT.
    """
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


# %% [markdown]
# # Extract APIs and Load to MySQL Database
#

# %% [markdown]
# ## Function: extract_load_transform
#


# %%
def extract_load_transform():
    """
    Extracts data from APIs, loads it into a database, and performs transformations.

    This function automates the ETL (Extract, Load, Transform) process by:
    1. Fetching travel time, traffic alert, and weather data from APIs.
    2. Storing the fetched data into history tables in a database.
    3. Updating raw tables with the latest data if the API fetch was successful.
    4. Calling stored procedures to transform and process the raw data.

    The function logs each step and handles database transactions using SQLAlchemy.
    If an error occurs, it logs the failure and returns `None`.

    Args:
        None

    Returns:
        None: The function performs operations on the database but does not return a value.

    Process Flow:
        - Fetch API data using `api_update()`.
        - Store data in history tables (`api_fetch_hist`, `time_travel_hist`, etc.).
        - If the API fetch is successful, replace raw tables with new data.
        - Call stored procedures (`TransformTravelTime`, `TransformTrafficAlerts`, etc.).
        - Log operations and handle exceptions.

    Example Usage:
        ```python
        extract_load_transform()
        ```

    Docstring by ChatGPT.
    """
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


# %% [markdown]
# ## Call extract_load_transform function
#

# %%
extract_load_transform()
