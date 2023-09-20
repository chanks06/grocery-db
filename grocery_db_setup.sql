/* GROCERY DATABASE INITIALIZATION */

-- Creating database 

CREATE DATABASE grocery; 
USE grocery; 

/* Creating 3 tables: 

1. trips - each row is a unique trip to the grocery store 
2. store - each row is a unique grocery store
3. items - items purchased

*/ 

CREATE TABLE trips 
( id SMALLINT auto_increment PRIMARY KEY, 
  store_id smallint, 
  date date, 
  total_cost numeric(5,2)); 

CREATE TABLE store
( id SMALLINT auto_increment PRIMARY KEY, 
  name varchar (50),
  address varchar (50)); 

CREATE TABLE items
( trip_id SMALLINT,
  product_name varchar(50),
  quantity_unit varchar(10),
  quantity numeric(3,2),
  price_per_unit numeric(4,2), 
  total_price numeric(4,2), 
  CONSTRAINT pk_items PRIMARY KEY (trip_id, product_name));


-- creating foreign key in trips(store_id) to reference store(id):

ALTER TABLE trips 
ADD CONSTRAINT fk_store FOREIGN KEY (store_id) REFERENCES store(id); 

--creating foriegn key in items to refer to to trip_id 

ALTER TABLE items ADD CONSTRAINT fk_items FOREIGN KEY (trip_id) REFERENCES trips (id); 

-- Entering Data into Tables 

INSERT INTO store (name, address)
VALUES ('Fred Meyer', '3805 SE Hawthorne Blvd'), ('Winco', '7979 SE Powell Blvd');

-- entering trip data (I currently have two receipts to enter):

INSERT INTO trips (store_id, date, total_cost)
VALUES (1, '2023-09-07',18.65), 
       (2, '2023-09-11',51.75);

-- item Data

--RECEIPT 1: FRED MEYERS 9/07/2023: 

INSERT INTO items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price)
VALUES
(1, 'KROGER SUPER', 'PC', 1, 2.50,2.50), 
(1, 'LACINATO KALE', 'PC', 1, 1.99,1.99),
(1, 'NECTARINES ORGANIC', 'LBS', 1.60, 3.49,5.55),
(1, 'APPLES COSMIC CRISP', 'LBS', 2.79, 2.50, 6.92),
(1, 'BANANAS', 'LBS', 2.53, .65, 1.64);

--- ADDING SKU COLUMN TO ITEMS Tables

ALTER TABLE items ADD COLUMN sku varchar(20);

-- ADDING SKU NUMBERS FOR RECEPT 1:

UPDATE items
SET sku = '1111002660'
WHERE product_name LIKE '%super%';

UPDATE items
SET sku = '81490501036'
WHERE product_name LIKE '%KALE%';

UPDATE items
SET sku = '74183993035'
WHERE product_name LIKE '%NECTARINES%';

UPDATE items
SET sku = '84747300763'
WHERE product_name LIKE '%APPLES%';

UPDATE items
SET sku = '64312604011'
WHERE product_name LIKE '%BANANAS%';



-- RECEIPT 2: WINCO 9/11/2023:

INSERT INTO items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(2, 'ORGANIC MILK WINCO HALF GAL', 'PC', 1, 3.98,3.98, '7055240622'), 
(2, 'FLATBREAD PIZZA DELI ', 'PC', 1, 4.48,4.48,'26610100000'),
(2, 'EGGS 1 DZ ORGANIC', 'PC', 1, 5.99,5.99,'73692130008'),
(2, 'COOKIES', 'PC', 2, 1.68, 3.36,'7055250119'),
(2, 'CHICKEN THIGHS', 'PC', 1, 4.28, 4.28,'2410559205'),
(2, 'BREAD DAVES KILLER', 'PC', 1, 5.88, 5.88,'1376402705'),
(2, 'DATES MEDJOOL', 'LBS', .63, 5.98, 3.77,'2465'),
(2, 'RXBAR', 'PC', 4, 1.98, 7.92,'85777700469'),
(2, 'FIG BLK MISSION', 'LBS', .61, 5.58, 3.40,'2307'),
(2, 'MACADAMIA NUTS', 'LBS', .60, 7.58, 4.55,'2201'),
(2, 'CHOBANI FLIP', 'PC', 3, 1.38, 4.14,'81829001919');

-- okay! The database is up to date. Let's write a query with a join to confirm its functionality: 

SELECT PRODUCT_NAME, TOTAL_PRICE, TOTAL_COST FROM ITEMS AS I
INNER JOIN TRIPS AS T ON I.TRIP_ID = T.ID
WHERE TRIP_ID = 1;

-- 9/13/2023: Adding RECEIPT 3, US FOODS 

INSERT INTO store (name, address)
VALUES 
('US FOODS CHEFSTORE', '731 SE Stephens St');

INSERT INTO trips (store_id, date, total_cost)
VALUES  
(3, '2023-09-12', 35.36);

INSERT INTO ITEMS (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(3, 'NITRILE GLOVES','PC',1,7.99,7.99,'9102289'), 
(3, 'SPONGES','PC',1,4.49,4.49,'7370695'), 
(3, 'DAWN POT & PAN','PC',1,17.19,17.19,'6613906'), 
(3, 'SQUEEZE BOTTLES','PC',1,5.69,5.69,'9917045');


#####################

USE grocery;
select * from store; --checking db connection 

-- RECEPT 3: Trader Joes 9/18/2023

--entering new store

INSERT INTO store (name, address)
VALUES 
('Trader Joes','4121 NE Halsey St');

INSERT INTO trips (store_id, date, total_cost)
VALUES  
(4, '2023-09-17', 57.56);

INSERT INTO ITEMS (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(4, 'PASTA SPAGHETTI','PC',1,.99,.99,null), 
(4, 'ORG TOMATO BASIL MARINARA','PC',1,3.49,3.49,null), 
(4, 'RICE CAKES','PC',1,3.49 ,3.49,null), 
(4, 'POPCORN','PC',1,2.79,2.79,null),
(4, 'PEANUT BUTTER PRETZELS','PC',1,2.49,2.49,null), 
(4, 'FROZEN PIZZA PARLANNO','PC',1,5.49,5.49,null), 
(4, 'DARK CHOCOLATE PEANUT BUTTER CUPS','PC',1,4.49,4.49,null), 
(4, 'PASTA RAVIOLI','PC',1,3.99,3.99,null),
(4, 'TEMPEH ORG 3 GRAIN','PC',1,2.29,2.29,null), 
(4, 'FROZEN GYOZA PORK','PC',1,3.99,3.99,null), 
(4, 'RIBEYE STEAK ORG','PC',1,14.99,14.99,null), 
(4, 'BAKED CHEESE CRUNCHIES','PC',1,2.49,2.49,null),
(4, 'TEA GINGER TURMERIC ORG','PC',1,2.99,2.99,null), 
(4, 'TEA IRISH BREAKFAST 80 CT','PC',1,3.49,3.49,null); 

SELECT * FROM ITEMS; 

-- WINCO RECEIPT: 9/19/23