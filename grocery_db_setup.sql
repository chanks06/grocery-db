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




 