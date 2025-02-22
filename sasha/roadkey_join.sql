SELECT 
    w.road_key AS road_key,
    COUNT(DISTINCT w.id) AS weather_count,
    COUNT(DISTINCT t.tt_id) AS travel_count,
    COUNT(DISTINCT ta.alertid) AS traffic_count
FROM weather_alerts_dim w
LEFT JOIN time_travel_dim t ON w.road_key = t.start_road_key OR w.road_key = t.end_road_key
LEFT JOIN traffic_alerts_dim ta ON w.road_key = ta.start_road_key OR w.road_key = ta.end_road_key
GROUP BY w.road_key
ORDER BY weather_count DESC, travel_count DESC, traffic_count DESC;