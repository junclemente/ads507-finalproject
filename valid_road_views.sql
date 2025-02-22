SHOW DATABASES;
USE api_fetch_raw;


CREATE VIEW valid_traffic_roads AS
SELECT *
FROM traffic_alerts_dim
WHERE start_road_key IS NOT NULL OR end_road_key IS NOT NULL ;

CREATE VIEW valid_weather_roads AS 
SELECT *
FROM weather_alerts_dim
WHERE road_key IS NOT NULL;

CREATE VIEW valid_travel_roads AS 
SELECT * 
FROM time_travel_dim
WHERE start_road_key IS NOT NULL OR end_road_key IS NOT NULL ;
      