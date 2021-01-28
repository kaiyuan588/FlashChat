

-- Question 1

SELECT c.CustomerID,
       c.TerritoryID,
	   COUNT(soh.SalesOrderID) [Total Orders],
	   CASE
		  WHEN COUNT(soh.SalesOrderID) = 0
			 THEN 'No Order'
		  WHEN COUNT(soh.SalesOrderID) = 1
			 THEN 'One Time'
		  WHEN COUNT(soh.SalesOrderID) BETWEEN 2 AND 5
			 THEN 'Regular'
		  WHEN COUNT(soh.SalesOrderID) BETWEEN 6 AND 10
			 THEN 'Often'
		  ELSE 'Loyal'
	   END AS [Order Frequency]
FROM Sales.Customer c
LEFT OUTER JOIN Sales.SalesOrderHeader soh
ON c.CustomerID = soh.CustomerID
WHERE DATEPART(year, OrderDate) = 2007
GROUP BY c.TerritoryID, c.CustomerID;


-- Question 2

SELECT c.CustomerID, c.TerritoryID,
COUNT(o.SalesOrderid) [Total Orders],
RANK() OVER (PARTITION BY c.TerritoryID ORDER BY COUNT
(o.SalesOrderid) DESC) AS Rank
FROM Sales.Customer c
LEFT OUTER JOIN Sales.SalesOrderHeader o
ON c.CustomerID = o.CustomerID
WHERE DATEPART(year, OrderDate) = 2007
GROUP BY c.TerritoryID, c.CustomerID;


-- Question 3
 
SELECT MAX(SP.Bonus) AS HighestBonus
FROM [Sales].[SalesPerson] SP
JOIN [Sales].[SalesTerritory] ST
ON SP.TerritoryID = ST.TerritoryID
JOIN [HumanResources].[Employee] E
ON SP.BusinessEntityID = E.BusinessEntityID
WHERE E.Gender = 'M' AND ST.[Group] = 'North America';

-- Question 4

select * from 
(select cast(a.OrderDate as DATE) AS OrderDate,
        b.ProductID, 
        sum(b.OrderQty) as total,
	    rank() OVER (PARTITION BY a.OrderDate ORDER BY sum(b.OrderQty) DESC) AS rank 
 from [Sales].[SalesOrderHeader] a
 join [Sales].[SalesOrderDetail] b
 on a.SalesOrderID =  b.SalesOrderID
 group by a.OrderDate, b.ProductID
) temp
where rank = 1
order by OrderDate;


-- Question 5

-- Solution 1
select sh.CustomerID
   from Sales.SalesOrderHeader sh
   join Sales.SalesOrderDetail sd
   on sh.SalesOrderID = sd.SalesOrderID
   where sh.OrderDate > '7-1-2008'
         and sd.ProductID = 711
intersect
   select sh.CustomerID
   from Sales.SalesOrderHeader sh
   join Sales.SalesOrderDetail sd
   on sh.SalesOrderID = sd.SalesOrderID
   where sh.OrderDate > '7-1-2008'
         and sd.ProductID = 712
order by CustomerID;

-- Solution 2
SELECT oh.CustomerID
FROM Sales.SalesOrderHeader oh
WHERE oh.OrderDate > '2008-07-01'
  AND (SELECT COUNT(DISTINCT ProductID)
       FROM Sales.SalesOrderDetail od
       WHERE od.SalesOrderID = oh.SalesOrderID
            AND od.ProductID IN (711, 712)) = 2
ORDER BY oh.CustomerID;
