CREATE OR REPLACE FUNCTION addCustomer(
	customerId INT,
	_name varchar,
	_email varchar,
	phoneNumber varchar
)
RETURNS INT
LANGUAGE plpgsql AS $$
BEGIN
	INSERT INTO customers(
		customer_id,
		name,
		email,
		phone_number
	)VALUES(
		customerId,
		_name,
		_email,
		phoneNumber
	);
	RETURN customerId;
END
$$

SELECT addCustomer (3,'Kelly Clarkson', 'kelly@email.com', '658-452-7898')

SELECT * FROM customers c 


CREATE PROCEDURE updateNumber(
	customerId int,
	phoneNumber varchar
)AS $$
BEGIN
	UPDATE customers
	SET phone_number = phoneNumber
	WHERE customer_id = customerId;
	COMMIT;
END
$$
LANGUAGE plpgsql;

CALL updateNumber(1, '235-569-7847')
SELECT * FROM customers c 


