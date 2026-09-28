create database supermarket;
use supermarket;

CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

INSERT INTO Category VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Grocery'),
(4, 'Furniture'),
(5, 'Footwear');

CREATE TABLE Subcategory (
    subcategory_id INT PRIMARY KEY,
    subcategory_name VARCHAR(50),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

INSERT INTO Subcategory VALUES
(101, 'Mobile Phones', 1),
(102, 'Laptops', 1),
(103, 'Mens Wear', 2),
(104, 'Groceries', 3),
(105, 'Sports Shoes', 5);

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    subcategory_id INT,
    FOREIGN KEY (subcategory_id) REFERENCES Subcategory(subcategory_id)
);

INSERT INTO Product VALUES
(1001, 'Samsung Galaxy A15', 18000.00, 101),
(1002, 'HP Laptop', 55000.00, 102),
(1003, 'Mens T-Shirt', 1200.00, 103),
(1004, 'Basmati Rice 5kg', 650.00, 104),
(1005, 'Running Shoes', 3500.00, 105);

CREATE TABLE State (
    state_id INT PRIMARY KEY,
    state_name VARCHAR(50)
);

INSERT INTO State VALUES
(201, 'Tamil Nadu'),
(202, 'Karnataka'),
(203, 'Kerala'),
(204, 'Telangana'),
(205, 'Andhra Pradesh');

CREATE TABLE City (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(50),
    state_id INT,
    FOREIGN KEY (state_id) REFERENCES State(state_id)
);

INSERT INTO City VALUES
(301, 'Chennai', 201),
(302, 'Bangalore', 202),
(303, 'Kochi', 203),
(304, 'Hyderabad', 204),
(305, 'Vijayawada', 205);

CREATE TABLE Store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES City(city_id)
);

INSERT INTO Store VALUES
(401, 'Chennai Main Store', 301),
(402, 'Bangalore Central Store', 302),
(403, 'Kochi Supermarket', 303),
(404, 'Hyderabad Main Store', 304),
(405, 'Vijayawada Store', 305);

CREATE TABLE Sales_Fact (
    sales_id INT PRIMARY KEY,
    product_id INT,
    store_id INT,
    sales_date DATE,
    quantity INT,
    sales_amount DECIMAL(10,2),

    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (store_id) REFERENCES Store(store_id)
);

INSERT INTO Sales_Fact VALUES
(5001, 1001, 401, '2026-09-01', 2, 36000.00),
(5002, 1002, 402, '2026-09-02', 1, 55000.00),
(5003, 1003, 403, '2026-09-03', 5, 6000.00),
(5004, 1004, 404, '2026-09-04', 3, 1950.00),
(5005, 1005, 405, '2026-09-05', 2, 7000.00);

select * from category;
select * from subcategory;
select * from product;
select * from state;
select * from city;
select * from store;
select * from sales_fact;

-- Sales by Category
SELECT
    c.category_name,
    SUM(sf.sales_amount) AS total_sales
FROM Sales_Fact sf
JOIN Product p
    ON sf.product_id = p.product_id
JOIN Subcategory sc
    ON p.subcategory_id = sc.subcategory_id
JOIN Category c
    ON sc.category_id = c.category_id
GROUP BY c.category_name;

-- Sales by State
SELECT
    s.state_name,
    SUM(sf.sales_amount) AS total_sales
FROM Sales_Fact sf
JOIN Store st
    ON sf.store_id = st.store_id
JOIN City c
    ON st.city_id = c.city_id
JOIN State s
    ON c.state_id = s.state_id
GROUP BY s.state_name;
