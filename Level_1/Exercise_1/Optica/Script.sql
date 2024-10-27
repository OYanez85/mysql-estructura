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

