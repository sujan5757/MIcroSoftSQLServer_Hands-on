USE CUSTOMERREGISTRATION;

-- create country table
create table country (
    country_id int not null,
    country_name varchar(16),
    country_code int,
    primary key (country_id)
);

 exec sp_columns country;

select * from country;

create table state (
    state_id int not null,
    state_name varchar(16),
    state_code int,
    country_id int,
    primary key (state_id),
    foreign key (country_id) references country(country_id)
);
select * from state;

alter table state
add constraint fk_district_id
foreign key (district_id) references district(district_id)
go

--result
select * from state;
-- create district table
create table district (
    district_id int not null,
    district_name varchar(16),
    district_code int,
    state_id int,
    country_id int,
    primary key (district_id),
    foreign key (state_id) references state(state_id),
    foreign key (country_id) references country(country_id)
);


select * from district;

-- create customer table
create table customer (
    customer_id int not null,
    customer_name varchar(16),
    customer_age int,
    customer_dob varchar(16),
    customer_anni varchar(16),
    customer_wallet int,
    customer_country_id int,
    customer_state_id int,
    customer_district_id int,
    primary key (customer_id),
    foreign key (customer_country_id) references country(country_id),
    foreign key (customer_state_id) references state(state_id),
    foreign key (customer_district_id) references district(district_id)
);

insert into customer (customer_id, customer_name, customer_age, customer_dob, customer_anni, customer_wallet, customer_country_id, customer_state_id, customer_district_id) values
(1, 'Alice', 30, '1994-01-15', '2020-02-14', 1000, 1, 1, 1),
(2, 'Bob', 25, '1998-05-22', '2021-03-18', 1500, 1, 1, 2),
(3, 'Charlie', 35, '1989-08-30', '2019-04-10', 2000, 1, 1, 3),
(4, 'David', 28, '1995-12-12', '2020-06-21', 1200, 1, 1, 4),
(5, 'Eve', 32, '1991-07-19', '2018-11-15', 1700, 1, 1, 5),
(6, 'Frank', 40, '1984-09-05', '2015-10-30', 2200, 1, 1, 6);



-- create mobile_type table
create table mobile_type (
    mobile_type_id int not null,
    mobile_type varchar(16),
    primary key (mobile_type_id)
);
insert into mobile_type (mobile_type_id, mobile_type) values
(1, 'Primary'),
(2, 'Secondary');

-- create mobile table
create table mobile (
    mobile_id int not null,
    mobile_number varchar(10),
    mobile_type_id int,
    customer_id int,
    primary key (mobile_id),
    foreign key (mobile_type_id) references mobile_type(mobile_type_id),
    foreign key (customer_id) references customer(customer_id)
);

insert into mobile (mobile_id, mobile_number, mobile_type_id, customer_id) values
(1, '9876543210', 1, 1), 
(2, '8765432109', 2, 1), 
(3, '7654321098', 1, 2),  
(4, '6543210987', 2, 2);


select * from mobile;
-- create email_type table
create table email_type (
    email_type_id int not null,
    email_type varchar(16),
    primary key (email_type_id)
);

insert into email_type (email_type_id, email_type) values
(1, 'Primary'),
(2, 'Secondary');

-- create email table
create table email (
    email_id int not null,
    email varchar(16),
    email_type int,
    customer_id int,
    primary key (email_id),
    foreign key (email_type) references email_type(email_type_id),
    foreign key (customer_id) references customer(customer_id)
);

insert into email (email_id, email, email_type, customer_id) values
(1, 'alice@example.com', 1, 1),
(2, 'alice.secondary@example.com', 2, 1),
(3, 'bob@example.com', 1, 2),
(4, 'bob.secondary@example.com', 2, 2),
(5, 'charlie@example.com', 1, 3),
(6, 'charlie.secondary@example.com', 2, 3);


-- create purchase_history table
create table purchase_history (
    purchase_id int not null,
    customer_id int,
    date_of_purchase varchar(16),
    no_of_items int,
    amount varchar(16),
    date_of_delivery varchar(16),
    address_id int,
    primary key (purchase_id),
    foreign key (customer_id) references customer(customer_id),
    foreign key (address_id) references customer_address(customer_address_id)
);
insert into purchase_history (purchase_id, customer_id, date_of_purchase, no_of_items, amount, date_of_delivery, address_id) values
(1, 1, '2024-01-15', 3, '150.00', '2024-01-20', 1),
(2, 2, '2024-02-20', 2, '100.00', '2024-02-25', 2),
(3, 3, '2024-03-10', 5, '250.00', '2024-03-15', 3);

select * from purchase_history;
-- create items table
create table items (
    item_id int not null,
    item_price varchar(16),
    item_stock int,
    item_category varchar(16),
    primary key (item_id)
);

insert into items (item_id, item_price, item_stock, item_category) values
(1, '50.00', 100, 'Electronics'),
(2, '25.00', 200, 'Books'),
(3, '75.00', 150, 'Clothing');
select * from items;

-- create receiver_address table
create table receiver_address (
    receiver_id int not null,
    receiver_name varchar(16),
    customer_address_id int,
    receiver_mobile varchar(16),
    country_id int,
    primary key (receiver_id),
    foreign key (customer_address_id) references customer_address(customer_address_id),
    foreign key (country_id) references country(country_id)
);
insert into receiver_address (receiver_id, receiver_name, customer_address_id, receiver_mobile, country_id) values
(1, 'Alice', 1, '9876543210', 1),
(2, 'Bob', 2, '8765432109', 1),
(3, 'Charlie', 3, '7654321098', 1);

select * from receiver_address;
-- create customer_address_type table
create table address_type (
    address_type_id int not null,
    address_type varchar(16),
    primary key (address_type_id)
);
insert into address_type (address_type_id, address_type) values
(1, 'Home'),
(2, 'Work');
select * from address_type;
-- create customer_address table
create table customer_address (
    customer_address_id int not null,
    customer_address_type_id int,
    customer_id int,
    customer_address varchar(16),
    primary key (customer_address_id),
    foreign key (customer_address_type_id) references address_type(address_type_id),
    foreign key (customer_id) references customer(customer_id)
);
insert into customer_address (customer_address_id, customer_address_type_id, customer_id, customer_address) values
(1, 1, 1, '123 Main St'),
(2, 2, 1, '456 Work St'),
(3, 1, 2, '789 Main St'),
(4, 2, 2, '101 Work St'),
(5, 1, 3, '202 Main St'),
(6, 2, 3, '303 Work St');

select * from customer_address;
-- create order_items table to keep track of items in each purchase
create table order_items (
    order_item_id int not null,
    purchase_id int,
    item_id int,
    primary key (order_item_id),
    foreign key (purchase_id) references purchase_history(purchase_id),
    foreign key (item_id) references items(item_id)
);
select * from order_items;

go



select * from country
go

select * from state
go

select * from district
go

select * from email
go

select * from email_type
go

select * from mobile
go

select * from mobile_type
go

select * from customer
go

select * from customer_address
go

select * from order_items
go

select * from items
go

select * from purchase_history
go

select * from receiver_address
go

select * from address_type
go

select * from customer
go

select Customer_name,customer_age
from customer
where customer_age<30
go
-- aggregate function
--finding the avg wallet of the customers who is having less than 2000
select AVG(customer_wallet)
from customer
where customer_wallet<=2000
go
-- finding the sum of the customer wallet  whose age is less than 35 
select SUM(customer_wallet)
from customer
where customer_age<35
go

select MAX(customer_wallet)
from customer
Where customer_age>20
go

select MIN(customer_wallet)
from customer
Where customer_age>20
go

