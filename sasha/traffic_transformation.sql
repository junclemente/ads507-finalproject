CREATE DEFINER=`sashal`@`%` PROCEDURE `TransformTrafficAlerts`()
BEGIN
    -- Clear existing data
    TRUNCATE TABLE traffic_alerts_dim;

    -- Insert transformed data
    INSERT INTO traffic_alerts_dim (
        alertid,
        county,
        end_time,
        end_direction,
        end_lat,
        end_long,
        end_mp,
        end_roadname,
        start_time,
        start_direction,  
        start_lat,
        start_long,
        start_mp,
        start_roadname,
        event_cat,
        event_stat,
        event_desc,
        priority,
        region,
        updated, 
        last_refresh
    )
    SELECT
        alertid,
        county,
        -- Convert endtime from Unix timestamp to DATETIME
        FROM_UNIXTIME(SUBSTRING_INDEX(SUBSTRING_INDEX(endtime, '(', -1), '-', 1) / 1000) AS end_time,

        -- End location extraction
        JSON_UNQUOTE(JSON_EXTRACT(endroadwaylocation, '$.Direction')) AS end_direction,
        JSON_UNQUOTE(JSON_EXTRACT(endroadwaylocation, '$.Latitude')) AS end_lat,
        JSON_UNQUOTE(JSON_EXTRACT(endroadwaylocation, '$.Longitude')) AS end_long,
        JSON_UNQUOTE(JSON_EXTRACT(endroadwaylocation, '$.Milepost')) AS end_mp,
        JSON_UNQUOTE(JSON_EXTRACT(endroadwaylocation, '$.RoadName')) AS end_roadname,

        -- Convert starttime from Unix timestamp to DATETIME
        FROM_UNIXTIME(SUBSTRING_INDEX(SUBSTRING_INDEX(starttime, '(', -1), '-', 1) / 1000) AS start_time,

        -- Start location extraction
        JSON_UNQUOTE(JSON_EXTRACT(startroadwaylocation, '$.Direction')) AS start_direction,
        JSON_UNQUOTE(JSON_EXTRACT(startroadwaylocation, '$.Latitude')) AS start_lat,
        JSON_UNQUOTE(JSON_EXTRACT(startroadwaylocation, '$.Longitude')) AS start_long,
        JSON_UNQUOTE(JSON_EXTRACT(startroadwaylocation, '$.Milepost')) AS start_mp,
        JSON_UNQUOTE(JSON_EXTRACT(startroadwaylocation, '$.RoadName')) AS start_roadname,

        -- Other direct mappings
        eventcategory AS event_cat, 
        eventstatus AS event_stat, 
        headlinedescription AS event_desc, 
        priority, 
        region, 
        timestamp AS updated, 
        -- add timestamp for update
        NOW() AS last_refresh
    FROM traffic_alerts_raw;

END