CREATE DEFINER=`sashal`@`%` PROCEDURE `TransformWeatherAlerts`()
BEGIN
    TRUNCATE TABLE weather_alerts_dim;

    INSERT INTO weather_alerts_dim (
        ID, 
        barometric_pressure, 
        latitude, 
        longitude,
        loc_key,
        percipitation,
        reading_time,
        humidity, 
        sky_coverage,
        station_id, 
        raw_roadname,
        road_key, 
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
        raw.id AS ID, 
        raw.barometricpressure AS barometric_pressure,
        raw.latitude,
        raw.longitude,

        MD5(CONCAT(
            IFNULL(ROUND(raw.latitude, 3), '0'), 
            '_', 
            IFNULL(ROUND(raw.longitude, 3), '0')
        )) AS loc_key,

        COALESCE(CAST(raw.precipitationininches AS CHAR), 'UNKNOWN') AS percipitation,

        FROM_UNIXTIME(SUBSTRING_INDEX(SUBSTRING_INDEX(raw.readingtime, '(', -1), '-', 1) / 1000) AS reading_time,

        raw.relativehumidity AS humidity,

        COALESCE(CAST(raw.skycoverage AS CHAR), 'UNKNOWN') AS sky_coverage,

        raw.stationid AS station_id,

        CASE 
            WHEN raw.stationname REGEXP 'I-[0-9]+' THEN REGEXP_SUBSTR(raw.stationname, 'I-[0-9]+')
            WHEN raw.stationname REGEXP 'US [0-9]+' THEN REGEXP_SUBSTR(raw.stationname, 'US [0-9]+')
            WHEN raw.stationname REGEXP 'SR [0-9]+' THEN REGEXP_SUBSTR(raw.stationname, 'SR [0-9]+')
            ELSE 'UNKNOWN'
        END AS raw_roadname,

        (SELECT road_key FROM road_lookup 
         WHERE road_lookup.raw_road_name = 
            (CASE 
                WHEN raw.stationname REGEXP 'I-[0-9]+' THEN REGEXP_SUBSTR(raw.stationname, 'I-[0-9]+')
                WHEN raw.stationname REGEXP 'US [0-9]+' THEN REGEXP_SUBSTR(raw.stationname, 'US [0-9]+')
                WHEN raw.stationname REGEXP 'SR [0-9]+' THEN REGEXP_SUBSTR(raw.stationname, 'SR [0-9]+')
                ELSE 'UNKNOWN'
            END) 
         LIMIT 1) AS road_key,

        CASE 
            WHEN raw.stationname REGEXP 'mp [0-9]+\\.[0-9]+' THEN 
                SUBSTRING_INDEX(SUBSTRING_INDEX(raw.stationname, 'mp ', -1), ' ', 1)
            ELSE 'UNKNOWN'
        END AS mp,

        raw.temperatureinfahrenheit AS temp, 
        raw.visibility, 
        raw.winddirectioncardinal AS wind_direction,
        raw.windgustspeedinmph AS wind_gust_speed,
        raw.windspeedinmph AS avg_wind_speed, 
        raw.timestamp AS updated, 

        NOW() AS last_refresh
    FROM weather_alerts_raw AS raw;
END