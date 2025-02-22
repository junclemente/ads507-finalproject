CREATE DEFINER=`sashal`@`%` PROCEDURE `TransformTrafficAlerts`()
BEGIN
	-- check if data, if yes then truncate.
    IF EXISTS (SELECT 1 from traffic_alerts_dim LIMIT 1) THEN 
    TRUNCATE TABLE traffic_alerts_dim;

    -- Insert transformed data
    INSERT INTO traffic_alerts_dim (
        alertid,
        county,
        end_time,
        end_direction,
        end_lat,
        end_long,
        end_loc_key,
        end_mp,
        end_road_key,
        start_time,
        start_direction,  
        start_lat,
        start_long,
        start_loc_key,
        start_mp,
        start_road_key,
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

        -- Create hashed end_loc_key
        MD5(CONCAT(
            IFNULL(ROUND(JSON_UNQUOTE(JSON_EXTRACT(endroadwaylocation, '$.Latitude')), 3), '0'), 
            IFNULL(ROUND(JSON_UNQUOTE(JSON_EXTRACT(endroadwaylocation, '$.Longitude')), 3), '0')
        )) AS end_loc_key,

        JSON_UNQUOTE(JSON_EXTRACT(endroadwaylocation, '$.MilePost')) AS end_mp,
         -- end road_key mapped to road_lookup
        (SELECT road_key FROM road_lookup 
         WHERE JSON_UNQUOTE(JSON_EXTRACT(endroadwaylocation, '$.RoadName')) = raw_road_name 
         LIMIT 1) AS end_road_key,

        -- Convert starttime from Unix timestamp to DATETIME
        FROM_UNIXTIME(SUBSTRING_INDEX(SUBSTRING_INDEX(starttime, '(', -1), '-', 1) / 1000) AS start_time,

        -- Start location extraction
        JSON_UNQUOTE(JSON_EXTRACT(startroadwaylocation, '$.Direction')) AS start_direction,
        JSON_UNQUOTE(JSON_EXTRACT(startroadwaylocation, '$.Latitude')) AS start_lat,
        JSON_UNQUOTE(JSON_EXTRACT(startroadwaylocation, '$.Longitude')) AS start_long,

        -- Create hashed start_loc_key
        MD5(CONCAT(
            IFNULL(ROUND(JSON_UNQUOTE(JSON_EXTRACT(startroadwaylocation, '$.Latitude')), 3), '0'), 
            IFNULL(ROUND(JSON_UNQUOTE(JSON_EXTRACT(startroadwaylocation, '$.Longitude')), 3), '0')
        )) AS start_loc_key,

        JSON_UNQUOTE(JSON_EXTRACT(startroadwaylocation, '$.MilePost')) AS start_mp,
        -- start road_key mapped to road_lookup
        (SELECT road_key FROM road_lookup 
         WHERE JSON_UNQUOTE(JSON_EXTRACT(startroadwaylocation, '$.RoadName')) = raw_road_name 
         LIMIT 1) AS start_road_key,

        -- Other direct mappings
        eventcategory AS event_cat, 
        eventstatus AS event_stat, 
        headlinedescription AS event_desc, 
        priority, 
        region, 
        timestamp AS updated, 
        -- Add timestamp for update
        NOW() AS last_refresh
    FROM traffic_alerts_raw;
END IF;

END