--new table for recording gasoline receipts

create table gas (
    date date, 
    location varchar(100), 
    gallons numeric(5,2), 
    price_per_gal numeric(5,2),
    total_price numeric(5,2)
);

insert into gas (date, location, gallons, price_per_gal, total_price)
values 
('2024-02-05','Costco Clackamas', 11.11, 3.6, 40.00),
('2024-02-15','Costco Clackamas', 12.21,3.6,43.95);

select * from gas; 