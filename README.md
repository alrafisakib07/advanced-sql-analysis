# Advanced SQL Analysis for Dashboards (company_db)

MySQL project that builds a three-table sales database and answers dashboard-style reporting questions with efficient queries.

**Tools:** SQL, MySQL, MySQL Workbench, Subqueries, Window Functions, Query Optimization

## Business Problem

A company with separate product, customer, and sales tables needed deeper reporting: monthly sales summaries, top customers, and above-average performers by region and product, written as efficient queries that can feed a dashboard.

## What I Did

- Built a three-table database with foreign keys (12 products, 12 customers, 15 orders)
- Wrote multi-table JOINs, subqueries in WHERE and SELECT, and nested aggregations
- Used multi-column GROUP BY with HAVING filters
- Built a monthly sales summary and a Top 5 customers query
- Compared two versions of a query with EXPLAIN, including one that uses a window function (`AVG() OVER()`)

## Database Schema

```
product   (product_id PK, product_name, category)
customers (customer_id PK, customer_name)
sales     (order_id PK, customer_id FK, region, product_id FK,
           quantity, sales_amount, order_date)
```

## Queries Covered

| Topic | Example |
|---|---|
| Multi-table JOIN | Orders with customer, product, and category details |
| Subquery in WHERE | Orders with sales above the overall average |
| Nested aggregation | Products and regions whose total sales beat the average |
| GROUP BY + HAVING | Sales by region and category above a threshold |
| Subquery in SELECT | Each order next to total and average sales |
| Monthly summary | Total sales and order count per month |
| Top 5 customers | Customers ranked by total spent |
| EXPLAIN | Subquery version vs. window function version |

## Files

- `company_db_analysis.sql`: table creation, sample data, and all queries

## Data

Sample dataset created for the course assignment.

## Author

Abdullah Al Rafi Shakib, BSc in Statistics, Jagannath University, Dhaka
Email: alrafisakib07@gmail.com
