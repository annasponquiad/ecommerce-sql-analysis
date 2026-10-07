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
