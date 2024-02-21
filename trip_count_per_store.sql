-- query to pull the frequency of shopping per store: 

select * from store; 
select * from trips; 

SELECT s.name, count(t.date)
FROM store as s
JOIN trips as t 
ON s.id = t.store_id
GROUP BY name ;
