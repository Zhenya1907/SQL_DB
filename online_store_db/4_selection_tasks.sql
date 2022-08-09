-- 1. Cкрипты выборок (включающие группировки, JOIN'ы, вложенные таблицы)

	-- 1.1. количество проданных товаров за все время
	SELECT 
		count(*) AS sales_cnt
	FROM `order` o
	JOIN product p ON o.product_id = p.id;
	
	-- 1.2. количество товаров, купленных каждым покупателем (с именем покупателя)
	SELECT 
		concat(c.firstname, ' ', c.lastname) AS customer,
		count(*) AS product_cnt
	FROM `order` o
	JOIN customer c ON c.id = o.customer_id 
	GROUP BY o.customer_id;
	
	-- 1.3. содержимое заказа конкретного покупателя (id=7)
	SELECT 
		o.order_number,
		o.customer_id,
		t.type_name,
		p.name,
		p.`size`,
		p.color,
		p.price 
	FROM `order` o 
	JOIN product p ON p.id = o.product_id
	JOIN types t ON t.id = p.types_id 
	WHERE o.customer_id = 7;
	
	-- 1.4. на какую сумму каждый покупатель сделал заказ
	SELECT 
		o.order_number,
		o.customer_id,
		sum(price) AS order_price
	FROM `order` o
	JOIN product p ON p.id = o.product_id
	GROUP BY o.order_number;	

	-- 1.5. самый часто заказываемый товар (название модели)
	SELECT 
		p.name,
		count(*) AS cnt
	FROM product p 
	JOIN `order` o ON p.id = o.product_id
	GROUP BY p.name
	ORDER BY cnt DESC
	LIMIT 1;

	-- 1.6. самые непопулярные товары (товары, которые никогда не заказывали)
	SELECT 
		t.type_name,
		p.name,
		p.color 
	FROM `order` o 
	RIGHT JOIN product p ON o.product_id = p.id
	JOIN types t ON t.id = p.types_id
	WHERE o.id IS NULL
	GROUP BY t.type_name, p.name, p.color;


-- 2. Представления

	-- 2.1. товары с категориями, отсортированные сначала по типам, потом по названиям товаров, по цветам
	CREATE OR REPLACE VIEW v_products
	AS 
		SELECT 
			t.type_name,
			p.name,
			p.color,
			p.`size`,
			p.price
		FROM product p 
		JOIN types t ON p.types_id = t.id
		ORDER BY t.type_name, p.name, p.color;

	-- 2.2. данные пользователей
	CREATE OR REPLACE VIEW v_users
	AS 
		SELECT 
			c.id,
			concat(c.firstname, ' ', c.lastname) AS name,
			c.email,
			c.phone,
			concat(a.country, ', ', a.city, ', ', a.street, ', ', a.flat_number, ', ', a.index_) AS address
		FROM customer c 
		JOIN address a ON c.id = a.customer_id;
	

-- 3. Хранимые процедуры или функции / триггеры 
		
	-- 3.1. хранимая процедура 
	-- вывод контактов покупателей совершивших покупку указанной стоимости в определенный промежуток времени
		
	/*
	CREATE PROCEDURE marsal.sp_contacts_of_customers_by_check(check_ bigint, start_date varchar(50), end_date varchar(50))
	
	BEGIN
		
		-- все покупатели с заказом больше указанной суммы
		WITH customer_check_5000 AS (
			SELECT 
				o.order_number,
				o.customer_id AS new_id,
				sum(price) AS order_price,
				o.created_at 
			FROM `order` o
			JOIN product p ON p.id = o.product_id
			GROUP BY o.order_number
			HAVING order_price > check_
		)
		
		-- покупатели с заказом больше указанной суммы, с подгруженными контактами, с указанным промежутком времени
		SELECT 
			cc.order_number,
			concat(c.firstname, ' ', c.lastname) AS customer,
			c.phone,
			c.email,
			cc.created_at AS order_date
		FROM customer_check_5000 cc
		JOIN customer c ON c.id = cc.new_id 
		WHERE cc.created_at BETWEEN  start_date AND end_date;
	
	END
		 */
			
	CALL sp_contacts_of_customers_by_check(5000, '2000-09-14', '2015-09-14');
	

	-- 3.2. функция 
	-- вычисление среднего чека за указанный месяц (указывается порядковый номер месяца)
	
		/*
		CREATE FUNCTION marsal.average_check_for_month(month_number int)
		RETURNS float READS SQL DATA
			
			BEGIN
				DECLARE monthly_revenue int;
				DECLARE monthly_number_of_orders int;
			
				SET monthly_revenue = (
					-- получено денег за указанный месяц
					SELECT 
						sum(price) AS order_price
					FROM `order` o
					JOIN product p ON p.id = o.product_id
					WHERE MONTH(o.created_at) = month_number
				);
			
				SET monthly_number_of_orders = (
					-- получено заказов за указанный месяц
					SELECT 
						count(DISTINCT o.order_number) AS cnt 
					FROM `order` o
					WHERE MONTH(o.created_at) = month_number
				);
			
				RETURN monthly_revenue / monthly_number_of_orders;
				
			END
		 */	
		
	SELECT average_check_for_month(4);


	-- 3.3. триггер 1
	-- проверка корректности индекса адреса доставки
	/*
	 CREATE DEFINER=`root`@`localhost` TRIGGER `index_error` BEFORE INSERT ON `address` FOR EACH ROW BEGIN 
			
			IF NEW.index_ < 1000 THEN 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Неверно указан индекс адреса доставки.';
			END IF;
		
		END
	 */

	INSERT INTO customer (id, firstname, lastname, email, phone, password_hash)
	VALUES (11,'Anna','Kafan','al44vis89@example.net',95399160518,'25f783d4d668fedb41705858f79b1be2834ceefa');

	INSERT INTO address (customer_id, index_, country, city, street, house_number, flat_number)
	VALUES (11,0,'USA','Rice','Ste 729',3,245);

	DELETE FROM customer WHERE id = 11;

	-- 3.4. триггер 2
	-- если размер товара не указан - указать 'oversize'
	/*
	 CREATE DEFINER=`root`@`localhost` TRIGGER `size_substitution` BEFORE INSERT ON `product` FOR EACH ROW BEGIN 
			
			IF NEW.`size` IS NULL THEN 
				SET NEW.`size` = 'oversize';
			END IF;
			
		END
	 */
	INSERT INTO product (id, types_id, name, color, price, availability, media_id)
	VALUES (21,1,'Хлоя','Белый',2500,1,7);
	
	DELETE FROM product  WHERE id = 21;
	
