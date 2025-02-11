CREATE DEFINER=`sashal`@`%` PROCEDURE `TransformTravelTime`()
BEGIN
    -- Clear existing data
    TRUNCATE TABLE time_travel_dim;

    -- Insert transformed data
    INSERT INTO time_travel_dim (
        tt_id,
        avg_time,
        cur_time,
        note,
        distance,
        end_lat,
        end_long,
        end_mp,
        end_roadname,
        end_direction,
        start_lat,
        start_long,
        start_mp,
        start_roadname,
        start_direction,
        alert_time,
        updated,
        table_refresh
    )
    SELECT
        -- Straight pull
        traveltimeid AS tt_id,
        averagetime AS avg_time,
        currenttime AS cur_time, 
        note, 
        distance, 
        
        -- Endpoint extraction 
        JSON_UNQUOTE(JSON_EXTRACT(endpoint, '$.Latitude')) AS end_lat,
        JSON_UNQUOTE(JSON_EXTRACT(endpoint, '$.Longitude')) AS end_long,
        JSON_UNQUOTE(JSON_EXTRACT(endpoint, '$.Milepost')) AS end_mp,
        JSON_UNQUOTE(JSON_EXTRACT(endpoint, '$.RoadName')) AS end_roadname,
        JSON_UNQUOTE(JSON_EXTRACT(endpoint, '$.Direction')) AS end_direction,

        -- Startpoint extraction 
        JSON_UNQUOTE(JSON_EXTRACT(startpoint, '$.Latitude')) AS start_lat,
        JSON_UNQUOTE(JSON_EXTRACT(startpoint, '$.Longitude')) AS start_long,
        JSON_UNQUOTE(JSON_EXTRACT(startpoint, '$.Milepost')) AS start_mp,
        JSON_UNQUOTE(JSON_EXTRACT(startpoint, '$.RoadName')) AS start_roadname,
        JSON_UNQUOTE(JSON_EXTRACT(startpoint, '$.Direction')) AS start_direction, 
        
        -- Convert timeupdates from UNIX
        FROM_UNIXTIME(SUBSTRING_INDEX(SUBSTRING_INDEX(timeupdated, '(', -1), '-', 1) / 1000) AS alert_time,

        -- Other direct mappings
        timestamp AS updated, 
        
        -- Add timestamp for update
        NOW() AS table_refresh
    FROM time_travel_raw;

END