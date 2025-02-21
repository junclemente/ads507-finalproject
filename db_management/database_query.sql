-- Active: 1740168998050@@ads507-finalproject.mysql.database.azure.com@3306@api_fetch_raw
show databases;

SELECT user, host FROM mysql.user;

show databases;

use api_fetch_raw;

show tables;

select * from application_logs limit 20;

select * from api_fetch_hist limit 10;

select * from api_fetch limit 10;