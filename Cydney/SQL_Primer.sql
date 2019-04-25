USE AdventureWorks2017 
GO 

-- Straight query, all rows from a table 
SELECT	c.*
FROM	Sales.Customer c

-- Query with filter 
SELECT	c.* 
FROM	Sales.Customer c 
WHERE	StoreID = 1024 

-- Grouping (aggregates)
SELECT	a.City, 
		COUNT(*) [NumberOfCityResidents]
FROM	Person.[Address] a
GROUP	BY a.City 

-- Other aggregates 
SELECT	ProductID, MIN(StandardCost) [MinimumCost]
FROM	Production.ProductCostHistory 
GROUP	BY ProductID

-- Aggregate combining a join
SELECT	t.[Name], SUM(s.TotalDue) [TotalAmountSpent]
FROM	Sales.SalesTerritory t 
INNER	JOIN Sales.SalesOrderHeader s ON t.TerritoryID = s.TerritoryID 
GROUP	BY t.[Name] 

-- Filter using a subquery and IN - an alternative to joining
SELECT	i.*
FROM	Production.ProductInventory i
WHERE	i.ProductID IN ( 
		SELECT	l.LocationID
		FROM	Production.[Location] l 
		WHERE	l.[Name] LIKE ('%Paint%') )

-- Ordering results 
SELECT	h.*
FROM	Sales.SalesOrderHeader h 
ORDER	BY h.DueDate ASC

-- Five types of JOIN - inner, left, right, full and cross 
-- Inner - all rows from both sides of join
-- Left - all rows from left side of join and all matching rows from right, with NULL for non-matches 
-- Right - all rows from right side of join and all matching rows from left, with NULL for non-matches 
-- Full - combination of left and right, with NULL for non-matches 
-- Cross - Cartesian product (multiplication) of rows from left and right.

-- All JOINs have an ON clause. 
-- This links the keys of the join - the columns in common between the two tables on which you're combining them.

-- Example - LEFT JOIN 

SELECT	d.GroupName, COUNT(*) [NumberOfPastAndCurrentEmployees]
FROM	HumanResources.Department d 
LEFT	JOIN HumanResources.EmployeeDepartmentHistory h ON d.DepartmentID = h.DepartmentID 
LEFT	JOIN HumanResources.Employee e ON h.BusinessEntityID = e.BusinessEntityID 
GROUP	BY d.GroupName 
ORDER	BY d.GroupName ASC 

-- What if a department had no employees? 
-- The INNER JOIN would exclude the department from the results.
-- The LEFT JOIN would include the department but report 0 employees.

-- What if some employees were not assigned to a department?
-- The INNER JOIN would exclude the employees from the results 
-- The RIGHT JOIN would include the employees and display NULL for the department.

-- We can play with this idea by modifying the data.
-- Run the code below to remove around 50% of the employee/department history rows.
DELETE	oq 
FROM	(
		SELECT	ROW_NUMBER() OVER ( ORDER BY ( SELECT NULL ) ) [rid], h.BusinessEntityID, h.DepartmentID
		FROM	HumanResources.EmployeeDepartmentHistory h ) sq 
INNER	JOIN HumanResources.EmployeeDepartmentHistory oq 
		ON sq.BusinessEntityID = oq.BusinessEntityID 
		AND sq.DepartmentID = oq.DepartmentID 
WHERE	sq.rid % 2 = 0 

-- Now try:
SELECT	d.GroupName, COUNT(*) [NumberOfPastAndCurrentEmployees]
FROM	HumanResources.Department d 
RIGHT	JOIN HumanResources.EmployeeDepartmentHistory h ON d.DepartmentID = h.DepartmentID 
INNER	JOIN HumanResources.Employee e ON h.BusinessEntityID = e.BusinessEntityID 
GROUP	BY d.GroupName 
ORDER	BY d.GroupName ASC 

-- Play with the query above and try to get different row counts until you understand JOINs more fully.

---
/*
SUMMARY:

SELECT - which columns do you want?
FROM - from which tables?
WHERE - filter by what criteria?
ORDER BY - present the results in order 
JOINs - see definitions in the comments above 
SUM(), AVG(), MIN(), MAX() - aggregates ... always require GROUP BY 
GROUP BY - by which column are we grouping the results?
IN - where something is in something else i.e. ...x IN('a','b') means where x is either a or b
    Can also be used for a subquery (as per example above)
LIKE - wildcard search - ... x LIKE ('%pizza%') brings back 'Pepperoni pizza' and 'Pizza and chips' 

Structure ...
SELECT
FROM 
WHERE 
GROUP BY 
ORDER BY 

*/
---