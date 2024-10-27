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
