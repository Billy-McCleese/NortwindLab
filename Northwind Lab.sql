

--1. Select all the rows from the "Customers" table. 
SELECT * FROM Customers

--2. Get distinct countries from the Customers table.
SELECT DISTINCT Country
FROM Customers;

--3. Get all the rows from the table Customers where the Customer’s ID starts with “BL”.
SELECT * FROM Customers WHERE CustomerID LIKE 'BL%';

--4. Get the first 100 records of the orders table. DISCUSS: Why would you do this? What else would you likely need to include in this query?
    -- You may need to do this to find a sample of entires in a table to ensure the data is not missing. You would need to add each field in the orders table to return. 
SELECT TOP (100) [OrderID]
      ,[CustomerID]
      ,[EmployeeID]
      ,[OrderDate]
      ,[RequiredDate]
      ,[ShippedDate]
      ,[ShipVia]
      ,[Freight]
      ,[ShipName]
      ,[ShipAddress]
      ,[ShipCity]
      ,[ShipRegion]
      ,[ShipPostalCode]
      ,[ShipCountry]
  FROM [NORTHWND].[dbo].[Orders]

  --5. Get all customers that live in the postal codes 1010, 3012, 12209, and 05023.
  SELECT *
FROM Customers
WHERE PostalCode IN ('1010', '3012', '12209', '05023');

--6. Get all orders where the ShipRegion is not equal to NULL.
Select *
FROM Customers
WHERE Region is NULL

--7. Get all customers ordered by the country, then by the city.
SELECT * 
FROM Customers
ORDER BY Country, City;

--8. Add a new customer to the customers table. You can use whatever values.
INSERT INTO Customers(CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax)
VALUES('Billy', 'Billy Industries', 'Billy Mccleese', 'CEO','123 Easy Street', 'Easytwon', 'Nortwest', '48555', 'USA', '1-313-111-1111', '1-313-111-8888');

--9. Update all ShipRegion to the value ‘EuroZone’ in the Orders table, where the ShipCountry is equal to France. 
UPDATE Orders
SET ShipRegion = 'EuroZone'
WHERE CustomerID in (SELECT CustomerID FROM Customers WHERE ShipCountry = 'France')

--10. Delete all orders from OrderDetails that have quantity of 1.
DELETE [Order Details]
WHERE OrderID in (SELECT OrderID FROM [Order Details] WHERE Quantity = 1)

--11. Find the CustomerID that placed order 10290 (orders table).
SELECT	CustomerID
FROM Orders
WHERE OrderID = 10290

--12. Join the orders table to the customers table.
SELECT *
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID

--13. Get employees’ firstname for all employees who report to no one.
SELECT Employees.FirstName
FROM Employees
WHERE ReportsTo IS NULL 

--14.Get employees’ firstname for all employees who report to Andrew.
SELECT Employees.FirstName
FROM Employees
WHERE ReportsTo = 2

-- EXTRA CHALLENGES -- 
--1. Calculate the average, max, and min of the quantity at the orderdetails table, grouped by the orderid. 
SELECT OrderID, AVG(Quantity) AS avg_quantity, MAX(Quantity) AS max_quantity, MIN(Quantity) AS min_quantity
FROM [Order Details]
GROUP BY OrderID

--2. Calculate the average, max, and min of the quantity at the orderdetails table.
SELECT AVG(Quantity) AS avg_quantity, MAX(Quantity) AS max_quantity, MIN(Quantity) AS min_quantity
FROM [Order Details]

--3. Find all customers living in London or Paris
SELECT Customers.ContactName
FROM Customers
WHERE City IN ('London', 'Paris')

--4. Do an inner join, left join, right join on orders and customers tables
SELECT *
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

SELECT *
FROM Customers
LEFT JOIN Orders ON Orders.CustomerID = Customers.CustomerID;

SELECT *
FROM Orders
Right JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

--5. Make a list of cities where customers are coming from. The list should not have any duplicates or nulls.
SELECT DISTINCT City
FROM Customers
WHERE City IS NOT NULL

--6. Show a sorted list of employees’ first names. 
SELECT FirstName 
FROM Employees
ORDER BY FirstName

--7. Find total for each order
SELECT OrderID, ROUND(SUM(Quantity * UnitPrice - (Quantity * UnitPrice) * Discount), 2) AS Total
FROM [Order Details]
GROUP BY OrderID

--8. Get a list of all employees who got hired between 1/1/1994 and today
SELECT *
FROM Employees
WHERE HireDate BETWEEN CONVERT(datetime, '1994-01-01', 120) AND GETDATE()

--9. Find how long employees have been working for Northwind (in years!)
SELECT EmployeeID, FirstName, LastName, DATEDIFF(day, HireDate, GETDATE()) / 365.25 AS YearsEmployed
FROM Employees

--10. Get a list of all products sorted by quantity (ascending and descending order)
--Ascending 
SELECT * 
FROM Products
ORDER BY UnitsInStock ASC
 
 --Descending
 SELECT * 
FROM Products
ORDER BY UnitsInStock DESC

--11. Find all products that are low on stock (quantity less than 6)
Select ProductName
From Products
WHERE UnitsInStock < 6

--12. Find a list of all discontinued products. 
Select ProductName
From Products
WHERE Discontinued = 1

--13. Find a list of all products that have Tofu in them.
Select *
From Products
WHERE ProductName LIKE '%tofu%'

--14. Find the product that has the highest unit price. 
Select ProductName
From Products
WHERE UnitPrice = (SELECT MAX(UnitPrice) 
					FROM Products)

--15. Get a list of all employees who got hired after 1/1/1993
SELECT * 
FROM Employees
WHERE HireDate > '1993-01-01'

--16. Get all employees who have title : “Ms.” And “Mrs.”
SELECT * 
FROM Employees
WHERE TitleOfCourtesy IN ('MS.', 'Mrs.')

--17. Get all employees who have a Home phone number that has area code 206
SELECT *
FROM Employees
WHERE HomePhone LIKE '%206%'