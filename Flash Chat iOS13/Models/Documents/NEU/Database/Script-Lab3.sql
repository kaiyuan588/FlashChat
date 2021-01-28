USE AdventureWorks2008R2
SELECT c.CustomerID, c.TerritoryID,
COUNT(o.SalesOrderid) [Total Orders],
CASE 
	WHEN COUNT(o.SalesOrderid) = 0
		THEN 'No Order'
		WHEN COUNT(o.SalesOrderid) = 1
			THEN 'One Time'
			WHEN 2 <= COUNT(o.SalesOrderid) AND  COUNT(o.SalesOrderid) <= 5
				THEN 'Regular'
					WHEN  6 <= COUNT(o.SalesOrderid) AND COUNT(o.SalesOrderid) <= 10
						THEN 'Often'
						WHEN COUNT(o.SalesOrderid) > 10
							THEN 'Loyal'
							END AS PriceComparsion
FROM Sales.Customer c
LEFT OUTER JOIN Sales.SalesOrderHeader o
 ON c.CustomerID = o.CustomerID
WHERE DATEPART(year, OrderDate) = 2007
GROUP BY c.TerritoryID, c.CustomerID;






USE AdventureWorks2008R2
SELECT c.CustomerID, c.TerritoryID,
COUNT(o.SalesOrderid) [Total Orders], RANK() OVER(PARTITION BY c.TerritoryID ORDER BY COUNT(o.SalesOrderID) DESC) AS RankTotalOrder
FROM Sales.Customer c
LEFT OUTER JOIN Sales.SalesOrderHeader o
ON c.CustomerID = o.CustomerID
WHERE DATEPART(year, OrderDate) = 2007
GROUP BY c.TerritoryID, c.CustomerID;







USE AdventureWorks2008R2
SELECT t.[Group], g.Gender, MAX(o.Bonus) AS MaxBonus from Sales.SalesTerritory t 
INNER JOIN Sales.SalesPerson o ON t.TerritoryID = o.TerritoryID 
INNER JOIN HumanResources.Employee g ON o.BusinessEntityID = g.BusinessEntityID 
WHERE g.Gender = 'M' AND t.[Group] = 'North America' GROUP BY t.[Group], g.Gender







USE AdventureWorks2008R2
SELECT DISTINCT CAST(sdh.OrderDate AS DATE) OrderDate, sd.ProductId, SUM(sd.OrderQty) AS [Total Order] FROM Sales.SalesOrderDetail sd 
INNER JOIN Sales.SalesOrderHeader sdh ON sdh.SalesOrderID = sd.SalesOrderID
GROUP BY sd.ProductId, CAST(sdh.OrderDate AS DATE) ORDER BY OrderDate;



USE AdventureWorks2008R2
SELECT sd.ProductID, ssh.OrderDate, ssh.CustomerID FROM Sales.SalesOrderDetail sd INNER JOIN Sales.SalesOrderHeader ssh ON sd.SalesOrderID = ssh.SalesOrderID 
WHERE ssh.OrderDate > '2008/07/01' AND (sd.ProductID = '711' OR sd.ProductID = '712') ORDER BY ssh.CustomerID;