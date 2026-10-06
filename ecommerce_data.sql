-- persisting values onto the tables
USE ecommerce;

-- customer table
INSERT INTO customer
    (customer_fname, customer_lname, address_line1, address_line2, city, country, postcode, email, phone, preferred_comms_method)
VALUES ('Maya', 'Thompson', '24 Green Lane', NULL, 'London', 'UK', 'N13 4AB', 'maya.thompson@example.com', '07700100101', 'Email'),
('Lucas', 'Ferreira', '18 Oak Road', 'Flat 7', 'London', 'UK', 'E17 6PQ', 'lucas.ferreira@example.com', '07700100102', 'SMS'),
('Sophie', 'Bennett', '72 King Street', NULL, 'Manchester', 'UK', 'M2 4NH', 'sophie.bennett@example.com', '07700100103', 'Email'),
('Daniel', 'Rossi', '15 Park Avenue', 'Apartment 3', 'Bristol', 'UK', 'BS1 5TR', 'daniel.rossi@example.com', '07700100104', 'Phone'),
('Aisha', 'Khan', '91 Station Road', NULL, 'Birmingham', 'UK', 'B14 7AA', 'aisha.khan@example.com', '07700100105', 'SMS');

-- customer_oder table
INSERT INTO customer_order (order_status, customer_id, order_date)
VALUES ('Pending', 1, '2026-09-21 10:15:00'),
('Processed', 2, '2026-09-22 14:30:00'),
('Delivered', 1, '2026-09-23 09:45:00'),
('Out_for_delivery', 3, '2026-09-24 16:20:00'),
('Delivered', 4, '2026-09-25 11:10:00'),
('Processed', 5, '2026-09-26 18:35:00'),
('Delivered', 2, '2026-09-27 13:05:00'),
('Pending', 3, '2026-09-28 20:15:00');

-- test DEFAULT order status ('Pending')
INSERT INTO customer_order (customer_id, order_date)
VALUES (5, '2026-09-28 20:15:00');

-- product table
INSERT INTO product (product_name, unit_price)
VALUES ('Wireless Headphones', 79.99),
('USB-C Charger', 24.50),
('Laptop Stand', 42.00),
('Mechanical Keyboard', 89.95),
('Wireless Mouse', 34.99),
('Webcam', 59.50),
('Desk Lamp', 27.99),
('Portable Speaker', 49.95);


-- supplier table
INSERT INTO supplier(supplier_name, supplier_address, supplier_city, supplier_country, supplier_postcode, supplier_email, supplier_phone, payment_terms_days, payment_method)
VALUES ('TechSource Ltd', '18 Commerce Way', 'London', 'UK', 'E16 2AB', 'orders@techsource.example.com', '02070001001', 30, 'invoice'),
('Digital Supply Co', '42 Industrial Road', 'Manchester', 'UK', 'M17 1AA', 'sales@digitalsupply.example.com', '01610001002', 60, 'bank transfer'),
('Bright Electronics Ltd', '7 Enterprise Park', 'Birmingham', 'UK', 'B24 8HZ', 'accounts@brightelectronics.example.com', '01210001003', 30, 'business credit card'),
('Northstar Distribution', '55 Warehouse Lane', 'Leeds', 'UK', 'LS10 1RT', 'orders@northstar.example.com', '01130001004', 90, 'invoice'),
('Connect Wholesale Ltd', '12 Trade Street', 'Bristol', 'UK', 'BS2 0SP', 'sales@connectwholesale.example.com', '01170001005', 60, 'bank transfer');

 
-- inventory table
INSERT INTO inventory (inventory_address, inventory_city, inventory_country, inventory_postcode)
VALUES ('14 Distribution Way', 'London', 'UK', 'EN3 7XY'),
('82 Logistics Park', 'Birmingham', 'UK', 'B24 9QR'),
('31 Warehouse Road', 'Manchester', 'UK', 'M17 1HJ'),
('6 Harbour Estate', 'Bristol', 'UK', 'BS11 9FB');


-- third_party_seller table
INSERT INTO third_party_seller (company_name, address, city, country, postcode, contact_name, email, phone)
VALUES ('Pixel Market Ltd', '27 Market Street', 'London', 'UK', 'E1 6QR', 'Emma Clarke', 'emma@pixelmarket.example.com', '02070002001'),
('Smart Living Co', '14 Queen Road', 'Birmingham', 'UK', 'B1 1AA', 'James Wilson', 'james@smartliving.example.com', '01210002002'),
('Northern Tech Store', '63 Deansgate', 'Manchester', 'UK', 'M3 2BW', 'Olivia Taylor', 'olivia@northerntech.example.com', '01610002003'),
('Urban Gadgets Ltd', '9 Park Row', 'Leeds', 'UK', 'LS1 5HD', 'Noah Evans', 'noah@urbangadgets.example.com', '01130002004');



-- order_products table
INSERT INTO order_products (order_id, product_id, quantity)
VALUES (1, 1, 1),
(1, 5, 2),
(2, 3, 1),
(2, 7, 1),
(3, 2, 2),
(3, 6, 1),
(4, 4, 1),
(5, 1, 1),
(5, 8, 2),
(6, 5, 1),
(7, 3, 2),
(7, 6, 1),
(8, 2, 1),
(8, 7, 2);



-- supplier_product table

INSERT INTO supplier_product (product_id, supplier_id, unit_cost)
VALUES (1, 1, 48.00),
(1, 3, 51.50),
(2, 2, 13.25),
(3, 1, 25.00),
(3, 5, 27.50),
(4, 3, 56.00),
(4, 4, 59.50),
(5, 2, 19.00),
(6, 4, 37.50),
(6, 5, 39.00),
(7, 1, 16.75),
(8, 3, 31.50),
(8, 5, 33.00);


-- product_location table

INSERT INTO product_location (inventory_location_id, product_id, quantity)
VALUES (1, 1, 25),
(1, 2, 40),
(1, 3, 12),
(1, 5, 30),
(2, 2, 18),
(2, 4, 15),
(2, 6, 20),
(2, 7, 35),
(3, 1, 10),
(3, 3, 22),
(3, 6, 14),
(3, 8, 28),
(4, 4, 9),
(4, 5, 17),
(4, 7, 21),
(4, 8, 13);


-- seller_product table

INSERT INTO seller_product (product_id, seller_id, listing_price)
VALUES (1, 1, 94.99),
(1, 3, 91.50),
(2, 1, 31.99),
(2, 4, 29.95),
(3, 2, 54.99),
(3, 3, 52.50),
(4, 1, 109.99),
(4, 4, 104.50),
(5, 2, 44.99),
(5, 3, 42.95),
(6, 1, 74.99),
(6, 4, 71.50),
(7, 2, 36.99),
(8, 3, 64.99),
(8, 4, 61.95);

-- validate populated tables
SELECT * FROM customer;
SELECT * FROM customer_order;
SELECT * FROM inventory;
SELECT * FROM product;
SELECT * FROM order_products;
SELECT * FROM product_location;
SELECT * FROM seller_product;
SELECT * FROM supplier;
SELECT * FROM supplier_product;
SELECT * FROM third_party_seller;
