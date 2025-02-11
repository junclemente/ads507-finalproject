CREATE DEFINER=`sashal`@`%` PROCEDURE `TransformWeatherAlerts`()
BEGIN
-- Clear existing data
TRUNCATE TABLE weather_alerts_dim;
-- insert the transformed data into
INSERT INTO weather_alerts_dim (
        ID, 
        barometric_pressure, 
        latitude, 
        longitude, 
        percipitation,
		reading_time,
        humidity, 
        sky_coverage,
        station_id, 
        road_name, 
        mp, 
        temp, 
        visibility, 
        wind_direction, 
        wind_gust_speed,
        avg_wind_speed,
        updated, 
        last_refresh
    ) 
SELECT 
     -- Explicitly reference weather_alerts_raw
     raw.id AS ID, 
     raw.barometricpressure AS barometric_pressure,
     raw.latitude,
     raw.longitude,
     
     -- Handle NULL values for percipitation
     COALESCE(CAST(raw.precipitationininches AS CHAR), 'UNKNOWN') AS percipitation,

     -- Convert UNIX timestamp to DATETIME
     FROM_UNIXTIME(SUBSTRING_INDEX(SUBSTRING_INDEX(raw.readingtime, '(', -1), '-', 1) / 1000) AS reading_time,

     -- Direct mapping
     raw.relativehumidity AS humidity,

     -- Handle NULL for sky coverage
     COALESCE(CAST(raw.skycoverage AS CHAR), 'UNKNOWN') AS sky_coverage,

     -- Direct mapping
     raw.stationid AS station_id,

     -- Map road name from stationname. REGEXP finds the pattern to extract from string.
     CASE 
        WHEN raw.stationname REGEXP 'I-[0-9]+' THEN SUBSTRING_INDEX(SUBSTRING_INDEX(raw.stationname, 'I-', -1), ' ', 1)
        WHEN raw.stationname REGEXP 'US-[0-9]+' THEN SUBSTRING_INDEX(SUBSTRING_INDEX(raw.stationname, 'US-', -1), ' ', 1)
        WHEN raw.stationname REGEXP 'SR[0-9]+' THEN SUBSTRING_INDEX(SUBSTRING_INDEX(raw.stationname, 'SR-', -1), ' ', 1)
        ELSE 'UNKNOWN'
    END AS road_name,

    -- Map mp from stationname. 
    CASE 
        WHEN raw.stationname REGEXP 'mp [0-9]+\\.[0-9]+' THEN 
            SUBSTRING_INDEX(SUBSTRING_INDEX(raw.stationname, 'mp ', -1), ' ', 1)
        ELSE 'UNKNOWN'
    END AS mp,

    -- Direct map temp
    raw.temperatureinfahrenheit AS temp, 
    raw.visibility, 
    raw.winddirectioncardinal AS wind_direction,
    raw.windgustspeedinmph AS wind_gust_speed,
    raw.windspeedinmph AS avg_wind_speed, 
    raw.timestamp AS updated, 

    -- Move last_refresh to the end, since it's not in raw
    NOW() AS last_refresh
FROM weather_alerts_raw AS raw;

END