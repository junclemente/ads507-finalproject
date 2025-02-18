SHOW DATABASES;
USE api_fetch_raw;

-- Run transformations before checking refresh times
CALL TransformTrafficAlerts();
CALL TransformWeatherAlerts();
CALL TransformTravelTime();

-- Check structure
DESCRIBE traffic_alerts_raw;
DESCRIBE traffic_alerts_dim;
DESCRIBE weather_alerts_dim;
DESCRIBE time_travel_dim;

-- Select current data
SELECT * FROM traffic_alerts_raw;
SELECT * FROM traffic_alerts_dim;
SELECT * FROM weather_alerts_dim;
SELECT * FROM time_travel_dim;

-- Create the monitoring table
CREATE TABLE monitoring_refresh_log (
    id INT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(50) NOT NULL,
    last_refresh DATETIME NOT NULL,
    last_updated DATETIME NOT NULL,
    days_difference INT NOT NULL
    );
  
DELIMITER $$

CREATE PROCEDURE update_monitoring_log()
BEGIN

-- Clear existing data
    TRUNCATE TABLE monitoring_refresh_log;

-- Insert Traffic Alerts Monitoring
INSERT INTO monitoring_refresh_log( table_name, last_refresh, last_updated, days_difference)
SELECT 
	'Traffic Alerts' AS table_name,
    MAX(last_refresh) AS last_refresh,
    MAX(updated) AS last_updated,
    TIMESTAMPDIFF(DAY, MAX(last_refresh), MAX(updated)) AS days_difference 
FROM traffic_alerts_dim
WHERE last_refresh IS NOT NULL AND updated IS NOT NULL;

-- Insert Weather Alerts Monitoring
INSERT INTO monitoring_refresh_log( table_name, last_refresh, last_updated, days_difference)
SELECT 
	'Weather Alerts' AS table_name,
    MAX(last_refresh) AS last_refresh,
    MAX(updated) AS last_updated,
    TIMESTAMPDIFF(DAY, MAX(last_refresh), MAX(updated)) AS days_difference 
FROM weather_alerts_dim
WHERE last_refresh IS NOT NULL AND updated IS NOT NULL;

-- Insert Travel Time Alerts Monitoring
INSERT INTO monitoring_refresh_log( table_name, last_refresh, last_updated, days_difference)
SELECT 
	'Travel Time Alerts' AS table_name,
    MAX(last_refresh) AS last_refresh,
    MAX(updated) AS last_updated,
    TIMESTAMPDIFF(DAY, MAX(last_refresh), MAX(updated)) AS days_difference 
FROM time_travel_dim
WHERE last_refresh IS NOT NULL AND updated IS NOT NULL;

END $$
DELIMITER ; 

-- Run the monitoring procedure
CALL update_monitoring_log();

SELECT * FROM monitoring_refresh_log;