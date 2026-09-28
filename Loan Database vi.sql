create database loan;
use loan;

CREATE TABLE Dim_Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Gender VARCHAR(10),
    City VARCHAR(50)
);

INSERT INTO Dim_Customer VALUES
(101, 'Arun', 'Male', 'Chennai'),
(102, 'Priya', 'Female', 'Madurai'),
(103, 'Rahul', 'Male', 'Coimbatore'),
(104, 'Divya', 'Female', 'Salem'),
(105, 'Karthik', 'Male', 'Trichy');

select * from dim_customer;

CREATE TABLE Dim_Branch (
    Branch_ID INT PRIMARY KEY,
    Branch_Name VARCHAR(100),
    City VARCHAR(50)
);

INSERT INTO Dim_Branch VALUES
(201, 'Chennai Main Branch', 'Chennai'),
(202, 'Madurai Branch', 'Madurai'),
(203, 'Coimbatore Branch', 'Coimbatore'),
(204, 'Salem Branch', 'Salem'),
(205, 'Trichy Branch', 'Trichy');

select * from dim_branch;

CREATE TABLE Dim_Date (
    Date_ID INT PRIMARY KEY,
    Full_Date DATE,
    Month INT,
    Quarter INT,
    Year INT
);

INSERT INTO Dim_Date VALUES
(1, '2026-09-01', 9, 3, 2026),
(2, '2026-09-02', 9, 3, 2026),
(3, '2026-09-03', 9, 3, 2026),
(4, '2026-09-04', 9, 3, 2026),
(5, '2026-09-05', 9, 3, 2026);

select * from date;

CREATE TABLE Fact_Loan (
    Loan_ID INT PRIMARY KEY,
    Customer_ID INT,
    Branch_ID INT,
    Date_ID INT,
    Loan_Amount DECIMAL(12,2),
    Interest_Amount DECIMAL(12,2),
    Loan_Status VARCHAR(30),

    FOREIGN KEY (Customer_ID)
        REFERENCES Dim_Customer(Customer_ID),

    FOREIGN KEY (Branch_ID)
        REFERENCES Dim_Branch(Branch_ID),

    FOREIGN KEY (Date_ID)
        REFERENCES Dim_Date(Date_ID)
);

INSERT INTO Fact_Loan VALUES
(1001, 101, 201, 1, 500000.00, 50000.00, 'Approved'),
(1002, 102, 202, 2, 300000.00, 30000.00, 'Approved'),
(1003, 103, 203, 3, 750000.00, 75000.00, 'Pending'),
(1004, 104, 204, 4, 400000.00, 40000.00, 'Rejected'),
(1005, 105, 205, 5, 600000.00, 60000.00, 'Approved');

select * from fact_loan;

CREATE TABLE Fact_Account (
    Transaction_ID INT PRIMARY KEY,
    Customer_ID INT,
    Branch_ID INT,
    Date_ID INT,
    Deposit_Amount DECIMAL(12,2),
    Withdrawal_Amount DECIMAL(12,2),
    Transaction_Type VARCHAR(30),

    FOREIGN KEY (Customer_ID)
        REFERENCES Dim_Customer(Customer_ID),

    FOREIGN KEY (Branch_ID)
        REFERENCES Dim_Branch(Branch_ID),

    FOREIGN KEY (Date_ID)
        REFERENCES Dim_Date(Date_ID)
);

INSERT INTO Fact_Account VALUES
(2001, 101, 201, 1, 50000.00, 10000.00, 'Deposit'),
(2002, 102, 202, 2, 75000.00, 20000.00, 'Deposit'),
(2003, 103, 203, 3, 30000.00, 15000.00, 'Withdrawal'),
(2004, 104, 204, 4, 90000.00, 25000.00, 'Deposit'),
(2005, 105, 205, 5, 45000.00, 10000.00, 'Withdrawal');

select * from fact_account;

-- branch that has the highest total loan amount
SELECT 
    b.Branch_Name,
    SUM(l.Loan_Amount) AS Total_Loan_Amount
FROM Fact_Loan l
JOIN Dim_Branch b
    ON l.Branch_ID = b.Branch_ID
GROUP BY b.Branch_Name
ORDER BY Total_Loan_Amount DESC;

-- customer that has the highest total deposit amount
SELECT 
    c.Customer_Name,
    SUM(a.Deposit_Amount) AS Total_Deposit
FROM Fact_Account a
JOIN Dim_Customer c
    ON a.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name
ORDER BY Total_Deposit DESC;