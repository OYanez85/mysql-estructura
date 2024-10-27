-- 1. List the total invoices of a client over a specific period

SELECT 
    Customer.Name AS CustomerName,
    COUNT(Sales.SaleID) AS TotalInvoices,
    SUM(Glasses.Price) AS TotalAmount
FROM Sales
JOIN Customer ON Sales.CustomerID = Customer.CustomerID
JOIN Glasses ON Sales.GlassesID = Glasses.GlassesID
WHERE Sales.SaleDate BETWEEN 'start_date' AND 'end_date'
GROUP BY Customer.CustomerID;

-- Replace 'start_date' and 'end_date' with the desired date range.

-- 2. List the different models of glasses sold by an employee during a year

SELECT 
    Employee.Name AS EmployeeName,
    Glasses.Brand AS GlassesBrand,
    COUNT(Sales.SaleID) AS UnitsSold
FROM Sales
JOIN Employee ON Sales.EmployeeID = Employee.EmployeeID
JOIN Glasses ON Sales.GlassesID = Glasses.GlassesID
WHERE YEAR(Sales.SaleDate) = 'target_year'
GROUP BY Employee.EmployeeID, Glasses.Brand;

-- Replace 'target_year' with the specific year (e.g., 2024).

-- 3. List the different suppliers who have successfully provided glasses sold by the optics

SELECT DISTINCT 
    Supplier.Name AS SupplierName,
    Supplier.City AS SupplierCity,
    Supplier.Country AS SupplierCountry
FROM Sales
JOIN Glasses ON Sales.GlassesID = Glasses.GlassesID
JOIN Supplier ON Glasses.SupplierID = Supplier.SupplierID;
