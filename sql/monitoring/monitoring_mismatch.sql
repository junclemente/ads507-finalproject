SHOW DATABASES;
USE api_fetch_raw;

-- Run transformations before checking refresh times
CALL TransformTrafficAlerts();
CALL TransformWeatherAlerts();
CALL TransformTravelTime();

  -- Create the monitoring table
CREATE TABLE monitoring_mismatched_log (
    id INT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(50) NOT NULL,
    mismatched_records INT NOT NULL
    );
  
DELIMITER $$

CREATE PROCEDURE update_mismatched_log()
Begin 
-- Clear existing data
TRUNCATE TABLE monitoring_mismatched_log;

-- Insert Traffic Alerts
INSERT INTO monitoring_mismatched_log( table_name, mismatched_records)
SELECT 
    'Traffic Alerts' AS table_name,
    COUNT(*) AS mismatched_records
FROM traffic_alerts_dim dim
JOIN traffic_alerts_raw raw ON dim.alertid = raw.AlertID
WHERE dim.updated <> raw.timestamp;

-- Insert Weather Alerts
INSERT INTO monitoring_mismatched_log( table_name, mismatched_records)
SELECT 
    'Weather Alerts' AS table_name,
    COUNT(*) AS mismatched_records
FROM weather_alerts_dim dim
JOIN weather_alerts_raw raw ON dim.station_id = CAST(raw.StationID AS CHAR)
WHERE dim.updated <> raw.timestamp;

-- Insert Time Travel Alerts
INSERT INTO monitoring_mismatched_log( table_name, mismatched_records)
SELECT 
    'Time Travel Alerts' AS table_name,
    COUNT(*) AS mismatched_records
FROM time_travel_dim dim
JOIN time_travel_raw raw ON dim.tt_id = raw.TravelTimeID
WHERE dim.updated <> raw.timestamp;

END $$
DELIMITER ;

Call update_mismatched_log();

SELECT * FROM monitoring_mismatched_log