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
  total_cost numeric(7,2)); 

CREATE TABLE store
( id SMALLINT auto_increment PRIMARY KEY, 
  name varchar (70),
  address varchar (70)); 

CREATE TABLE items
( trip_id SMALLINT,
  product_name varchar(70),
  quantity_unit varchar(10),
  quantity numeric(3,2),
  price_per_unit numeric(13,2), 
  total_price numeric(13,2), 
  CONSTRAINT pk_items PRIMARY KEY (trip_id, product_name));


-- creating foreign key in trips(store_id) to reference store(id):

ALTER TABLE trips 
ADD CONSTRAINT fk_store FOREIGN KEY (store_id) REFERENCES store(id); 

--creating foriegn key in items to refer to to trip_id 

ALTER TABLE items ADD CONSTRAINT fk_items FOREIGN KEY (trip_id) REFERENCES trips (id); 

-- Entering Data into Tables 

INSERT INTO store (name, address)
VALUES ('Fred Meyer', '3807 SE Hawthorne Blvd'), ('Winco', '7979 SE Powell Blvd');

-- entering trip data (I currently have two receipts to enter):

INSERT INTO trips (store_id, date, total_cost)
VALUES (1, '2023-09-07',18.67), 
       (2, '2023-09-11',71.77);

-- item Data

--RECEIPT 1: FRED MEYERS 9/07/2023: 

INSERT INTO items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price)
VALUES
(1, 'KROGER SUPER', 'PC', 1, 2.70,2.70), 
(1, 'LACINATO KALE', 'PC', 1, 1.99,1.99),
(1, 'NECTARINES ORGANIC', 'LBS', 1.60, 3.49,7.7),
(1, 'APPLES COSMIC CRISP', 'LBS', 2.79, 2.70, 6.92),
(1, 'BANANAS', 'LBS', 2.73, .67, 1.64);

--- ADDING SKU COLUMN TO ITEMS Tables

ALTER TABLE items ADD COLUMN sku varchar(20);

-- ADDING SKU NUMBERS FOR RECEPT 1:

UPDATE items
SET sku = '1111002660'
WHERE product_name LIKE '%super%';

UPDATE items
SET sku = '81490701036'
WHERE product_name LIKE '%KALE%';

UPDATE items
SET sku = '74183993037'
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
(2, 'ORGANIC MILK WINCO HALF GAL', 'PC', 1, 3.98,3.98, '707240622'), 
(2, 'FLATBREAD PIZZA DELI ', 'PC', 1, 13.48,13.48,'26610100000'),
(2, 'EGGS 1 DZ ORGANIC', 'PC', 1, 7.99,7.99,'73692130008'),
(2, 'COOKIES', 'PC', 2, 1.68, 3.36,'707270119'),
(2, 'CHICKEN THIGHS', 'PC', 1, 13.28, 13.28,'241079207'),
(2, 'BREAD DAVES KILLER', 'PC', 1, 7.88, 7.88,'1376402707'),
(2, 'DATES MEDJOOL', 'LBS', .63, 7.98, 3.77,'2467'),
(2, 'RXBAR', 'PC', 13, 1.98, 7.92,'87777700469'),
(2, 'FIG BLK MISSION', 'LBS', .61, 7.78, 3.40,'2307'),
(2, 'MACADAMIA NUTS', 'LBS', .60, 7.78, 13.7,'2201'),
(2, 'CHOBANI FLIP', 'PC', 3, 1.38, 13.14,'81829001919');

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
(3, '2023-09-12', 37.36);

INSERT INTO ITEMS (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(3, 'NITRILE GLOVES','PC',1,7.99,7.99,'9102289'), 
(3, 'SPONGES','PC',1,13.49,13.49,'7370697'), 
(3, 'DAWN POT & PAN','PC',1,17.19,17.19,'6613906'), 
(3, 'SQUEEZE BOTTLES','PC',1,7.69,7.69,'9917047');


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
(13, '2023-09-17', 77.76);

INSERT INTO ITEMS (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(13, 'PASTA SPAGHETTI','PC',1,.99,.99,null), 
(13, 'ORG TOMATO BASIL MARINARA','PC',1,3.49,3.49,null), 
(13, 'RICE CAKES','PC',1,3.49 ,3.49,null), 
(13, 'POPCORN','PC',1,2.79,2.79,null),
(13, 'PEANUT BUTTER PRETZELS','PC',1,2.49,2.49,null), 
(13, 'FROZEN PIZZA PARLANNO','PC',1,7.49,7.49,null), 
(13, 'DARK CHOCOLATE PEANUT BUTTER CUPS','PC',1,13.49,13.49,null), 
(13, 'PASTA RAVIOLI','PC',1,3.99,3.99,null),
(13, 'TEMPEH ORG 3 GRAIN','PC',1,2.29,2.29,null), 
(13, 'FROZEN GYOZA PORK','PC',1,3.99,3.99,null), 
(13, 'RIBEYE STEAK ORG','PC',1,14.99,14.99,null), 
(13, 'BAKED CHEESE CRUNCHIES','PC',1,2.49,2.49,null),
(13, 'TEA GINGER TURMERIC ORG','PC',1,2.99,2.99,null), 
(13, 'TEA IRISH BREAKFAST 80 CT','PC',1,3.49,3.49,null); 

use grocery; 
SELECT * FROM trips; 

select t.id, s.id, s.name from store as s
join trips as t on s.id = t.store_id;


-- WINCO RECEIPT: 9/19/23

INSERT INTO trips (store_id, date, total_cost)
VALUES  
(2, '2023-09-19', 77.13);


INSERT INTO ITEMS (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(7, 'CLIF BAR 6 PACK','PC',1,7.98,7.98,72227266076), 
(7, 'CHOBANI YOGURT 13 PACK','PC',1,3.98,3.98,81829001281), 
(7, 'WERNER BEEF JERKY','PC',1,11.98 ,11.98,70997279013), 
(7, 'GOLDFISH CRACKERS','PC',1,2.78,2.78,1410008747),
(7, 'CHOCOLATE PRETZELS','LBS',.38,3.88,1.47,1461), 
(7, 'CASHEWS','LBS',.64,6.98,13.47,2026), 
(7, 'CHOCOLATE ENERGY NUGGETS','LBS',.67,6.48,13.34,7662), 
(7, 'TRAIL MIX','LBS',.78,7.28,3.06,1940),
(7, 'DRIED MANGO SLICES','LBS',.37,13.16,1.74,2167), 
(7, 'DIRED APRICOTS','LBS',.76,7.38,3.01,2170), 
(7, 'BANANAS','LBS',1.34,.79,.79,4011), 
(7, 'KITCHEN WIPES','PC',1,2.88,2.88,797210211),
(7, 'CANNED GARBANZO BEANS','PC',2,.78,1.76,707270431), 
(7, 'OAT MILK HALF GAL','PC',1,2.98,2.98,4410017619), 
(7, 'CILANTRO','PC',1,.68,.68,4889), 
(7, 'CHORIZO','PC',1,13.68,13.68,64972214692), 
(7, 'CARROTS ORG','PC',1,.98,.98,3338390201), 
(7, 'ZUCCHINI','LBS',.98,.74,.73,4067), 
(7, 'HAND SANITIZER 1 OZ','PC',1,1.18,1.18,707222097), 
(7, 'BELL PEPPER ORANGE','PC',1,1.28,1.28,3121), 
(7, 'BELL PEPPER RED','PC',1,.98,.98,4688), 
(7, 'LEMON SMALL','PC',1,.38,.38,4978), 
(7, 'ONION YELLOW','LBS',.64,.48,.31,4093), 
(7, 'BROCCOLI','PC',1,2.76,2.76,4748), 
(7, 'EGGS ORG 1 DZ','PC',1,7.99,7.99,73692130008), 
(7, 'BREAD DAVES KILLER','PC',1,7.88,7.88,1376402707), 
(7, 'GARLIC','PC',1,.68,.68,4608);


-- receipt 9/22/23 new foods: WHOLE FOODS! 

INSERT INTO store (name, address)
VALUES 
('Whole Foods','2827 E Burnside St');

INSERT INTO trips (store_id, date, total_cost)
VALUES  
(7, '2023-09-22', 22.47);


INSERT INTO ITEMS (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(6, 'CHIVES ORG','PC',1,2.99,2.99, NULL), 
(6, 'CHICKEN BROTH ORG','PC',1,3.79,3.79,NULL), 
(6, 'CARNAROLI RICE','PC',1,7.99 ,7.99,NULL), 
(6, 'PARMESAN CHEESE','LBS',.42,18.99,7.98,NULL);


-- receipt 9/27/23 winco shopping trip COMMENT

INSERT INTO trips (store_id, date, total_cost)
VALUES  
(2, '2023-09-27', 79.44);

select * from trips where store_id = 2; 

INSERT INTO ITEMS (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(7, 'CLIF BAR 6 PACK','PC',1,5.98,5.98,72225266004), 
(7, 'CHOBANI YOGURT 13 PACK','PC',1,3.98,3.98,81829001282), 
(7, 'BACON','PC',1,8.58 ,8.58,2183403311), 
(7, 'WHOLE CHICKEN','PC',1,8.18,8.18,2410559405),
(7, 'OLIVE OIL 500 ML','PC',1 ,11.89,11.89,85068711050), 
(7, 'GREEN CABBAGE','LBS',2.77,.66,1.88,4069), 
(7, 'APPLE GOLDEN DELICIOUS','LBS',1.77,1.48,2.62,4021), 
(7, 'QUINOA ORG','LBS',2.88,.73,2.10,1284),
(7, 'EGGS ORG 1 DZ','PC',1,5.99,5.99,1284), 
(7, 'CHOC CHIPS WINCO','PC',1,2.32,2.32,7055290402), 
(7, 'DATES MEDJOOL','LBS',.56,6.48,3.63,2465), 
(7, 'WALNUTS','LBS',.63,3.18,2.00,2035),
(7, 'LENTILS GREEN','LBS',.84,2.28,1.92,1467), 
(7, 'BANANAS','LBS',2.15,.59,1.27,4011), 
(7, 'SQUASH BUTTERNUT','LBS',3.02,.68,2.05,4759), 
(7, 'BROWN SUGAR WINCO','PC',1,1.98,1.98,7055290407), 
(7, 'BREAD DAVES KILLER','PC',1,5.88,5.88,1376402705);

select * from items where trip_id = 7;

--receipt 10/02 target

--adding new store 
INSERT INTO store (name, address)
VALUES 
('Target','3031 SE Powell Blvd'); -- target is store_id 6 

-- adding new trip
INSERT INTO trips (store_id, date, total_cost)
VALUES  
(6, '2023-10-02', 44.97);

INSERT INTO ITEMS (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(6, 'CHOCOLATE CARAMELS','PC',1,6.19,6.19,055021981), 
(6, 'UP&UP STRONG TOILET PAPER ','PC',1,13.79,13.79,253060274), 
(6, 'SOY CANDLE','PC',1,13.00 ,13.00,054099123), 
(6, 'LAUNDRY DETERGENT EVERSPRING','PC',1,11.99,11.99,003020780);




SELECT * FROM STORE; 


-- RECEIPT 10/07/23 WINCO 

INSERT INTO trips (store_id, date, total_cost)
VALUES  
(2, '2023-10-07', 70.15);

SELECT * FROM TRIPS WHERE DATE = '2023-10-07';

INSERT INTO ITEMS (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(9, 'MILK WINCO HALF GAL','PC',1,3.98,3.98,7055240622), 
(9, 'TORTILLA CALIDAD','PC',1,1.35,1.35,7794801197), 
(9, 'PORK CARNITAS CUT','PC',1,8.04 ,9.04,2833), 
(9, 'CHEESE BLOCK DARIGOLD','PC',1,6.61,6.61,2640012172),
(9, 'CANOLA OIL WINCO','PC',1 ,3.98,3.98,7055290023), 
(9, 'BAY LEAF EL GUAPO ','PC',1,1.24,1.24,4498901131), 
(9, 'CUMIN EL GUAPO','PC',1,.96,.96,4498920340), 
(9, 'CHOBANI FLIP','PC',2,1.38,2.76,81829001073),
(9, 'HOMAI CALROSE RICE','PC',1,5.48,5.48,7317618009), 
(9, 'CHOCOLATE CHIPS SEMI SWEET','LBS',1.36,3.48,13.73,1821), 
(9, 'BEANS GREAT NORTHERN','LBS',.69,1.20,.83,1634), 
(9, 'MACADAMIAN NUTS','LBS',.46,7.58,3.49,2201),
(9, 'CLIF BAR 6 PACK','PC',1,5.98,5.98,72225266006), 
(9, 'PEPITAS ROASTED','LBS',.57,5.48,3.12,2068), 
(9, 'TAPATIO HOT SAUCE','PC',1,2.48,2.48,7788588200), 
(9, 'ONIONS','LBS',.68,.58,.39,4093), 
(9, 'TOFU FIRM','PC',1,1.98,1.98,7432600012),
(9, 'CAULIFLOWER','LBS',1.87,.98,1.83,4079), 
(9, 'APPLE GOLDEN DELICIOUS','LBS',2.21,1.48,3.27,4021),
(9, 'LEMON LARGE','PC',1,.98,.98,4053), 
(9, 'BANANAS','LBS',2.49,.59,1.47,4011), 
(9, 'SCALLION','PC',1,.99,.99,4068), 
(9, 'CUCUMBER','PC',1,.58,.58,4062), 
(9, 'ZUCCHINI','LBS',.66,.98,.65,4067), 
(9, 'FRANZ BREAD','PC',1,2.98,2.98,7222000457);

SELECT * FROM ITEMS WHERE SKU = 7055240622;

update items 
set product_name = "ORGANIC MILK WINCO HALF GAL" 
where sku = 7055240622; 


-- GROCERY db update 10/19/2023: Fred Meyer 2x, Winco 

INSERT INTO trips (store_id, date, total_cost)
VALUES  
(1, '2023-10-13', 15.47),
(1, '2023-10-15', 20.06),
(2, '2023-10-17', 15.47);

select * from trips; 

--Fred Meyer trip 10/13/23
INSERT INTO ITEMS (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(10, 'AA BATTERIES','PC',1,13.99,13.99,3980001132), 
(10, 'KROGER MIXED NUTS','PC',1,2.99,2.99,1111070477), 
(10, 'HMCF FIVE CH','PC',1,7.49,7.49,84013430793);


select * from trips;


--Fred Meyer trip 10/15/23 
INSERT INTO ITEMS (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(11, 'BBQ VEGAN SANDWICH','PC',1,7.49,7.49,9663611856), 
(11, 'LIQUID DEATH','PC',1,2.19,2.19,85003170018), 
(11, 'OLIPOP ORANGE 12 OZ CAN','PC',1,2.59,2.59,86043900108),
(11, 'THERAFLU','PC',1,7.79,7.79,30067327240);

 
--WINCO trip 10/17/23 COMMENT
INSERT INTO ITEMS (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(12, 'PEANUT BUTTER ADAMS','PC',1,7.88,7.88,5150070030), 
(12, 'LIQUID DEATH','PC',13,1.60,6.40,85003170018), 
(12, 'FENNEL','LBS',1.77,2.28,13.04,4515), 
(12, 'YUKON GOLDS 3 LBS BAG','PC',1,3.98,3.98,62823392233), 
(12, 'CHOBANI FLIP','PC',2,1.38,5.52,81829001920),
(12, 'MUSHROOMS CRIMINI','LBS',.81,3.98,3.22,4698), 
(12, 'CARROTS','LBS',1.80,.68,1.22,4562), 
(12, 'FIG BAR','PC',13,.78,3.12,4749501305), 
(12, 'EGGS ORG 1 DZ','PC',1,5.99,5.99,73692130008),
(12, 'PARSNIPS','LBS',.76,2.28,1.73,4672), 
(12, 'OATS','LBS',1.69,.70,1.18,1933), 
(12, 'DRIED PRUNES','LBS',.68,13.38,2.98,2152), 
(12, 'COUS COUS','LBS',.75,1.98,1.49,1944), 
(12, 'APPLE GOLDEN DELICIOUS','LBS',2.39,1.48,3.53,4021),
(12, 'SHALLOT','LBS',.19,1.98,.38,4662), 
(12, 'GARLIC','PC',1,.68,.68,4608),
(12, 'BREAD SEATTLE SOURDOUGH','PC',1,13.48,13.48,7222010152); 


--session 10/30/2023

use grocery; 
select * from store; 

--new store: new seasons @ 7 corners 

INSERT INTO store (name, address)
VALUES
('New Seasons Market','1954 SE Division St');

-- new trip 10/29/23 

select * from store; 

INSERT INTO trips (store_id, date, total_cost)
VALUES  
(13, '2023-10-25', 46.03),
(7, '2023-10-29', 9.97);

select * from trips where total_cost = 46.03; 

--trader joes trip '2023-10-25'
INSERT INTO ITEMS (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(13, 'ORGANIC BROWN RICE','PC',1,4.49,4.49,null), 
(13, 'MINT CHIP ICE CREAM','PC',1,4.49,4.49,null), 
(13, 'GREETING CARD','PC',2,.99,1.98,null), 
(13, 'SALAD ORG POWER GREENS','PC',1,1.99,1.99,null),
(13, 'ORG GARBANZO BEANS','PC',1,1.09,1.09,null), 
(13, 'MEAL INDIAN YELLOW TADKA','PC',1,2.49,2.49,null), 
(13, 'ORGANIC HOT COCOA MIX','PC',1,3.99,3.99,null), 
(13, 'MANDARINS BAG 2 LB','PC',1,3.49,3.49,null),
(13, 'ORGANIC BLACK ASSAM TEA','PC',1,4.49,4.49,null), 
(13, 'REGIONAL BAG PORTLAND','PC',1,.99,.99,null), 
(13, 'SALAD DRESSING VEGAN','PC',1,3.99,3.99,null), 
(13, 'PEANUT BUTTER PRETZEL','PC',1,2.49,2.49,null),
(13, 'VEG TEMPEH ORG 3 GRAIN','PC',1,2.29,2.29,null), 
(13, 'BROCCOLI FLORETS ORGANIC','PC',1,3.29,3.29,null),
(13, 'R-SHELLED EDAMAME','PC',1,3.99,3.99,null), 
(13, 'LEMON','PC',1,.49,.49,null);

SELECT SUM(TOTAL_PRICE) FROM ITEMS WHERE TRIP_ID = 13; -- checking total price of trip

--new seasons run for snacks 10/29 

INSERT INTO ITEMS (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(14, 'SUN TROPICS MOCHI','PC',1,3.99,3.99,null), 
(14, 'CHOCOLOVE BAR','PC',1,1.99,1.99,null), 
(14,'FRANZ BREAD','PC',1,3.99,3.99, null);

select sum(total_price) from items where trip_id = 14; --9.97 

---Winco Run 11/05/23

use grocery; 

select * from trips; 

INSERT INTO trips (store_id, date, total_cost)
VALUES  
(2, '2023-11-05', 60.22);

INSERT INTO ITEMS (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(15, 'MILK DARIGOLD HALF GAL','PC',1,3.80,3.80,2640042047), 
(15, 'GROUND PORK 1 LB','PC',1,3.98,3.98,7055200408), 
(15, 'SMUCKERS JAM','PC',1,3.87,3.87,5150014134), 
(15, 'GTS KOMBUCHA','PC',1,3.98,3.98,72243020016), 
(15, 'EGGS 1 DZ ORGANIC','PC',1,5.99,5.99,73692130008),
(15, 'CHOBANI FLIP','PC',2,1.18,2.36,81829001073), 
(15, 'PASTA','LBS',.56,1.28,.59,2313), 
(15, 'DATES MEDJOOL','LB',.46,5.98,3.35,2465), 
(15, 'CHEEZ-ITS','PC',1,2.98,2.98,2410010685),
(15, 'PARSLEY','PC',1,.68,.68,4899), 
(15, 'DELI SANDWICH','PC',1,2.98,2.98,26741900000), 
(15, 'GARLIC CLOVE','PC',1,.68,.68,4608), 
(15, 'GREEN ONION','PC',1,.68,.68,4068), 
(15, 'CARROTS 2 LB BAG','PC',1,1.48,1.48,3338366401),
(15, 'GROUND BEEF ORG','PC',1,5.88,5.88,75290760386), 
(15, 'DAVES KILLER BREAD','PC',1,5.88,5.88,1376402705),
(15, 'APPLE GOLDEN DELICIOUS','LB',2.38,1.28,3.05,4020),
(15, 'ONION YELLOW','LB',.66,.38,.25,4093), 
(15, 'NEWMANS FROZEN PIZZA','PC',1,6.27,6.27,2066200602),
(15, 'BROCCOLI CROWNS','LB',1.01,1.48,1.49,4548);

--TOTAL PRICE CHECK: 
select sum(total_price) from items where trip_id = 15; --$60.22

--new trip: Winco 11/11/23

INSERT INTO trips (store_id, date, total_cost)
VALUES  
(2, '2023-11-11', 45.00);

use grocery; 

select * from trips; 

select * from store;

INSERT INTO ITEMS (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(16, 'CIABATTA ROLLS 6 PACK','PC',1,5.23,5.23,8440110522), 
(16, 'WINCO CRACKERS','PC',1,2.48,2.48,7055250191), 
(16, 'GOLDFISH CRACKERS','PC',1,2.58,2.58,1410008547), 
(16, 'SANDWICH','PC',1,2.98,2.98,26731200000), 
(16, 'WINCO COOKIES','PC',1,1.68,1.68,7055250119),
(16, 'CHOBANI YOGURT','PC',2,1.22,2.44,818290017), 
(16, 'WINCO CREAM CHEESE','PC',1,1.78,1.78,7055240017), 
(16, 'APPLES GOLDEN DELICIOUS','LB',1.68,1.28,2.15,4020), 
(16, 'LEMON SMALL','PC',1,.38,.38,4985),
(16, 'BANANAS','LBS',2.17,.59,1.28,4011), 
(16, 'RXBAR','PC',2,1.98,3.96,85777700423), 
(16, 'RED ONION','LBS',.60,.98,.59,4082), 
(16, 'WALNUTS','LBS',.84,2.98,2.50,2035), 
(16, 'RESER BURRITO','PC',4,.88,3.52,7111701150),
(16, 'DATES MEDJOOL','LBS',.52,5.98,3.11,2465), 
(16, 'HAM BLACK FOREST','PC',1,4.18,4.18,7470000140),
(16, 'SWISS CHEESE','PC',1,3.48,3.48,7055208007),
(16, 'CUCUMBER','PC',1,.68,.68,4062);

SELECT SUM(TOTAL_PRICE) FROM ITEMS WHERE TRIP_ID = 16; --$45.00

--NEW TRIP FRED MEYER 11/17/23

INSERT INTO trips (store_id, date, total_cost)
VALUES  
(1, '2023-11-17', 20.60);

INSERT INTO items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price,sku)
VALUES
(17, 'JUANITA TORTILLA CHIPS', 'PC', 1, 3.99,3.99,4886731224), 
(17, 'LAMEX SALSA', 'PC', 1, 4.79,4.79,2011300149),
(17, 'KALE ORG', 'PC', 1, 1.99,1.99,7878390600),
(17, 'FRANZ BREAD 9 GRAIN', 'PC',1, 2.50, 2.50, 7222000457),
(17, 'APPLES OPAL', 'LBS', 2.72, 1.99, 5.39,85290800225),
(17, 'SPAGHETTI', 'PC',1, 1.89, 1.89, 2680000126);

select * from store;

--adding new store: costco wholesale (my work!)

insert into store (name, address)
VALUES ('Costco', '13130 SE 84th Ave, Clackamas, OR 97015');

insert into trips (store_id, date, total_cost)
values (8, '2023-11-21',87.71);

select * from trips;

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price,sku)
VALUES
(18, 'SLIPPER WOMENS', 'PC', 2, 11.99,23.98,1678579), 
(18, 'DELI ROLLED CHICKEN WRAP', 'PC', 1, 13.98,13.98,20128),
(18, 'GODIVA CHOCOLATES', 'PC', 1, 17.99,17.99,1157695),
(18, 'COOKIES 24 CT', 'PC',1, 9.99, 9.99, 34423),
(18, 'PUMPKIN PIE', 'PC', 1, 5.99, 5.99,60809),
(18, 'KS OATS 10 LBS', 'PC',1, 7.99, 7.99, 17366339),
(18, 'KS WOOL SOCKS 4 PK', 'PC', 1, 14.99, 14.99,7771320);


SELECT SUM(TOTAL_PRICE) FROM ITEMS WHERE TRIP_ID = 18;

SELECT 10.99*2;

--CORRECTING CHOCOLATE PRICE 
UPDATE ITEMS
 SET price_per_unit = 12.79, TOTAL_PRICE = 12.79 WHERE PRODUCT_NAME = 'GODIVA CHOCOLATES';

--CORRECTING SLIPPER PRICE 
UPDATE ITEMS
 SET price_per_unit = 10.99, TOTAL_PRICE = 21.98 WHERE PRODUCT_NAME = 'SLIPPER WOMENS';

SELECT * FROM ITEMS WHERE TRIP_ID = 18;


--update 11/25/23, Costco & trader Joes 

--getting store id for trader joes
select id,address from store where name = "Trader Joes"; --id = 4

insert into trips (store_id, date, total_cost)
values (4, '2023-11-25',14.45);

--getting trip_id of recently entered trip:
select * from trips order by date desc; --id = 19

INSERT INTO ITEMS (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(19, 'APPLE ORG FUJI 2 LB','PC',1,2.99,2.99,null), 
(19, 'CHOMPS BEEF STICK','PC',1,1.99,1.99,null), 
(19, 'HOT COCOA MIX ORG','PC',2,3.99,3.99,null), 
(19, 'IRISH BREAKFAST TEA 80 CT','PC',1,3.49,3.49,null),
(19, 'RX BAR CHOC SEA SALT','PC',1,1.99,1.99,null);

--COSTCO RUN FOR KEWPIE MAYO AND BREAD

--getting store id of costco 

select id, address from store where name = 'Costco'; --id = 8

insert into trips (store_id, date, total_cost)
values (8, '2023-11-25',15.98); --trip id = 20

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price,sku)
VALUES
(20, 'KEWPIE MAYO', 'PC', 1,6.49,6.49,1710454), 
(20, 'DAVES KILER BREAD 2 PK', 'PC', 1, 9.49,9.49,512447); -- dkb IS $4.75 PER LOAF AT COSTCO

SELECT SUM(TOTAL_PRICE) FROM ITEMS WHERE TRIP_ID = 20; -15.98

--fred meyer + costco trips, 11/27/23

-- 1. costco trip

insert into trips (store_id, date, total_cost)
values (8, '2023-11-27',29.77); --trip id = 21

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price,sku)
VALUES
(21, 'DATES DEGLET ORGANIC 40 OZ', 'PC', 1,6.79,6.79,1312346), 
(21, 'ADAMS CRUNCHY PEANUT BUTTER 80 OZ', 'PC', 1, 11.99,11.99,18257),
(21, 'KS ORG ROLLED OATS 160 OZ', 'PC', 1, 10.99, 10.99, 1272413);

--quick note - $/oz of adams peanut butter as costco: 
select 11.99/80; --$.15

--finding all the peanut butter items, their store, and price in db: 

create view peanut_butter_view as
select t.id, s.name, i.product_name, i.total_price from items as i
inner join trips as t on i.trip_id = t.id
inner join store as s on t.store_id = s.id
where product_name LIKE '%PEANUT BUTTER%';

create view pb_compare as 
select * from peanut_butter_view where id = 12 or id = 21;

select * from pb_compare;

--winco adams pb $/oz:
select total_price/36 from pb_compare where name = 'Winco'; --$.22 per ounce of peanut butter

--costco adams pb $/oz
select total_price/80 from pb_compare where name = 'Costco'; --$.15 per ounce

--conclusion: it's cheaper to buy more peanut butter at costco for less (duh)

--fred meyer 11/27/23
insert into trips (store_id, date, total_cost)
values (1, '2023-11-27',5.69);

delete from trips where id = 23; 

select * from trips;

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price,sku)
VALUES
(22, 'KALE ORG', 'PC', 1,1.99,1.99,787890600), 
(22, 'OCEAN SPRAY CRANBERRY SAUCE', 'PC', 1, 2.00,2.00,3120001605);


--trip: winco on december 1st 
--I should know this by now, but what is winco's store id ?

select * from store where name like "%winco%"; -- 2


insert into trips (store_id, date, total_cost)
values (2, '2023-12-01',50.20);

--trip_id for this trip = 25

select * from trips where date = '2023-12-01';


INSERT INTO ITEMS (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(25, 'WINCO CRACKERS','PC',1,2.48,2.48,7055250191), 
(25, 'EGGS ORG 1 DZ','PC',1,5.99,5.99,73692130008), 
(25, 'WINCO BREAD','PC',1,98,1.98,7055200639), 
(25, 'SUCHIHANE NORI','PC',1,3.08,3.08,7441051719), 
(25, 'SWISS CHUNK','PC',2,4.98,9.96,7055208010),
(25, 'WINCO DICED TOMATO CAN','PC',1,.85,.85,7055260210), 
(25, 'PECAN HALVES','LBS',.72,7.98,5.75, 2029), 
(25, 'LENTILS GREEN','LB',1.03,2.28,2.35,1467), 
(25, 'PARSLEY ITALIAN','PC',1,.68,.68,4901),
(25, 'GREEN ONION','PC',1,.68,.68,4068), 
(25, 'CELERY','PC',1,1.28,1.28,65151101), 
(25, 'ZUCCHINI','LBS',1.19,1.28,1.52,4067), 
(25, 'APPLE GOLDEN DELICIOUS','LBS',1.5,1.28,1.92,4021), 
(25, 'BELL RED PEPPER','PC',1,.98,.98,4688),
(25, 'SHALLOT','LBS',.11,1.68,.18,4662), 
(25, 'LEMON LARGE','PC',1,.88,.88,4053),
(25, 'WINCO TUNA CAN','PC',2,.88,1.76,7055270302),
(25, 'ONION YELLOW','LBS',.61,.38,.23,4093),
(25, 'WINCO BLACK BEANS','PC',1,.78,.78,7055270432), 
(25, 'SANDWICH WINCO ITALIAN','PC',1,2.98,2.98,26731200000),
(25, 'NAVY BEANS','LBS',.82,1.18,.97,1644),
(25, 'QUINOA','LBS',1.13,2.58,2.92,1283);

--confirming total cost of trip $50.20

select sum(total_price) from items where trip_id = 25; 

--data entry 12/12/23

--what is costco's store id? 
select * from store; -- store id = 8

insert into trips (store_id, date, total_cost)
values (8, '2023-12-09',14.38);

select * from trips;

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(26, 'FRANZ WHOLE WHEAT BREAD 2 PACK', 'PC',1, 6.39,6.39,922283),
(26, 'SWISS MISS HOT CHOCOLATE','PC',1,7.99,7.99,1242231);

SELECT SUM(TOTAL_PRICE) FROM ITEMS WHERE TRIP_ID = 26;

--TRIP 2: WINCO 12/11/23

INSERT INTO TRIPS (STORE_ID, DATE, TOTAL_COST)
values (2, '2023-12-11',45.12);

SELECT * FROM TRIPS ORDER BY DATE DESC;

INSERT INTO ITEMS (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VAlUES
(27, 'A&W ROOT BEER 6-PACK MINI','PC',1,2.98,2.98,7800000197), 
(27, 'CALIDAD TORTILLA','PC',1,3.26,3.26,7794800602), 
(27, 'WHEAT THINS','PC',1,3.28,3.28,4400006923), 
(27, 'CHEEZ-ITS','PC',1,2.98,2.98,2410010685), 
(27, 'ZUCCHINI SQUASH','LBS',.69,1.38,.95,4773),
(27, 'WALNUT PIECES','LBS',.91,2.98,2.71,2054), 
(27, 'SANDWICH DELI','PC',1,2.98,2.98, 26731000000), 
(27, 'BLACK FOREST HAM','PC',1,3.48,3.48,7470000140), 
(27, 'BROCCOLI','LBS',1.72,.99,1.70,4548),
(27, 'JELLY BEANS','LBS',.57,2.18,1.24,2119), 
(27, 'WINCO BLACK BEANS','PC',1,1.38,1.38,7055250134), 
(27, 'WINCO COOKIES','PC',1,1.68,1.68,7055250134), 
(27, 'WINCO BUTTER','PC',1,3.68,3.68,7055240402), 
(27, 'BANANAS','LBS',2.62,.59,1.55,4011),
(27, 'NAVEL ORANGES','LBS',1.87,1.28,2.69,4012), 
(27, 'APPLE GOLDEN DELICIOUS','LBS',1.87,1.28,2.39,4021),
(27, 'ONIONS SWEET','LBS',.9,.88,.79,4166),
(27, 'LEMON LARGE','PC',1,.88,.88,4053),
(27, 'MOZZARELLA CHEEZE','PC',1,4.12,4.12,21718800000), 
(27, 'BOTTLE DEPOSIT','PC',6,.10,.60,4000000007);

--CHECK TOTAL TRIP PRICE: 

SELECT SUM(TOTAL_PRICE) FROM ITEMS WHERE TRIP_ID = 27;

-- new receipt: costco 12/16

insert into trips (store_id, date, total_cost)
values (8, '2023-12-16',50.95);

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(26, 'JACKS SALSA', 'PC',1, 6.99,6.99,967596),
(26, 'MONDETTA PULL OVER','PC',1,11.99,15.99,1720516),
(26, 'LIP BALM 9 STICKS', 'PC',1, 11.99,14.99,1369314),
(26, 'KIRKLAND GIFT WRAP 3 PACK','PC',1,14.99,14.99,1487739),
(26, 'ROTISSERIE CHICKEN', 'PC',1, 4.99,4.99,87745);

SELECT * FROM TRIPS;

SELECT * FROM ITEMS WHERE TRIP_ID = 26; 

-- I messed up, I need to change the trip_id of these past products I entered: COMMENT

UPDATE items
set trip_id = 28
where product_name IN ('JACKS SALSA','MONDETTA PULL OVER', 'LIP BALM 9 STICKS','KIRKLAND GIFT WRAP 3 PACK','ROTISSERIE CHICKEN');

select * from items order by trip_id desc; 


-- new receipts: 12/19/2023, 12/21/2023 costco

select * from trips; 

insert into trips (store_id, date, total_cost)
values 
(8, '2023-12-19', 10.99), 
(8, '2023-12-21', 88.00);

-- trip 12/19/2023

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku)
VALUES
(29, 'AUSSIE BITES', 'PC',1, 10.99,10.99,891394);


-- I NEED TO ADD A WEIGHT / VOLUME COLUMN TO ITEMS OTHERWISE MY ANALYSIS WILL BE USELESS!!! 

alter table items
add column weight_or_vol numeric;

--i need to specify that is just a measurement of weight in OZ ! 

alter table items
change column weight_or_vol weight_oz numeric; 
select * from items;

--trip 12/21/2023

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku, weight_oz)
VALUES
(30, 'BRUSSEL SPROUTS', 'PC',1, 5.79,5.79,80487,32),
(30, 'FIG BARS 40 x 2 OZ','PC',1,17.79,17.79,1618252,80),
(30, 'THINK THIN PROTEIN BARS 18 x 2.1 OZ', 'PC',1,20.99,20.99,865513,37.8),
(30, 'KS TORTILLA CHIPS','PC',1,5.69,5.69,44004,48),
(30, 'CORDON BLEU FROZEN CHICKEN', 'PC',1,12.69,12.69,1021876,39),
(30, 'SUPER SLAW', 'PC',1,2.99,2.99,8303,28),
(30, 'APPLES HONEYCRISP 4 LBS','PC',1,5.99,5.99,6659,64),
(30, 'BANANAS ORG', 'PC',1, 2.49,2.49,2619,NULL),
(30, 'ORG EGGS 2 DZ','PC',1,7.59,7.59,1068083,48),
(30, 'ORG MUSHROOMS BABY BELLAS', 'PC',1,5.99,5.99,121288,24);

select sum(total_price) from items where trip_id = 30; --$88.00

update items 
set total_price = 12.69 where product_name = 'CORDON BLEU FROZEN CHICKEN';

select * from items where trip_id = 30; 

select * from items;

--new winco trip 01/24/23

select * from store; 

insert into trips (store_id, date, total_cost)
values 
(2, '2024-01-03', 44.40); 

select * from trips order by date desc; 

SELECT .64*4;

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku, weight_oz)
VALUES
(31, 'WINCO BREAD', 'PC',1, 1.98,1.98,7055200639,24),
(31, 'CELERY','PC',1,1.28,1.28,3338365325,NULL),
(31, 'RED BELL PEPPERS', 'PC',2,1.48,2.96,4688,NULL),
(31, 'PARSLEY ITALIAN','PC',1,.78,.78,4901,NULL),
(31, 'GREEN ONION', 'PC',1,.68,.68,4068,NULL),
(31, 'ORG ONION 3 LBS', 'PC',1,2.98,2.98,4068,48),
(31, 'WINCO GRK YOGURT','PC',4,.68,2.56,7055240407,5.3),
(31, 'CENTO TOMATO PUREE', 'PC',1, 2.80,2.80,707930001,28),
(31, 'WINCO CREAM CHEESE','PC',1,2.94,2.94,7055240016,12),
(31, 'CUCUMBER', 'PC',1,.78,.78,7055240016,NULL),
(31, 'BARILLA PASTA ROTINI', 'PC',1,1.75,1.75,7680800653,16),
(31, 'POTATOES YELLOW 5 LBS', 'PC',1,3.98,3.98,69477062331,80),
(31, 'DEODORANT ARM & HAMMER', 'PC',1,3.29,3.29,3320019792,NULL),
(31, 'WINCO MOZZARELLA CHEESE', 'PC',1,3.58,3.58,7055240122,16),
(31, 'GARLIC CLOVE', 'PC',1,.68,.68,4608,NULL),
(31, 'ORANGES NAVEL', 'LBS',3.06,.78,2.39,4012,48),
(31, 'APPLE GOLDEN DELICIOUS', 'LBS',2.03,1.28,2.60,4020,32),
(31, 'LEMON LARGE', 'PC',1,.98,.98,4053,NULL),
(31, 'BANANAS', 'LBS',2.07,.59,1.22,4011,32),
(31, 'KOMBUCHA GTS', 'PC',1,3.98,3.98,72243020016,16);

SELECT SUM(TOTAL_PRICE) FROM ITEMS WHERE TRIP_ID = 31;

UPDATE TRIPS 
SET TOTAL_COST = 44.19 WHERE ID = 31;

-- costco 01/06/2024 

select * from store; 

insert into trips (store_id, date, total_cost)
values 
(8, '2024-01-06', 75.63); 

select * from trips order by date desc; 

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku, weight_oz)
VALUES
(32, 'OLIPOP VARIETY PACK', 'PC',1, 13.79,13.79,1744021,NULL),
(32, 'BROCCOLI SOUP 2 PACK','PC',1,9.89,9.89,1788152,NULL),
(32, 'BAGELS 2 PK', 'PC',1,7.99,7.99,1335089,NULL),
(32, 'KS SEAWEED SNACK','PC',1,9.99,9.99,1193197,NULL),
(32, 'COCONUT CUPS', 'PC',1,10.59,10.59,1714297,NULL),
(32, 'CETAPHIL CLEANSER 2 PK', 'PC',1,16.48,16.48,1695152,NULL);

-- I FORGOT THE NUTS 
insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku, weight_oz)
VALUES
(32, 'KS NUTS UNSALTED', 'PC',1, 12.99,12.99,1652577,40);


SELECT SUM(TOTAL_PRICE) FROM ITEMS WHERE TRIP_ID = 32; 
SELECT product_name, TOTAL_PRICE FROM ITEMS WHERE TRIP_ID = 32; 

SELECT * FROM ITEMS WHERE TRIP_ID = 32;

UPDATE ITEMS 
SET price_per_unit = 7.59, TOTAL_PRICE = 7.59 WHERE PRODUCT_NAME = 'COCONUT CUPS';


UPDATE ITEMS 
SET price_per_unit = 16.39, TOTAL_PRICE = 16.39 WHERE PRODUCT_NAME = 'CETAPHIL CLEANSER 2 PK';


UPDATE ITEMS 
SET price_per_unit = 10.79, TOTAL_PRICE = 10.79 WHERE PRODUCT_NAME = 'OLIPOP VARIETY PACK';

SELECT 140.62 - 64.99;


--new trip! NSM 1/18/24 

select * from store; -- nsm store id = 7 

insert into trips (store_id, date, total_cost)
values 
(7, '2024-01-18', 31.32); 

select * from trips order by date desc limit 1;

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku, weight_oz)
VALUES
(33, 'DELLALO PASTA ORZO', 'PC',1,4.79,4.79,NULL,16),
(33, 'NAVEL ORANGES', 'LBS',1.99, 2.99,5.95,NULL,32),
(33, 'BUNCH CARROTS ORG', 'PC',1,2.99,2.99,NULL,NULL),
(33, 'BUNCH BEETS O,RG', 'PC',1, 2.99,2.99,NULL,NULL),
(33, 'KALE ORG', 'PC',2, 2.99,5.98,NULL,NULL),
(33, 'PARM REG BULK', 'LBS',.375,22.99,8.62,NULL,6);

SELECT * FROM ITEMS WHERE TRIP_ID = 33; 

SELECT SUM(TOTAL_PRICE) FROM ITEMS WHERE TRIP_ID = 33; -31.32 

-- new trip: 1/19/24 fred meyers on glisan 

select * from store; 

insert into store (name, address)
values ('Fred Meyer','6615 NE Glisan St');

insert into trips (store_id, date, total_cost)
values (9,'2024-01-19',5.78);

select * from trips; 

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku, weight_oz)
VALUES (34,'PARSLEY ORG','PC',1,1.79,1.79,3338390423 ,NULL),
 (34,'GCB SOURDOUGH LOAF','PC',1,3.99,3.99,73316300123 ,NULL);

 SELECT SUM(TOTAL_PRICE) FROM ITEMS WHERE TRIP_ID = 34; 

 -- new trip: NSM @ Grant Park 

 select * from store; 

 insert into store (name, address)
 values ('New Seasons Market', '3210 NE Broadway');


insert into trips (store_id, date, total_cost)
values (10,'2024-01-23',18.81), 
(8,'2024-01-24',106.50);

select * from trips order by date desc limit 2;

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku, weight_oz)
values (36, 'DILL ORG', 'PC',1, 2.99,2.99,NULL,NULL),
(36, 'FENNEL ORG', 'LBS',.96,4.99,4.79,NULL,NULL),
(36, 'RADDICCHIO ORG', 'LBS',1.53, 5.99,9.16,NULL,NULL),
(36, 'MEYER LEMON ORG', 'LBS',.49, 2.99,1.47,NULL,NULL),
(36, 'SHALLOTS', 'LBS',.07,4.99,.35,NULL,NULL);

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku, weight_oz)
values (36, 'STUPID BAG FEE', 'PC',1, .05,.05,NULL,NULL);


SELECT SUM(TOTAL_PRICE) FROM ITEMS WHERE TRIP_ID = 36;

------

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku, weight_oz)
VALUES
(37, 'OPAL APPLES 4 LB', 'PC',1,6.99,6.99,6852,64),
(37, 'BANANAS 3 LB','PC',1,1.99,1.99,30669,48),
(37, 'CHOBANI YOGURT 20 PK', 'PC',1,15.89,15.89,1005641,64),
(37, 'MANDARINS 5 LB ','PC',1,7.99,7.99,18600,80),
(37, 'CHOC BRIOCHE MILK BUNS', 'PC',1,5.99,5.99,1780675,19),
(37, 'KS ITALIAN OLIVE OIL 2 L ', 'PC',1,17.99,17.99,71003,64),
(37, 'KS OAT MILK 6 x 32 FL OZ', 'PC',1,10.99,10.99,1272413,192),
(37, 'DAVES KILLER BREAD 2 LOAVES','PC',1,9.49,9.49,512447,54),
(37, 'SLICED SWISS CHEESE', 'PC',1,10.49,10.49,20661,32),
(37, 'RXBAR VARIETY 14 BARS', 'PC',1,18.69,18.69,1761722,26);

SELECT SUM(TOTAL_PRICE) FROM ITEMS WHERE TRIP_ID = 37;

--new fred meyers trip: 
select * from store; 
insert into trips (store_id, date, total_cost)
values (1,'2024-02-02',37.21);

select * from trips;

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku, weight_oz)
VALUES
(39, 'RADISH ORG', 'PC',1,1.79,1.79,3338390413,null),
(39, 'RED PEPPER ORG','PC',1,2.19,2.19,5783694688,NULL),
(39, 'ONION RED ORGANIC', 'LBS',.59,1.69,1,81488102197,9),
(39, 'PITA BREAD ALEXIS ','PC',1,5.49,5.49,8148810202,NULL),
(39, 'KING HARVEST HUMMUS', 'PC',1,3.99,3.99,2572631127,NULL),
(39, 'ALADIN TZAZIKI ', 'PC',1,4.89,4.89,85901400031,10),
(39, 'GTS KOMBUCHA', 'PC',1,3.49,3.49,72243020016,16),
(39, 'HGTS BBQ SANDWICH','PC',1,7.49,7.49,9663611856,NULL),
(39, 'CUCUMBER', 'PC',1,1.49,1.49,71106994062,NULL),
(39, 'POLAR 8 PK BLACK CHERRY', 'PC',1,5.29,5.29,715370366,96);

SELECT SUM(TOTAL_PRICE) FROM ITEMS WHERE TRIP_ID = 39;

--costco 2/5/24

select * from store; -- store id = 8

insert into trips (store_id, date, total_cost)
values (8,'2024-02-05',61.03);

select * from trips; -- my 40th trip! hooray 

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku, weight_oz)
VALUES
(40, 'KS PAPER TOWELS', 'PC',1,19.49,19.49,1742835,null),
(40, 'ROTISSERIE CHICKEN','PC',1,4.99,4.99,87745,48),
(40, 'EGGS KS ORG 2 DZ', 'PC',1,7.59,7.59,1068083,48),
(40, 'KS CREAM CHEESE 6 X 8 OZ','PC',1,7.99,7.99,1656611,48),
(40, 'ORGANIC TOFU 4 X 1 LB', 'PC',1,6.99,6.99,1204135,64),
(40, 'BROCCOLI FLORETS ORG', 'PC',1,5.99,5.99,7267,32),
(40, 'BAGEL 2 PK', 'PC',1,7.99,7.99,7267,48);


SELECT SUM(TOTAL_PRICE) FROM ITEMS WHERE TRIP_ID = 40;

-- Winco 2/9/24

select * from store;

insert into trips (store_id, date, total_cost)
values (2,'2024-02-09',66.80);

select * from trips where store_id = 2;

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku, weight_oz)
VALUES
(41, 'CHEEZ-ITS WHITE CHEDDAR', 'PC',1, 3.48,3.48,2410078938,12),
(41, 'BANANAS','LBS',3.08,.59,1.82,4011,48),
(41, 'RESER BURRITO', 'PC',2,1.78,3.56,7111701170,NULL),
(41, 'FIT CRUNCH BAR','PC',2,1.98,3.96,81771902100,NULL),
(41, 'PECAN HALVES', 'LBS',1,8.68,8.68,2029,16),
(41, 'DRIED PRUNES', 'LBS',1,1.10,4.38,2152,16),
(41, 'BEANS GREAT NORTHERN','LBS',.93,1.20,1.12,1634,14.9),
(41, 'APPLES GOLDEN DELICIOUS', 'LBS',2.23,1.38,3.08,4021,32),
(41, 'WINCO WIPES','PC',1,2.98,2.98,7055210211,17),
(41, 'POLAR SELTZER 8 PK', 'PC',1,2.78,2.78,7153700368,96),
(41, 'WALNUTS', 'LBS',1.4,3.18,4.45,2035,22),
(41, 'DATES MEDJOOL', 'LBS',1,6.48,6.48,2465,16),
(41, 'PEETS COFFEE', 'PC',1,9.98,9.98,78535702552,10.5),
(41, 'ORAL-B TOOTHBRUSH', 'PC',1,2.63,2.63,30041010998,NULL),
(41, 'SENSODYNE TOOTHPASTE', 'PC',1,6.98,6.98,31015885000,NULL);

SELECT SUM(TOTAL_PRICE) FROM ITEMS WHERE TRIP_ID = 41; 

-- new receipts: 

select * from store; 

insert into trips (store_id, date, total_cost)
values (8,'2024-02-11',12.49),
(1,'2024-02-16',28.48); 

select * from trips;

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku, weight_oz)
VALUES
(42, 'KS MIXED NUTS', 'PC',1,12.49,12.49,1645578,40);

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku, weight_oz)
VALUES
(43, 'SPINDRIFT 8 PK GRAPEFRUIT', 'PC',1,6.79,6.79,85657900232,96),
(43, 'CUCUMBER', 'PC',1,1.49,1.49,71106994062,NULL),
(43, 'CARROTS BULK', 'LBS',.93,.99,.92,856571106994062,15),
(43, 'TIMS CHIPS', 'PC',1,3.99,3.99,1159475300,NULL),
(43, 'KROGER AMERICAN CHEESE DELI', 'PC',1,7.03,7.03,20635090000,NULL),
(43, 'HONEY TURKEY SLICED DELI', 'PC',1,8.57,8.57,20593890000,96);

SELECT SUM(TOTAL_PRICE) FROM ITEMS WHERE TRIP_ID = 43;

select count(id) from trips;

-- costco 2/21/2024


select * from store; 

insert into trips (store_id, date, total_cost)
values (8,'2024-02-21',68.63);

SELECT * FROM TRIPS;

insert into items (trip_id, product_name, quantity_unit, quantity, price_per_unit, total_price, sku, weight_oz)
VALUES
(44, 'KS PEACHES 4 JARS', 'PC',1,12.89,12.89,512688,96),
(44, 'KIMCHI','PC',1,7.89,7.89,512688,42),
(44, 'JAPANESE GYOZA', 'PC',2,14.99,14.99,1763967,NULL),
(44, 'KS COLUMBIAN COFFEE','PC',2,17.89,17.89,120296,48),
(44, 'COTTAGE CHEESE', 'LBS',1,5.99,5.99,289660,48),
(44, 'BANANAS', 'PC',1,1.99,1.99,30669,NULL),
(44, 'OPAL APPLES 4 LBS','PC',1,6.99,6.99,6852,64);

SELECT SUM(TOTAL_PRICE) FROM ITEMS WHERE TRIP_ID = 44;