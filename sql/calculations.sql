

-- time frame of the data colleted

--start date: 

SELECT min(date) FROM trips;

--2023-09-07

--last trip: 

SELECT max(date) FROM trips;
-- 2024-02-21

--duration 
select datediff(max(date), min(date))/30 from trips;
-- 167 days, or 5.6 months (almost 6 months of data! yahoo)

select * from items;

