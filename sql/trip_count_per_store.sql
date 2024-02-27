-- query to pull the frequency of shopping per store: 

select * from store; 
select * from trips; 

SELECT s.name, count(t.date)
FROM store as s
JOIN trips as t 
ON s.id = t.store_id
GROUP BY name ;


select * from trips;
select * from store; 

create table trips_store_name AS

    select t.id, t.date, t.total_cost, s.name from trips as t
    join store as s on s.id = t.store_id
    order by date ASC;

show tables; 