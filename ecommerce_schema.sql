-- database creation for e-commerce lab case

CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- create table customer
CREATE TABLE customer (
		customer_id INT AUTO_INCREMENT, 
        customer_fname VARCHAR(45) NOT NULL,
        customer_lname VARCHAR(45) NOT NULL,
        address_line1 VARCHAR (30) NOT NULL,
        address_line2 VARCHAR (30),
        city VARCHAR (30) NOT NULL,
		country VARCHAR (30) NOT NULL,
        postcode VARCHAR (10) NOT NULL,
        email VARCHAR (45) UNIQUE NOT NULL,
        phone VARCHAR (20),
        preferred_comms_method VARCHAR (10) NOT NULL,
        PRIMARY KEY (customer_id),
        CONSTRAINT chk_preferred_comms
			CHECK (preferred_comms_method IN ('Email', 'SMS', 'Phone'))
);

    
-- create table customer_order
CREATE TABLE customer_order (
		order_id INT AUTO_INCREMENT,
        order_status VARCHAR (25) NOT NULL DEFAULT 'Pending',
        customer_id INT NOT NULL,
        order_date DATETIME NOT NULL,
        PRIMARY KEY (order_id),
        CONSTRAINT fk_customer_order_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id), 
        CONSTRAINT chk_order_status
			CHECK (order_status IN ('Pending', 'Processed', 'Out_for_delivery', 'Delivered'))
);


-- create table product
CREATE TABLE product(
	product_id INT AUTO_INCREMENT, 
    product_name VARCHAR (45) NOT NULL,
    unit_price DECIMAL (10,2) NOT NULL,
    PRIMARY KEY (product_id),
    CONSTRAINT chk_unit_price
		CHECK (unit_price>=0)
);
    
-- create table inventory
CREATE TABLE inventory(
	inventory_location_id INT AUTO_INCREMENT,
    inventory_address VARCHAR (45) NOT NULL,
    inventory_city VARCHAR (20) NOT NULL,
    inventory_country VARCHAR (30) NOT NULL,
    inventory_postcode VARCHAR (10) NOT NULL,
    PRIMARY KEY (inventory_location_id)
);
    

-- create table supplier
CREATE TABLE supplier(
	supplier_id int AUTO_INCREMENT,
    supplier_name VARCHAR (45) NOT NULL,
    supplier_address VARCHAR (45) NOT NULL,
    supplier_city VARCHAR (45) NOT NULL,
    supplier_country VARCHAR (45) NOT NULL,
    supplier_postcode VARCHAR (10) NOT NULL,
    supplier_email VARCHAR (55) NOT NULL UNIQUE,
    supplier_phone VARCHAR (20) NOT NULL,
    payment_terms_days INT NOT NULL,
    payment_method VARCHAR(20) NOT NULL,
    PRIMARY KEY (supplier_id),
    CONSTRAINT chk_payment_terms_days CHECK(payment_terms_days IN(30, 60, 90)),
    CONSTRAINT chk_payment_method CHECK(payment_method IN('business credit card', 'invoice', 'bank transfer'))
);


-- create table third_party_seller
CREATE TABLE third_party_seller (
	seller_id INT AUTO_INCREMENT,
    company_name VARCHAR (45) NOT NULL,
    address VARCHAR (45) NOT NULL,
    city VARCHAR (35) NOT NULL,
    country VARCHAR (45) NOT NULL,
    postcode VARCHAR (10) NOT NULL,
    contact_name VARCHAR (45) NOT NULL,
    email VARCHAR (45) UNIQUE NOT NULL,
    phone VARCHAR (45) NOT NULL,
    PRIMARY KEY (seller_id)
);


-- bridge table order_products
CREATE TABLE order_products (
	order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    CONSTRAINT fk_order_products_customer_order FOREIGN KEY (order_id) REFERENCES customer_order (order_id),
    CONSTRAINT fk_order_products_product FOREIGN KEY (product_id) REFERENCES product (product_id),
    CONSTRAINT chk_order_quantity 
		CHECK (quantity > 0)
);

    
-- bridge table supplier_product
CREATE TABLE supplier_product (
	product_id INT,
    supplier_id INT,
    unit_cost DECIMAL (10,2) NOT NULL, 
    PRIMARY KEY (product_id, supplier_id),
    CONSTRAINT fk_supplier_product_product FOREIGN KEY (product_id) REFERENCES product (product_id),
    CONSTRAINT fk_supplier_product_supplier FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id),
    CONSTRAINT chk_unit_cost CHECK( unit_cost > 0)
);

-- bridge table product_location
CREATE TABLE product_location(
	inventory_location_id INT,
    product_id INT,
    quantity INT NOT NULL,
    PRIMARY KEY (inventory_location_id, product_id),
    CONSTRAINT fk_product_location_inventory FOREIGN KEY (inventory_location_id) REFERENCES inventory (inventory_location_id),
	CONSTRAINT fk_product_location_product FOREIGN KEY (product_id) REFERENCES product (product_id),
    CONSTRAINT chk_product_location_quantity CHECK (quantity >= 0)
);

-- bridge table seller_product
CREATE TABLE seller_product (
	product_id INT,
    seller_id INT,
    listing_price DECIMAL (10,2) NOT NULL, 
    PRIMARY KEY (product_id, seller_id),
    CONSTRAINT fk_seller_product_product FOREIGN KEY (product_id) REFERENCES product (product_id),
    CONSTRAINT fk_seller_product_third_party_seller FOREIGN KEY (seller_id) REFERENCES third_party_seller (seller_id),
    CONSTRAINT chk_listing_price CHECK (listing_price > 0)
);
