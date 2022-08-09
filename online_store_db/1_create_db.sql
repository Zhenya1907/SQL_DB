DROP DATABASE IF EXISTS marsal;
CREATE DATABASE marsal;
USE marsal;


-- типы товаров
DROP TABLE IF EXISTS types;
CREATE TABLE types (
	id serial PRIMARY KEY,
	type_name varchar(100) UNIQUE 
);

-- фотографии товаров
DROP TABLE IF EXISTS media;
CREATE TABLE media (
	id serial PRIMARY KEY,
	filename varchar(100),
	`size` int
);

-- товар
DROP TABLE IF EXISTS product;
CREATE TABLE product (
	id serial PRIMARY KEY,
	types_id bigint UNSIGNED NOT NULL,
	name varchar(50),
	`size` varchar(10),
	color varchar(50),
	price int,
	availability bool,
	media_id bigint UNSIGNED NOT NULL,
	
	FOREIGN KEY (types_id) REFERENCES types(id),
	FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- покупатель
DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
	id serial PRIMARY KEY,
	firstname varchar(100),
	lastname varchar(100),
	email varchar(100) UNIQUE,
	phone bigint UNIQUE,
	password_hash varchar(100),
	
	INDEX customer_firstname_lastname_idx(firstname, lastname)
);

-- адрес
DROP TABLE IF EXISTS address;
CREATE TABLE address (
	customer_id serial PRIMARY KEY,
	index_ bigint,
	country varchar(100),
	city varchar(100),
	street varchar(100),
	house_number int,
	flat_number int,
	FOREIGN KEY (customer_id) REFERENCES customer(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- корзина
DROP TABLE IF EXISTS cart;
CREATE TABLE cart (
	customer_id serial PRIMARY KEY,
	product_id bigint UNSIGNED NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customer(id)  ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (product_id) REFERENCES product(id)
);

-- доставка
DROP TABLE IF EXISTS delivery;
CREATE TABLE delivery (
	id serial PRIMARY KEY,
	status enum('Ожидает отправки', 'Отправлен', 'Доставлен'),
	created_at datetime DEFAULT now(),
	updated_at datetime DEFAULT current_timestamp ON UPDATE current_timestamp, 
	address_id bigint UNSIGNED NOT NULL,
	FOREIGN KEY (address_id) REFERENCES address(customer_id)
);

-- заказ
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
	id serial PRIMARY KEY,
	order_number int,
	customer_id bigint UNSIGNED NOT NULL,
	product_id bigint UNSIGNED NOT NULL,
	to_delivery_id bigint UNSIGNED NOT NULL,
	payment_method varchar (100),
	status enum('Оплачен', 'В работе', 'Отправлен', 'Закрыт'),
	created_at datetime DEFAULT now(),
	updated_at datetime DEFAULT current_timestamp ON UPDATE current_timestamp, 
	
	FOREIGN KEY (customer_id) REFERENCES customer(id),
	FOREIGN KEY (product_id) REFERENCES product(id),
	FOREIGN KEY (to_delivery_id) REFERENCES delivery(id),
	
	INDEX order_number_idx(order_number)
);

