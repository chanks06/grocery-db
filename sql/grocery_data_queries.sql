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

-- I want to learn about my milk buying habits...

select * from items where product_name like "%milk%";

--mkay that's cool but I want to know when I purchased these items so I gotta join trips table: 

select i.product_name, i.total_price, t.date from items as i 
join trips as t on i.trip_id = t.id
where product_name like "%milk%" and product_name not like "bun";

-- did i not buy anymore oatmilk?
select * from items where product_name like '%oat%';

--why does it look like I bought 10 lbs of oats twice within the same week???

select i.trip_id,i.product_name, i.total_price, t.date from items as i 
join trips as t on i.trip_id = t.id
where product_name like "%oat%";

select * from items where (trip_id = 18 or trip_id = 21) and product_name like "%oat%";
