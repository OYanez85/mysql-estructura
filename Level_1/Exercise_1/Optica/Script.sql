CREATE DATABASE OpticsDB;

USE OpticsDB;

CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Address_Street VARCHAR(100),
    Address_Number VARCHAR(10),
    Address_Floor VARCHAR(10),
    Address_Door VARCHAR(10),
    City VARCHAR(50),
    PostalCode VARCHAR(10),
    Country VARCHAR(50),
    Phone VARCHAR(20),
    Fax VARCHAR(20),
    NIF VARCHAR(20) UNIQUE
);

CREATE TABLE Glasses (
    GlassesID INT PRIMARY KEY AUTO_INCREMENT,
    Brand VARCHAR(50) NOT NULL,
    Prescription_LeftEye DECIMAL(4,2),
    Prescription_RightEye DECIMAL(4,2),
    FrameType ENUM('rimless', 'plastic', 'metal'),
    FrameColor VARCHAR(30),
    LensColor_Left VARCHAR(30),
    LensColor_Right VARCHAR(30),
    Price DECIMAL(10, 2) NOT NULL,
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Address_Street VARCHAR(100),
    Address_Number VARCHAR(10),
    Address_Floor VARCHAR(10),
    Address_Door VARCHAR(10),
    City VARCHAR(50),
    PostalCode VARCHAR(10),
    Country VARCHAR(50),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    RegistrationDate DATE,
    ReferredByCustomerID INT,
    FOREIGN KEY (ReferredByCustomerID) REFERENCES Customer(CustomerID) ON DELETE SET NULL
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY AUTO_INCREMENT,
    GlassesID INT NOT NULL,
    CustomerID INT NOT NULL,
    EmployeeID INT NOT NULL,
    SaleDate DATE NOT NULL,
    FOREIGN KEY (GlassesID) REFERENCES Glasses(GlassesID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

SELECT 
    Sales.SaleID, 
    Glasses.Brand, 
    Glasses.Price, 
    Customer.Name AS CustomerName, 
    Employee.Name AS EmployeeName, 
    Sales.SaleDate
FROM Sales
JOIN Glasses ON Sales.GlassesID = Glasses.GlassesID
JOIN Customer ON Sales.CustomerID = Customer.CustomerID
JOIN Employee ON Sales.EmployeeID = Employee.EmployeeID;

SELECT 
    c1.Name AS CustomerName, 
    c2.Name AS ReferredBy 
FROM Customer c1
LEFT JOIN Customer c2 ON c1.ReferredByCustomerID = c2.CustomerID;


INSERT INTO Supplier (Name, Address_Street, Address_Number, City, PostalCode, Country, Phone, Fax, NIF)
VALUES ('Best Optics Supply', 'Main Street', '123', 'Barcelona', '08001', 'Spain', '+34 123456789', '+34 987654321', 'B12345678');


INSERT INTO Glasses (Brand, Prescription_LeftEye, Prescription_RightEye, FrameType, FrameColor, LensColor_Left, LensColor_Right, Price, SupplierID)
VALUES ('Ray-Ban', -2.50, -2.00, 'metal', 'black', 'green', 'green', 150.00, 1);



INSERT INTO Customer (Name, Address_Street, Address_Number, City, PostalCode, Country, Phone, Email, RegistrationDate)
VALUES ('John Doe', 'Calle Mayor', '5', 'Madrid', '28013', 'Spain', '+34 111222333', 'john.doe@example.com', '2024-10-23');



INSERT INTO Employee (Name, Phone, Email)
VALUES ('Alice Smith', '+34 555666777', 'alice.smith@example.com');



INSERT INTO Sales (GlassesID, CustomerID, EmployeeID, SaleDate)
VALUES (1, 1, 1, '2024-10-23');

SELECT * FROM Supplier;

SELECT * FROM Glasses;

SELECT * FROM Customer;

SELECT * FROM Employee;

SELECT * FROM Sales;


SELECT 
    Sales.SaleID, 
    Glasses.Brand, 
    Glasses.Price, 
    Customer.Name AS CustomerName, 
    Employee.Name AS EmployeeName, 
    Sales.SaleDate
FROM Sales
JOIN Glasses ON Sales.GlassesID = Glasses.GlassesID
JOIN Customer ON Sales.CustomerID = Customer.CustomerID
JOIN Employee ON Sales.EmployeeID = Employee.EmployeeID;


