select * from grocery.store;

select * from grocery.trips
order by id desc;


-- costco trips 4/24

insert into grocery.trips (store_id, date, total_cost)
values 
(8,'2024-04-24',25.52);

insert into grocery.items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku, weight_oz)
VALUES
(67, 'BANANAS', 'PC',1,1.99,1.99,30669,48),
(67, 'VARIETY MUFFINS', 'PC',1,9.99,9.99,24311,NULL),
(67, 'SANDWICH', 'PC',1,13.54,13.54,28831,NULL);


--winco 5/18
insert into grocery.trips (store_id, date, total_cost)
values 
(2,'2024-05-18',19.37);

insert into grocery.items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku, weight_oz)
VALUES
(68, 'BANANAS', 'LBS',2.46,.59,1.45,4011,36),
(68, 'ORG TOMATOES','PC',1,3.98,3.98,66779600111,NULL),
(68, 'EGGPLANT', 'PC',1,.68,.68,4081,NULL),
(68, 'SANDWICH AMERICAN','PC',1,2.98,2.98,26731000000,NULL),
(68, 'BELL PEPPER YELLOW', 'PC',1,.78,.78,4689,NULL),
(68, 'BELL PEPPER ORANGE', 'PC',1,.78,.78,3121,NULL),
(68, 'BROCCOLI','LBS',1.83,1.68,3.07,4548,28),
(68, 'WINCO CRACKERS', 'PC',1,2.48,2.48,7055250191,NULL),
(68, 'GARLIC CLOVE', 'PC',1,.68,.68,4608,NULL),
(68, 'CAULIFLOWER','LBS',2.54,.98,2.49,3338369999,40);

--COSTCO 5/18
insert into grocery.trips (store_id, date, total_cost)
values 
(8,'2024-05-18',212.38);

insert into grocery.items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku, weight_oz)
VALUES
(69, 'KS BATH TISSUE', 'PC',1,19.99,19.99,626016,NULL),
(69, 'TIDE DETERGENT', 'PC',1,19.49,19.49,3223955,NULL),
(69, 'DAVES KILLER BREAD 2 PK', 'PC',1,9.49,9.49,512447,NULL),
(69, 'SENSODYNE TOOTHPASTE 4 PK', 'PC',1,25.99,25.99,1450843,NULL),
(69, 'SUMMER PASTA', 'PC',1,11.49,11.49,864984,NULL),
(69, 'SARDINES IN OIL', 'PC',1,10.99,10.99,180973,NULL),
(69, 'KS COLD BREW', 'PC',1,16.69,16.69,4165758,NULL),
(69, 'KS QUINOA', 'PC',1,9.99,9.99,1001368,NULL),
(69, 'AVOCADO OIL MAYO', 'PC',1,9.59,9.59,1772246,NULL),
(69, 'KS MEXICO COFFEE', 'PC',1,14.99,14.99,1585601,NULL),
(69, 'ASCENT PROTEIN POWDER', 'PC',1,54.99,54.99,1666598,NULL);


SELECT 15.49 + 1.2; 
