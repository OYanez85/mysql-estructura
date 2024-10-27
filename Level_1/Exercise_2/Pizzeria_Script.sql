CREATE DATABASE FoodOrderingDB;
USE FoodOrderingDB;

CREATE TABLE Province (
    ProvinceID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE City (
    CityID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    ProvinceID INT,
    FOREIGN KEY (ProvinceID) REFERENCES Province(ProvinceID)
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NOT NULL,
    PostalCode VARCHAR(10) NOT NULL,
    CityID INT,
    ProvinceID INT,
    Phone VARCHAR(20),
    FOREIGN KEY (CityID) REFERENCES City(CityID),
    FOREIGN KEY (ProvinceID) REFERENCES Province(ProvinceID)
);

CREATE TABLE Store (
    StoreID INT PRIMARY KEY AUTO_INCREMENT,
    Address VARCHAR(200) NOT NULL,
    PostalCode VARCHAR(10) NOT NULL,
    CityID INT,
    ProvinceID INT,
    FOREIGN KEY (CityID) REFERENCES City(CityID),
    FOREIGN KEY (ProvinceID) REFERENCES Province(ProvinceID)
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    NIF VARCHAR(20) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    Role ENUM('Cook', 'DeliveryDriver') NOT NULL,
    StoreID INT,
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID)
);

CREATE TABLE CustomerOrder (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    StoreID INT NOT NULL,
    OrderDateTime DATETIME NOT NULL,
    DeliveryType ENUM('HomeDelivery', 'InStorePickup') NOT NULL,
    TotalPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID)
);


CREATE TABLE OrderDelivery (
    OrderID INT PRIMARY KEY,
    DeliveryDriverID INT NOT NULL,
    DeliveryDateTime DATETIME,
    FOREIGN KEY (OrderID) REFERENCES CustomerOrder(OrderID),
    FOREIGN KEY (DeliveryDriverID) REFERENCES Employee(EmployeeID)
);


CREATE TABLE Category (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    Image VARCHAR(255),
    Price DECIMAL(10, 2) NOT NULL,
    CategoryID INT,
    ProductType ENUM('Pizza', 'Burger', 'Drink') NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE OrderItem (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES CustomerOrder(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Insert sample data for Province, City, Customer, and Store

INSERT INTO Province (Name) VALUES ('Province A'), ('Province B');

INSERT INTO City (Name, ProvinceID) VALUES 
('City 1', 1), 
('City 2', 1),
('City 3', 2);

INSERT INTO Customer (FirstName, LastName, Address, PostalCode, CityID, ProvinceID, Phone) VALUES 
('John', 'Doe', '123 Main St', '10001', 1, 1, '+1234567890'),
('Jane', 'Smith', '456 Oak St', '10002', 2, 1, '+1987654321');

INSERT INTO Store (Address, PostalCode, CityID, ProvinceID) VALUES 
('789 Elm St', '10003', 1, 1),
('321 Pine St', '10004', 3, 2);

-- Insert sample data for Employee

INSERT INTO Employee (FirstName, LastName, NIF, Phone, Role, StoreID) VALUES 
('Alice', 'Johnson', 'NIF123456', '+12012345678', 'Cook', 1),
('Bob', 'Brown', 'NIF654321', '+13012345679', 'DeliveryDriver', 1),
('Carol', 'Davis', 'NIF789456', '+14012345670', 'Cook', 2);

-- Insert sample data for Category and Product

INSERT INTO Category (Name) VALUES ('Classic Pizzas'), ('Gourmet Pizzas'), ('Beverages');

INSERT INTO Product (Name, Description, Image, Price, CategoryID, ProductType) VALUES 
('Margherita Pizza', 'Classic cheese pizza', 'margherita.jpg', 8.50, 1, 'Pizza'),
('Pepperoni Pizza', 'Pizza with pepperoni', 'pepperoni.jpg', 9.00, 1, 'Pizza'),
('Cola', 'Soft drink', 'cola.jpg', 2.00, 3, 'Drink'),
('Water', 'Bottled water', 'water.jpg', 1.50, 3, 'Drink');

-- Insert sample data for CustomerOrder and OrderItem

INSERT INTO CustomerOrder (CustomerID, StoreID, OrderDateTime, DeliveryType, TotalPrice) VALUES 
(1, 1, '2024-10-23 12:00:00', 'HomeDelivery', 20.00),
(2, 2, '2024-10-23 14:30:00', 'InStorePickup', 15.00),
(1, 1, '2024-10-24 13:45:00', 'HomeDelivery', 18.50);

INSERT INTO OrderItem (OrderID, ProductID, Quantity) VALUES 
(1, 3, 2),   -- 2 Cola drinks
(1, 1, 1),   -- 1 Margherita Pizza
(2, 4, 1),   -- 1 Water
(3, 2, 1),   -- 1 Pepperoni Pizza
(3, 3, 3);   -- 3 Cola drinks

-- Insert sample data for OrderDelivery

INSERT INTO OrderDelivery (OrderID, DeliveryDriverID, DeliveryDateTime) VALUES 
(1, 2, '2024-10-23 12:30:00'),
(3, 2, '2024-10-24 14:15:00');

-- 1. List how many products from the 'Drinks' category have been sold in a specific city

SELECT 
    COUNT(OrderItem.OrderItemID) AS DrinksSold,
    City.Name AS CityName
FROM OrderItem
JOIN Product ON OrderItem.ProductID = Product.ProductID
JOIN CustomerOrder ON OrderItem.OrderID = CustomerOrder.OrderID
JOIN Customer ON CustomerOrder.CustomerID = Customer.CustomerID
JOIN City ON Customer.CityID = City.CityID
WHERE Product.ProductType = 'Drink' AND City.Name = 'City 1'
GROUP BY City.Name;

-- Replace 'specific_city_name' with the name of the city you want to check.

-- 2. List how many orders a specific employee has processed

SELECT 
    Employee.FirstName AS EmployeeFirstName,
    Employee.LastName AS EmployeeLastName,
    COUNT(OrderDelivery.OrderID) AS OrdersProcessed
FROM OrderDelivery
JOIN Employee ON OrderDelivery.DeliveryDriverID = Employee.EmployeeID
WHERE Employee.FirstName = 'Bob' AND Employee.LastName = 'Brown'
GROUP BY Employee.EmployeeID;

-- Replace 'specific_employee_name' with the name of the employee you want to check.