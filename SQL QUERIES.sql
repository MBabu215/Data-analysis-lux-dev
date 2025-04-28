---SQL Assignment
---Basic queries

1--List all customers with their full name and city.

SELECT 
CONCAT(first_name,  '  ',  second_name) AS full_name, city 
FROM customers;

2--Show all books priced above 2000.

select title,price from books
where price >2000;

3--List customers who live in 'Nairobi'.
SELECT *
FROM customers
WHERE city = 'Nairobi';

-4--Retrieve all book titles that were published in 2023
SELECT title, published_date
FROM books
WHERE EXTRACT(YEAR FROM published_date) = 2023;

--Filtering and Sorting

-5--Show all orders placed after March 1st, 2025= NO Data
SELECT order_id, order_date
FROM orders
WHERE order_date > '2025-03-01';

6---List all books ordered, sorted by price (descending).
select title, price
from books
order by price DESC;

7---Show all customers whose names start with 'J'
SELECT *FROM customers
WHERE first_name LIKE 'J%';

8---List books with prices between 1500 and 3000.
SELECT title, price
FROM books
where price between 1500 and 3000;

---Aggregate Functions and Grouping

9---Count the number of customers in each city.
SELECT city, COUNT(*) AS total_customers 
FROM customers
Group by city;

10---Show the total number of orders per customer
select customer_id,COUNT(*) as total_orders
from orders
GROUP BY customer_id;

11---Find the average price of books in the store.
select AVG (price) as average_book_price 
from books;

12--List the book title and total quantity ordered for each book

SELECT b.title, 
SUM(o.quantity::INTEGER) AS total_quantity_ordered
FROM books b
JOIN orders o ON b.book_id = o.book_id
GROUP BY b.title;


--Subqueries
13-----Show customers who have placed more orders than customer with ID = 1

SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > (SELECT COUNT(*)
FROM orders
WHERE customer_id = 1

);

SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id;

14---List books that are more expensive than the average book price
SELECT title, price
FROM books
WHERE price > (
    SELECT AVG(price)
    FROM books
);

15---Show each customer and the number of orders they placed using a subquery in SELECT.

SELECT 
    CONCAT(first_name, ' ', second_name) AS full_name,
    (SELECT COUNT(*) 
     FROM orders o 
     WHERE o.customer_id = c.customer_id) AS total_orders
FROM customers c;

----JOINS
16- Show full name of each customer and the titles of books they ordered

SELECT c.first_name || ' ' || c.second_name AS full_name,
  b.title
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN books b ON o.book_id = b.book_id;

17-- List all orders including book title, quantity, and total cost (price × quantity)
SELECT 
  b.title,
  o.quantity,
  CAST(b.price AS NUMERIC) * CAST(o.quantity AS INTEGER) AS total_cost
FROM orders o
JOIN books b ON o.book_id = b.book_id;

18.--Show customers who haven't placed any orders (LEFT JOIN)
SELECT 
  c.first_name || ' ' || c.second_name AS full_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

19--List all books and the names of customers who ordered them, if any (LEFT JOIN)

SELECT 
  b.title AS book_title,
  c.first_name || ' ' || c.second_name AS customer_name
FROM books b
LEFT JOIN orders o ON b.book_id = o.book_id
LEFT JOIN customers c ON o.customer_id = c.customer_id;

20---Show customers who live in the same city (SELF JOIN)
SELECT 
  c1.first_name || ' ' || c1.second_name AS customer_1,
  c2.first_name || ' ' || c2.second_name AS customer_2,
  c1.city
FROM customers c1
JOIN customers c2 ON c1.city = c2.city AND c1.customer_id <> c2.customer_id;


Combined Logic
21---Show all customers who placed more than 2 orders for books priced over 2000.
SELECT b.price, b.title, COUNT(o.order_id) AS total_orders
FROM books b
JOIN orders o on o.book_id = b.book_id
WHERE b.price>2000
GROUP BY b.price, b.title
HAVING COUNT(o.order_id)> 2;


22--List customers who ordered the same book more than once.

SELECT c.first_name, COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.first_name
HAVING COUNT(o.order_id) > 1;

23---Show each customer's full name, total quantity of books ordered, and total amount
spent.
SELECT 
  c.first_name || ' ' || c.second_name AS full_name,
  SUM(CAST(o.quantity AS INTEGER)) AS total_quantity_ordered,
  SUM(CAST(o.quantity AS INTEGER) * CAST(b.price AS NUMERIC)) AS total_amount_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN books b ON o.book_id = b.book_id
GROUP BY c.customer_id, c.first_name, c.second_name;


--24--List books that have never been ordered.
SELECT b.book_id, b.title
FROM books b
LEFT JOIN orders o ON b.book_id = o.book_id
WHERE o.book_id IS NULL;

25.Find the customer who has spent the most in total (JOIN + GROUP BY + ORDER BY +
LIMIT)

SELECT 
  c.first_name || ' ' || c.second_name AS full_name,
  COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.first_name, c.second_name
ORDER BY total_orders DESC
LIMIT 1;

26.Write a query that shows, for each book, the number of different customers who have
ordered it.
SELECT 
  b.title,
  COUNT(DISTINCT o.customer_id) AS different_customers
FROM books b
JOIN orders o ON b.book_id = o.book_id
GROUP BY b.title;

27.Using a subquery, list books whose total order quantity is above the average order
quantity

SELECT b.title, 
SUM(CAST(o.quantity AS INTEGER)) AS total_order_quantity
FROM books b
JOIN orders o ON b.book_id = o.book_id
GROUP BY b.title
HAVING SUM(CAST(o.quantity AS INTEGER)) > (
    SELECT AVG(total_quantity)
    FROM (
        SELECT SUM(CAST(o.quantity AS INTEGER)) AS total_quantity
        FROM books b
        JOIN orders o ON b.book_id = o.book_id
        GROUP BY b.title
    ) AS subquery
);

28. Show the top 3 customers with the highest number of orders and the total amount they
spent

SELECT 
  c.first_name || ' ' || c.second_name AS full_name,
  COUNT(o.order_id) AS total_orders,
  SUM(CAST(o.quantity AS INTEGER) * CAST(b.price AS NUMERIC)) AS total_amount_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN books b ON o.book_id = b.book_id
GROUP BY c.customer_id, c.first_name, c.second_name
ORDER BY total_orders DESC
LIMIT 3;






