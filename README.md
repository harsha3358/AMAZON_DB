# 🛒 Amazon SQL Database Project

This project simulates a miniature version of an e-commerce database system like Amazon using MySQL. It involves designing and managing multiple interconnected tables such as `products`, `customers`, `orders`, `payments`, `employees`, and `projects`.

## 📦 Database Structure

The database `amazon` consists of the following tables:

- **products**: Information about items including name, price, stock, and location (Mumbai or Delhi)
- **customer**: Customer details including name, age, and address
- **orders**: Links customers and products with order amounts
- **payment**: Tracks payment status, mode (UPI, credit, debit), and amounts
- **employee**: Basic employee records
- **projects**: Projects assigned to employees

## 🔗 Relationships

- `orders.cid` → `customer.cid`
- `orders.pid` → `products.pid`
- `payment.oid` → `orders.oid`
- `projects.eid` → `employee.eid`

## 🧾 Sample Queries & Operations

This project includes a variety of SQL queries, such as:

- Joins: INNER, LEFT, RIGHT, FULL, CROSS
- Aggregate Functions: `SUM`, `AVG`, `COUNT`, `GROUP BY`, `HAVING`
- Subqueries
- Filters based on location, age, and payment status
- Business questions answered:
  - Orders from Mumbai or Delhi
  - Orders with pending or in-process payments
  - Total transactions by payment mode
  - High-value customer and product insights

## 🗃️ Sample Data

Includes sample entries for:

- 5 products (e.g., HP Laptop, Realme Mobile)
- 5 customers
- 5 orders
- 5 payments
- Employees and projects

## 💡 Example Queries

- **Display orders from Mumbai**
```sql
SELECT * FROM orders
JOIN products ON orders.pid = products.pid
WHERE location = 'Mumbai';
```

- **Total revenue from Mumbai**
```sql
SELECT SUM(amt) FROM orders
JOIN products ON orders.pid = products.pid
WHERE location = 'Mumbai';
```

- **Customer and payment details for those under 30 paying via UPI**
```sql
SELECT orders.oid, amt, cname, mode FROM orders
JOIN customer ON orders.cid = customer.cid
JOIN payment ON orders.oid = payment.oid
WHERE age < 30 AND mode = 'upi';
```

- **Products with total sales over ₹20,000**
```sql
SELECT * FROM products
WHERE pid IN (
    SELECT pid FROM orders
    GROUP BY pid
    HAVING SUM(amt) > 20000
);
```

## 📊 Insights

This project helps in understanding:

- E-commerce database design
- SQL joins and subqueries
- Real-world query writing
- Simulating reports and dashboards from transactional data

## ⚙️ Technologies

- SQL (MySQL)
- Structured Data Modeling
- Relational Database Management

