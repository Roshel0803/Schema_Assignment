create database ecommerce;
use ecommerce;

CREATE TABLE Fact_Sales (
    Sales_ID INT PRIMARY KEY,
    Product_ID INT,
    Customer_ID INT,
    Date_ID INT,
    Location_ID INT,
    Quantity_Sold INT,
    Revenue DECIMAL(10,2),

    FOREIGN KEY (Product_ID) REFERENCES Dim_Product(Product_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Dim_Customer(Customer_ID),
    FOREIGN KEY (Date_ID) REFERENCES Dim_Date(Date_ID),
    FOREIGN KEY (Location_ID) REFERENCES Dim_Location(Location_ID)
);

CREATE TABLE Dim_Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100),
    Category VARCHAR(50),
    Brand VARCHAR(50),
    Unit_Price DECIMAL(10,2)
);

