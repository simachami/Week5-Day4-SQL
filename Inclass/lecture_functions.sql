--CREATE (optional!: OR REPLACE) FUNCTION <name of func>(<params> <param datatype>)
--RETURNS <return data type>
--LANGUAGE plpgsql AS $$
-- BEGIN 
--	<function body>;
-- END
--$$

-- Call function:
-- SELECT <name of function>(<required args>)

CREATE OR REPLACE FUNCTION doubleNumber(num INTEGER) RETURNS INTEGER
LANGUAGE plpgsql AS $$
	BEGIN
		RETURN num * 2;		
	END
$$


CREATE OR REPLACE FUNCTION squareNumber(num INTEGER) RETURNS INTEGER
LANGUAGE plpgsql AS $$
	BEGIN
		RETURN POWER(num,2);
	--  RETURN num ^ 2
	END
$$
SELECT squareNumber(10);

ALTER payment
ALTER COLUMN payment_date timestamp NULL;
DROP FUNCTION IF EXISTS payLateFee;
CREATE OR replace FUNCTION payLateFee(
	_rental_id INTEGER, 
	_customer_id INTEGER,
	_staff_id INTEGER
)
RETURNS INTEGER
LANGUAGE plpgsql AS $$
	BEGIN
		INSERT INTO payment(
			customer_id,
			staff_id,
			rental_id,
			amount,
			payment_date
		)VALUES(
			_customer_id,
			_staff_id,
			_rental_id,
			3.00,
--			CURRENT_TIMESTAMP()
			NOW()
		);
		RETURN _customer_id;
	END
$$
SELECT * FROM rental WHERE return_date IS null;
SELECT * FROM payment;

SELECT * FROM customer
WHERE customer_id = (SELECT payLateFee(11496, 155, 1));

SELECT * FROM payment 
WHERE customer_id = 155 AND rental_id = 11496;


-- PROCEDURES

-- CREATE PROCEDURE <name of Procedure>(<params> <datatype of params>)
-- AS $$
--BEGIN
--<procedure body>;
--COMMIT;
--END
--$$
--Language as pgsql;

CREATE OR REPLACE PROCEDURE updateReturnDate(
	rentalId INTEGER, 
	customerId INTEGER
) AS $$
BEGIN
	UPDATE rental
	SET return_date = current_timestamp
	WHERE rental_id = rentalId 
	AND customer_id = customerId;
	COMMIT;
END
$$
LANGUAGE plpgsql;

CALL updateReturnDate(11496,155);
SELECT * FROM rental
WHERE rental_id = 11496 AND customer_id = 155;

CREATE PROCEDURE updateEmail(
	customerId int,
	firstName varchar,
	lastName varchar,
	emailUpdate varchar
) AS $$
BEGIN
	UPDATE customer 
	SET email = emailUpdate
	WHERE first_name = firstName
	AND last_name = lastName
	AND customer_id = customerId;
	COMMIT;
END
$$
LANGUAGE plpgsql;
CALL updateEmail()
CALL updateEmail(524,'Jared', 'Ely', 'test@email.org');
SELECT * FROM customer c 
WHERE customer_id = 524


CREATE PROCEDURE addActor(firstName varchar, lastName varchar)
LANGUAGE plpgsql AS $$
	BEGIN 
		INSERT INTO actor(
		first_name,
		last_name,
		last_update
		) VALUES(
		firstName,
		lastName,
		NOW()
		);
		COMMIT;
		
		
	END
$$

CALL addActor('Sean', 'Currie');
CALL addActor('Tom', 'Hardy');
SELECT *
FROM actor a  
WHERE first_name = 'Sean'
	
SELECT *
FROM actor a 
WHERE first_name = 'Tom'
