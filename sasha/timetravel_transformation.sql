CREATE DEFINER=`sashal`@`%` PROCEDURE `TransformTravelTime`()
BEGIN
    -- Clear existing data
    TRUNCATE TABLE time_travel_dim;

    -- Insert transformed data
    INSERT INTO time_travel_dim (
        tt_id,
        avg_time,
        cur_time,
        distance,
        end_lat,
        end_long,
        end_loc_key,
        end_mp,
        end_road_key,
        end_direction,
        start_lat,
        start_long,
        start_loc_key,
        start_mp,
        start_road_key,
        start_direction,
        alert_time,
        updated,
        last_refresh
    )
    SELECT
        -- Straight pull
        traveltimeid AS tt_id,
        averagetime AS avg_time,
        currenttime AS cur_time, 
        distance, 
        
        -- Endpoint extraction 
        JSON_UNQUOTE(JSON_EXTRACT(endpoint, '$.Latitude')) AS end_lat,
        JSON_UNQUOTE(JSON_EXTRACT(endpoint, '$.Longitude')) AS end_long,
         -- Create hashed end_loc_key
        MD5(CONCAT(
            IFNULL(ROUND(JSON_UNQUOTE(JSON_EXTRACT(endpoint, '$.Latitude')), 3), '0'), 
            IFNULL(ROUND(JSON_UNQUOTE(JSON_EXTRACT(endpoint, '$.Longitude')), 3), '0')
        )) AS end_loc_key,
        -- endpoint xtraction continue
        JSON_UNQUOTE(JSON_EXTRACT(endpoint, '$.MilePost')) AS end_mp,
        -- map roadname from road_lookup to standardize
        (SELECT road_key FROM road_lookup WHERE JSON_UNQUOTE(JSON_EXTRACT(endpoint, '$.RoadName')) = raw_road_name LIMIT 1) AS end_road_key,
		-- endpoint extraction continue
        JSON_UNQUOTE(JSON_EXTRACT(endpoint, '$.Direction')) AS end_direction,
        -- Startpoint extraction 
        JSON_UNQUOTE(JSON_EXTRACT(startpoint, '$.Latitude')) AS start_lat,
        JSON_UNQUOTE(JSON_EXTRACT(startpoint, '$.Longitude')) AS start_long,
        -- Create hashed start_loc_key
        MD5(CONCAT(
            IFNULL(ROUND(JSON_UNQUOTE(JSON_EXTRACT(startpoint, '$.Latitude')), 3), '0'), 
            IFNULL(ROUND(JSON_UNQUOTE(JSON_EXTRACT(startpoint, '$.Longitude')), 3), '0')
        )) AS start_loc_key,
        -- startpoint extraction continue
        JSON_UNQUOTE(JSON_EXTRACT(startpoint, '$.MilePost')) AS start_mp,
        -- roadmap 
        (SELECT road_key FROM road_lookup WHERE JSON_UNQUOTE(JSON_EXTRACT(startpoint, '$.RoadName')) = raw_road_name LIMIT 1) AS start_road_key,
        -- startpoint extraction continue
        JSON_UNQUOTE(JSON_EXTRACT(startpoint, '$.Direction')) AS start_direction, 
        
        -- Convert timeupdates from UNIX
        FROM_UNIXTIME(SUBSTRING_INDEX(SUBSTRING_INDEX(timeupdated, '(', -1), '-', 1) / 1000) AS alert_time,

        -- Other direct mappings
        timestamp AS updated, 
        
        -- Add timestamp for update
        NOW() AS last_refresh
    FROM time_travel_raw;

END