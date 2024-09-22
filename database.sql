--- Create database
create database amazon;

use amazon;

-- Products - pid, pname, price, stock, location (Mumbai or Delhi)
create table products
(
	pid int(3) primary key,
    pname varchar(50) not null,
    price int(10) not null,
    stock int(5),
    location varchar(30) check(location in ('Mumbai','Delhi'))
);
-- Customer - cid, cname, age, addr
create table customer
(
	cid int(3) primary key,
    cname varchar(30) not null,
    age int(3),
    addr varchar(50)
);

-- Orders - oid, cid, pid, amt
create table orders
(
	oid int(3) primary key,
    cid int(3),
    pid int(3),
    amt int(10) not null,
    foreign key(cid) references customer(cid),
    foreign key(pid) references products(pid)
);

-- Payment - pay_id, oid,amount, mode(upi, cerdit, debit), status
create table payment
(
	pay_id int(3) primary key,
    oid int(3),
    amount int(10) not null,
    mode varchar(30) check(mode in('upi','credit','debit')),
    status varchar(30),
    foreign key(oid) references orders(oid)
);

create table employee
(
	eid varchar(10),
    ename varchar(50)
);

create table projects
(
	pid varchar(10),
    pname varchar(50),
    eid varchar(10)
);


--- Insert values
insert into products values(1,'HP Laptop',50000,15,'Mumbai');
insert into products values(2,'Realme Mobile',20000,30,'Delhi');
insert into products values(3,'Boat earpods',3000,50,'Delhi');
insert into products values(4,'Levono Laptop',40000,15,'Mumbai');
insert into products values(5,'Charger',1000,0,'Mumbai');

select * from products;

insert into customer values(101,'Ravi',30,'fdslfjl');
insert into customer values(102,'Rahul',25,'fdslfjl');
insert into customer values(103,'Simran',32,'fdslfjl');
insert into customer values(104,'Purvesh',28,'fdslfjl');
insert into customer values(105,'Sanjana',22,'fdslfjl');


insert into orders values(10001,102,3,2700);
insert into orders values(10002,104,2,18000);
insert into orders values(10003,105,5,900);
insert into orders values(10004,101,1,46000);
insert into orders values(10005,102,2,17000);

select * from orders;

insert into payment values(1,10001,2700,'upi','completed');
insert into payment values(2,10002,18000,'credit','completed');
insert into payment values(3,10003,900,'debit','in process');
insert into payment values(4,10004,46000,'upi','completed');
insert into payment values(5,10005,17000,'debit','pending');
select * from payment;

insert into employee values('E1','Ravi');
insert into employee values('E2','Rahul');
insert into employee values('E3','Sanjana');
insert into employee values('E4','Sam');

insert into projects values('P1','Web','E1');
insert into projects values('P2','Power BI','E2');
insert into projects values('P3','Sql','E3');
insert into projects values('P4','Python',null);




-- INNER JOIN
select *
from employee
inner join projects on employee.eid = projects.eid;

-- LEFT JOIN
select *
from employee
left join projects on employee.eid = projects.eid;

-- RIGHT JOIN
select *
from employee
right join projects on employee.eid = projects.eid;

-- FULL JOIN
select *
from employee
left join projects on employee.eid = projects.eid
UNION
select *
from employee
right join projects on employee.eid = projects.eid;

-- CROSS JOIN
select *
from employee
cross join projects;

select *
from payment
inner join orders on payment.oid=orders.oid
left join products on orders.pid=products.pid;


-- Display details of all orders which were delivered from 'Mumbai'

select *
from orders
inner join products on orders.pid=products.pid
where location='Mumbai';

-- Display oid,amt,pname of all orders which were delivered from 'Mumbai'
-- Display total revenue of all orders which were delivered from 'Mumbai'
-- Display details of all orders whose payment were made through UPI
-- Display details of all orders whose payment status is in process or pending

select *
from orders
left join products on orders.pid=products.pid
where location='Mumbai';

select *
from products;

select *
from products
right join orders on products.pid=orders.pid;

-- display details of all orders which were made by people below 30 years and delevired from "Delhi"
select * from orders 
left join products on orders.pid = products.pid
left join customer on orders.cid = customer.cid
where age<30 and location = "delhi";


-- display oid , amt  , customer name and payment mode of orders which were made by people below 30 years and payment was made through upi

select * from orders
left join customer on orders.cid = customer.cid
left join payment on orders.oid =  payment.oid
where age < 30 and mode = "upi";

-- display oid , amt , cname  , pname , location of orders whose payment is still pending or in process.sort the desending order of their amt.
select orders.oid , amt , cname , pname , location from orders
left join Payment on orders.oid =  Payment.oid
left join customer on orders.cid = customer.cid
left join products on orders.pid = products.pid     
where status in("in process" , "pending") order by orders.amt desc;



# aggigrate func = sum  , avg , count , min , max , prod , length
# group by = to see aggregate  function 
# where function does not work on aggrigate function instead it we use having by

-- i want to see location , average price and the no of products placed from various location
select location,count(*) , avg(price) from products
group by location;

-- display total transactions done through various mode of payment
select mode , sum(amount) from payment 
group  by mode;

-- display total amt of transactions done through various mode of payment where total amt >3000 and also sort in desc order of total amt
select mode  , sum(amount)  from payment
group by mode
having  sum(amount) > 3000
order by sum(amount) desc;

-- display total purchase made from various locations
select location , sum(amt) from orders 
inner join products on orders.pid = products.pid
group by location
having sum(amt) > 30000
order by sum(amt) desc;

/* 
SUBQUIRES
*/
-- avg order amount
select avg(amt) from orders ;

-- display more than avg amount
select * from orders 
where amt > 16500 ;
-- or by using subquire 
select * from orders
where amt >(select avg(amt) from orders);

-- dispaly details of customers whose age is greater than avg age of all customers;
select * from customer
where age > (select avg(age) from customer);

-- display details of products whose total amount is greater than 20000 ;
select pid  from orders
group by pid
having sum(amt) > 20000;

select * from products
where pid in (select pid  from orders
group by pid
having sum(amt) > 20000);


-- display details of customers whose total order amount is greater than 19000
select * from cusotmers
left join orders on orders.cid=customers.cid 
where (select sum(amount) from customers
 group by customer_name) >19000;

-- dispaly details of customer whose age is greaterthan 25 and products were delivered from delhi;
select cid from customer
where age > 25 ;

select pid from products
where location = 'Delhi';

select * from orders 
where cid in (select cid from customer
where age > 25) and pid in (select pid from products
where location = 'Delhi');
	
-- display mode and status of payment of orders of customer whose age is greaterthan 25 and products were delivered from delhi;
select mode , status from payment 
where oid in (select oid from orders 
where cid in (select cid from customer
where age > 25) and pid in (select pid from products
where location = 'Delhi')) ;

