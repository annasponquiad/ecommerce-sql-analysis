# ecommerce-sql-analysis
Relational database design and SQL analysis project based on an e-commerce business scenario.

## Project Overview

I was given an e-commerce scenario that needed to manage customers, products, orders, inventory, suppliers and third-party sellers, as well as the relationships between them.

I started by creating an EER diagram based on a template provided by the DIO SQL course I was undertaking at the time. I used the main tables from the original scenario as my starting point, but as I worked through the relationships, I realised I would need to create additional bridge tables for the database to work in the way I wanted.

Once I was happy with the diagram, I manually created the database and each of its tables in MySQL, making sure the attributes, primary and foreign keys, data types and constraints were set correctly.

I then created synthetic data specifically for the project and used it to populate the database. After loading the data, I checked the tables and tested the database to make sure the keys, constraints and checks were behaving as expected.

Finally, I used AI to generate realistic business questions based on my dataset. I then worked through these questions independently, writing SQL queries to find the answers and using the results to understand what the data could tell me about the business.

## Database Design

![E-commerce EER Diagram](EER_diagram_ecommerce_SQL_project.png)

When creating the EER diagram, I noticed that as I was designing the main entities, there were some relationships that could not be represented without creating additional tables.

For example, after creating `customer_order` and `product`, there was no way to link the two tables. I considered adding `product_id` to `customer_order`, but quickly realised this would create a problem because an order can contain more than one product. As one order can have many products, and one product can also appear in many orders, I needed a bridge table to connect them.

I therefore created `order_products`, using `order_id` and `product_id` as a composite primary key so that each row could uniquely identify a specific product within a specific order. This table also allowed me to add `quantity`, which belongs to the relationship between an order and a product rather than to either table individually.

I used the same approach for the other many-to-many relationships in the database, creating bridge tables to connect products with suppliers, inventory locations and third-party sellers.

## Skills Demonstrated

- **Database Design:** EER modelling, relational database design, table relationships and cardinality
- **Keys & Relationships:** Primary keys, foreign keys, composite primary keys, many-to-many relationships and bridge tables
- **Data Integrity:** Data types, `NOT NULL`, `UNIQUE`, `CHECK`, `DEFAULT` and referential integrity
- **SQL Querying:** `SELECT`, `WHERE`, `ORDER BY`, calculated fields and filtering
- **Joins:** Joining multiple related tables using `INNER JOIN`
- **Aggregation:** `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `GROUP BY` and `HAVING`
- **Data Validation:** Testing constraints, validating inserted data and checking query results
- **Database Implementation:** Creating and populating a relational database in MySQL

## Business Questions

Once the database was populated and tested, I started using SQL to answer business questions based on the data. I began with simpler questions and gradually worked my way up to more complex ones, where I needed to bring information from different tables together, perform calculations and group the data to find the answers.

Some examples include:

- Which customers have placed more than one order?
- How much has each customer spent across all of their orders?
- Which customers have spent more than £150?
- What is the total value of each order?
- Which supplier offers the lowest unit cost for each product?
- What is the difference between the cheapest and most expensive supplier price for each product?
- Which products have generated more than £75 in revenue?

The full SQL used to answer these questions can be found in `ecommerce_analysis.sql`.

## Tools

- MySQL
- MySQL Workbench
- GitHub

## Project Files

- `ecommerce_schema.sql` — Creates the database structure, tables, keys and constraints.
- `ecommerce_data.sql` — Populates the database with the synthetic data used for the project.

## Project Background

This project started as an e-commerce database modelling exercise from the DIO SQL course I was completing at the time.

The course provided the original business scenario and a database model containing the main tables in Portuguese. I used these as the starting point for my project, but decided to rebuild the database in English and develop my own version of the model.

As I worked through the relationships, I added the bridge tables and attributes I needed for my design, created the keys and constraints, and then manually built and populated the database in MySQL.

I continued developing the project beyond the original modelling exercise by testing the database and using it to answer a series of business questions with SQL.
- `ecommerce_analysis.sql` — Contains the SQL queries used to answer the business questions.
- `EER_diagram_ecommerce_SQL_project.png` — Shows the database structure and relationships between the tables.
