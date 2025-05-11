CREATE SCHEMA lux_sql;

SET search_path TO lux_sql;

CREATE TABLE customers(
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    second_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number CHAR(10)
);

INSERT INTO customers (first_name, second_name, email, phone_number)
VALUES 
('John', 'Doe', 'john@example.com', '0700111222'),
('Jane', 'Smith', 'jane@example.com', '0700111333'),
('Paul', 'Kim', 'paul@example.com', '0700111444'),
('Mary', 'Wambui', 'mary@example.com', '0700111555');


select * from customers;

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    author VARCHAR(100),
    price NUMERIC(8, 2) NOT NULL,
    published_date DATE
);

select * from customers;

INSERT INTO books (book_id, title, author, price, published_date)
VALUES 
(101, 'Understanding SQL', 'David Kimani', 1500.00, '2023-01-15'),
(102, 'Advanced PostgreSQL', 'Grace Achieng', 2500.00, '2023-02-20'),
(103, 'Learning Python', 'James Mwangi', 3000.00, '2022-11-10'),
(104, 'Data Analytics Basics', 'Susan Njeri', 2200.00, '2023-03-05');


select * from books;

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    book_id INT REFERENCES books(book_id),
    order_date DATE
);

INSERT INTO orders (customer_id, book_id, order_date)
VALUES
(1, 103, '2023-04-01'),  
(2, 101, '2023-04-02'),  
(3, 102, '2023-04-03'),  
(4, 104, '2023-04-04'),  
(1, 102, '2023-04-05');

select * from orders

alter table customers
add column city VARCHAR(100);

update customers
set city=case customer_id
when 1 then 'Nairobi'
when 2 then 'Mombasa'
when 3 then 'Kisumu'
when 4 then 'Nairobi' end ;

select * from customers;







