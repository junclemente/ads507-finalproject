SHOW DATABASES;
USE api_fetch_raw;

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
   -- Clear existing data in the log
TRUNCATE TABLE monitoring_refresh_log;

-- Insert Traffic Alerts Monitoring
INSERT INTO monitoring_refresh_log (table_name, last_refresh, last_updated, days_difference)
SELECT 
    'Traffic Alerts', 
    MAX(last_refresh) - INTERVAL 8 HOUR,  -- Convert PST to UTC
    MAX(updated),  -- Already in UTC
    TIMESTAMPDIFF(DAY, MAX(last_refresh) - INTERVAL 8 HOUR, MAX(updated)) 
FROM traffic_alerts_dim
WHERE last_refresh IS NOT NULL AND updated IS NOT NULL;

-- Insert Weather Alerts Monitoring
INSERT INTO monitoring_refresh_log (table_name, last_refresh, last_updated, days_difference)
SELECT 
    'Weather Alerts', 
    MAX(last_refresh) - INTERVAL 8 HOUR,  
    MAX(updated),  
    TIMESTAMPDIFF(DAY, MAX(last_refresh) - INTERVAL 8 HOUR, MAX(updated)) 
FROM weather_alerts_dim
WHERE last_refresh IS NOT NULL AND updated IS NOT NULL;

-- Insert Travel Time Alerts Monitoring
INSERT INTO monitoring_refresh_log (table_name, last_refresh, last_updated, days_difference)
SELECT 
    'Travel Time Alerts', 
    MAX(last_refresh) - INTERVAL 8 HOUR,  
    MAX(updated),  
    TIMESTAMPDIFF(DAY, MAX(last_refresh) - INTERVAL 8 HOUR, MAX(updated)) 
FROM time_travel_dim
WHERE last_refresh IS NOT NULL AND updated IS NOT NULL;

END $$

DELIMITER ;

-- Run the monitoring procedure
CALL update_monitoring_log();

SELECT * FROM monitoring_refresh_log;
