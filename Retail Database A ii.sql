create database retail;
use retail;

CREATE TABLE Fact_Sales (
    Sales_ID INT PRIMARY KEY,
    Product_ID INT,
    Customer_ID INT,
    Store_ID INT,
    Date_ID INT,
    Quantity INT,
    Sales_Amount DECIMAL(10,2),
    Discount DECIMAL(10,2),

    FOREIGN KEY (Product_ID) REFERENCES Dim_Product(Product_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Dim_Customer(Customer_ID),
    FOREIGN KEY (Store_ID) REFERENCES Dim_Store(Store_ID),
    FOREIGN KEY (Date_ID) REFERENCES Dim_Date(Date_ID)
);

CREATE TABLE Dim_Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100),
    Category VARCHAR(50),
    Brand VARCHAR(50),
    Unit_Price DECIMAL(10,2)
);

CREATE TABLE Dim_Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Gender VARCHAR(10),
    City VARCHAR(50),
    Age INT
);

CREATE TABLE Dim_Store (
    Store_ID INT PRIMARY KEY,
    Store_Name VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    Store_Type VARCHAR(50)
);

CREATE TABLE Dim_Date (
    Date_ID INT PRIMARY KEY,
    Full_Date DATE,
    Day INT,
    Month INT,
    Month_Name VARCHAR(20),
    Quarter INT,
    Year INT
);

INSERT INTO Dim_Product
(Product_ID, Product_Name, Category, Brand, Unit_Price)
VALUES
(101, 'T-Shirt', 'Clothing', 'Nike', 1200.00),
(102, 'Jeans', 'Clothing', 'Levis', 2500.00),
(103, 'Running Shoes', 'Footwear', 'Adidas', 3500.00),
(104, 'Watch', 'Accessories', 'Fastrack', 1800.00),
(105, 'Backpack', 'Bags', 'Wildcraft', 2200.00);

INSERT INTO Dim_Customer
(Customer_ID, Customer_Name, Gender, City, Age)
VALUES
(201, 'Arun', 'Male', 'Chennai', 25),
(202, 'Priya', 'Female', 'Madurai', 28),
(203, 'John', 'Male', 'Bangalore', 30),
(204, 'Divya', 'Female', 'Chennai', 24),
(205, 'Rahul', 'Male', 'Coimbatore', 32);

INSERT INTO Dim_Store
(Store_ID, Store_Name, City, State, Store_Type)
VALUES
(301, 'Chennai Central', 'Chennai', 'Tamil Nadu', 'Mall'),
(302, 'Madurai Mall', 'Madurai', 'Tamil Nadu', 'Mall'),
(303, 'Bangalore Store', 'Bangalore', 'Karnataka', 'Standalone'),
(304, 'Coimbatore Store', 'Coimbatore', 'Tamil Nadu', 'Standalone');

INSERT INTO Dim_Date
(Date_ID, Full_Date, Day, Month, Month_Name, Quarter, Year)
VALUES
(1, '2026-09-01', 1, 9, 'September', 3, 2026),
(2, '2026-09-02', 2, 9, 'September', 3, 2026),
(3, '2026-09-03', 3, 9, 'September', 3, 2026),
(4, '2026-09-04', 4, 9, 'September', 3, 2026),
(5, '2026-09-05', 5, 9, 'September', 3, 2026);

INSERT INTO Fact_Sales
(Sales_ID, Product_ID, Customer_ID, Store_ID, Date_ID,
 Quantity, Sales_Amount, Discount)
VALUES
(1001, 101, 201, 301, 1, 2, 2400.00, 100.00),
(1002, 102, 202, 302, 2, 1, 2500.00, 150.00),
(1003, 103, 203, 303, 3, 1, 3500.00, 200.00),
(1004, 104, 204, 301, 4, 2, 3600.00, 300.00),
(1005, 105, 205, 304, 5, 1, 2200.00, 100.00),
(1006, 101, 202, 302, 5, 3, 3600.00, 200.00),
(1007, 103, 201, 301, 3, 2, 7000.00, 500.00);

SELECT * FROM Dim_Product;
SELECT * FROM Dim_Customer;
SELECT * FROM Dim_Store;
SELECT * FROM Dim_Date;
SELECT * FROM Fact_Sales;

-- total sales amount for each product category in each city
SELECT
    p.Category,
    s.City,
    SUM(f.Sales_Amount) AS Total_Sales
FROM Fact_Sales f
JOIN Dim_Product p
    ON f.Product_ID = p.Product_ID
JOIN Dim_Store s
    ON f.Store_ID = s.Store_ID
GROUP BY p.Category, s.City;

-- total daily sales for each store
SELECT
    d.Full_Date,
    s.Store_Name,
    SUM(f.Sales_Amount) AS Total_Sales
FROM Fact_Sales f
JOIN Dim_Date d
    ON f.Date_ID = d.Date_ID
JOIN Dim_Store s
    ON f.Store_ID = s.Store_ID
GROUP BY d.Full_Date, s.Store_Name
ORDER BY d.Full_Date;