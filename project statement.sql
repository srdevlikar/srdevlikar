create database SQL_Basics_Practice;
create table sales
(orderid varchar (7),
orderdate date,
customerid varchar (4),
customername varchar (20),
salesperson varchar (20),
region varchar (12),
producttype varchar (10),
price float (10),
quantity integer (2),
primary key (orderid));

insert into sales
(orderid, orderdate, customerid, customername, salesperson, region, producttype, price, quantity)
values
('0009', '2021-01-05', '20', 'Company T', 'Andrew James', 'Arizona', 'Product 1', '399.00', '5'),
('0012', '2021-01-05', '6', 'Company F', 'Laura Larsen', 'California', 'Product 1', '399.00', '6'),
('0014', '2021-01-05', '4', 'Company D', 'Anna Weber', 'Texas', 'Product 1', '399.00', '4'),
('0020', '2021-01-07', '5', 'Company E', 'Anna Weber', 'Texas', 'Product 1', '399.00', '3'),
('0024', '2021-01-07', '12', 'Company L', 'Michael Fox', 'New Mexico', 'Product 1', '399.00', '2')
;

select * from sales;
select * from sales order by orderdate asc, quantity desc;
create table sales_bkp as table sales;
select * from sales_bkp;
delete from sales_bkp where orderid = "0009";

alter table sales_bkp
add column cratedby varchar (10) default 'saurabh';
select orderid, cratedby, salesperson, price from sales_bkp;
alter table sales_bkp
drop cratedby;
drop table sales_bkp;

select * from sales_data;
select * from sales_data where region = 'California';
select year (`Order Date`) as YR,
sum(price*quantity) as sales from sales_data group by year (`Order Date`);
alter table sales_data
add column YeR integer (4),
add column Mth integer(2),
add column Dy integer (2);

update sales_data
set YeR = year(`order date`);
update sales_data
set Mth = month(`order date`);
update sales_data
set Dy = day(`order date`);

select min(price) min_price, min(quantity) min_qty from sales_data;
select max(price) max_price, max(quantity) max_qty from sales_data;
select avg(price) avg_price, avg(quantity) avg_qty from sales_data;

select * from sales_data;
select distinct `Product Type`, count(`order ID`) no_of_orders from sales_data group by `Product Type`;
select `Sales Person`, length(`Sales Person`) from sales_data;
alter table sales_data
add column concat varchar (25);
update sales_data
set concat = lower(concat(`Sales Person`, '-', `Region`));

select substring_index(`Sales Person`, ' ', 1) first_name, substring_index(`Sales Person`, ' ',-1) Last_name from sales_data;
alter table sales_data
add column Revenue double;

update sales_data
set Revenue = (`Price`*`Quantity`);

select `Sales Person`, sum(`Revenue`) from sales_data  group by 1;

select * from sales_data;
select `Order ID`, `Region` from sales_data where (`Revenue` between 1000 and 3000) and (`Region` = 'Texas') group by 1,2;

select `Sales Person`, sum(`Revenue`) as total_revenue
from sales_data  group by 1 having sum(`Revenue`) > 250000
order by total_revenue desc;

select case 
when `Product Type` in ('Product 1', 'Product 2', 'Product 3') then 'Category 1'
when `Product Type` in ('Product 4', 'Product 5') then 'Category 2'
else 'NA' end as category,
sum(`Revenue`)
from sales_data
group by 1;