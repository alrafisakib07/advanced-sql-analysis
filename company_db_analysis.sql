Create database company_db;
use company_db;

CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);

CREATE TABLE sales (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    region VARCHAR(50) NOT NULL,
    product_id INT,
    quantity INT NOT NULL,
    sales_amount DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

INSERT INTO product (product_name, category) VALUES
('Laptop', 'Computers'),
('Smartphone', 'Mobile Devices'),
('Tablet', 'Mobile Devices'),
('Monitor', 'Computer Accessories'),
('Headphones', 'Audio'),
('Keyboard', 'Computer Accessories'),
('Mouse', 'Computer Accessories'),
('Printer', 'Office Equipment'),
('Webcam', 'Computer Accessories'),
('Speaker', 'Audio'),
('Smartwatch', 'Mobile Devices'),
('External Hard Drive', 'Storage');

INSERT INTO customers (customer_name) VALUES
('Alice Smith'),
('Bob Johnson'),
('Charlie Brown'),
('David Miller'),
('Eva Green'),
('Frank White'),
('Grace Black'),
('Henry Adams'),
('Ivy Taylor'),
('Jack Nelson'),
('Karen Hill'),
('Leo Carter');

SELECT * FROM product;
SELECT * FROM customers;

INSERT INTO sales (customer_id, region, product_id, quantity, sales_amount, order_date) VALUES
(1, 'North', 1, 1, 1200.00, '2026-01-05'),
(2, 'South', 2, 2, 1600.00, '2026-01-12'),
(3, 'East', 3, 3, 900.00, '2026-01-20'),
(4, 'West', 4, 2, 500.00, '2026-02-02'),
(5, 'North', 2, 1, 800.00, '2026-02-10'),
(6, 'South', 1, 2, 2400.00, '2026-02-18'),
(7, 'East', 5, 5, 250.00, '2026-03-01'),
(8, 'West', 3, 1, 300.00, '2026-03-09'),
(9, 'North', 4, 1, 250.00, '2026-03-15'),
(10, 'South', 5, 4, 200.00, '2026-04-03'),
(11, 'East', 1, 1, 1200.00, '2026-04-11'),
(12, 'West', 2, 3, 2400.00, '2026-04-19'),
(1, 'North', 6, 2, 90.00, '2026-05-02'),
(3, 'East', 7, 3, 60.00, '2026-05-14'),
(5, 'North', 8, 1, 220.00, '2026-05-25');

SELECT * FROM sales;

select s.order_id, 
c.customer_name,
 p.product_name,
 p.category, 
 s.region,
 s.quantity,
 s.sales_amount,
 s.order_date
from  sales s
JOIN customers c 
ON s.customer_id = c.customer_id
JOIN product p
ON s.product_id = p.product_id;

SELECT * FROM sales
where sales_amount > ( select avg(sales_amount) from sales);

SELECT p.product_name, SUM(s.sales_amount) AS total_product_sales
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(s.sales_amount) > (
    SELECT AVG(product_total) FROM (
        SELECT SUM(sales_amount) AS product_total
        FROM sales
        GROUP BY product_id
    ) AS avg_per_product
);

select 
region,
total_sales
from 
( select
region,
sum(sales_amount) as total_sales
from sales
group by region
 ) as region_totals
where total_sales > (select avg (total_sales)
 from ( 
 select sum(sales_amount) as total_sales
 from sales 
 group by region 
 )
 as avg_calc 
 );
 
 select s.region, 
 p.category,
 sum(s.sales_amount) as total_sales
 from sales s
 join product p 
 on s.product_id=p.product_id
 group by s.region,
 p.category
 order by s.region,
 p.category;

select region,
sum(sales_amount) as total_sales
from sales 
group by region
having 
sum(sales_amount) >3000;

select s.region,
p.category,
sum(s.sales_amount) as total_sales
from sales s
join product p 
on s.product_id=p.product_id
group by s.region, p.category
having sum(s.sales_amount) > 500;

SELECT order_id, sales_amount,
    (SELECT SUM(sales_amount) FROM sales) AS total_sales,
    (SELECT AVG(sales_amount) FROM sales) AS average_sales
FROM sales;

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
    SUM(sales_amount) AS total_sales,
    COUNT(*) AS total_orders
FROM sales
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY sales_month;

SELECT c.customer_name, SUM(s.sales_amount) AS total_spent
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 5;

SELECT region, total_sales
FROM (
    SELECT region, SUM(sales_amount) AS total_sales
    FROM sales
    GROUP BY region
) AS region_totals
WHERE total_sales > (
    SELECT AVG(total_sales) FROM (
        SELECT SUM(sales_amount) AS total_sales
        FROM sales
        GROUP BY region
    ) AS avg_calc
);

SELECT region, SUM(sales_amount) AS total_sales
FROM sales
GROUP BY region
HAVING SUM(sales_amount) > 3000;

EXPLAIN
SELECT region, total_sales
FROM (
    SELECT region, SUM(sales_amount) AS total_sales
    FROM sales
    GROUP BY region
) AS region_totals
WHERE total_sales > (
    SELECT AVG(total_sales) FROM (
        SELECT SUM(sales_amount) AS total_sales
        FROM sales
        GROUP BY region
    ) AS avg_calc
);

EXPLAIN
SELECT region, total_sales
FROM (
    SELECT region, 
           SUM(sales_amount) AS total_sales,
           AVG(SUM(sales_amount)) OVER() AS avg_all_regions
    FROM sales
    GROUP BY region
) AS t
WHERE total_sales > avg_all_regions;
