
/* Lab 2 Solutions */

-- 2-1
Select ProductID, 
       Name, 
       cast(SellStartDate as date) as 'Sell Start Date'
From Production.Product
Where SellStartDate > '02/01/2006' and color = 'Yellow'
Order by SellStartDate;

-- 2-2
Select CustomerID, 
       AccountNumber, 
       max(cast(OrderDate as date)) as 'Latest Order Date', 
       count(SalesOrderId) as 'Total Orders'
From Sales.SalesOrderHeader
Group By CustomerID, AccountNumber
Order by CustomerID;

-- 2-3
Select ProductID, 
       Name,
       ListPrice
From Production.Product
Where ListPrice > (Select avg(ListPrice) From Production.Product)
ORDER BY ProductID;

-- 2-4
Select p.ProductID, 
       p.Name,
       sum(sod.OrderQty) as 'Total Sold Quantity'
From Production.Product p 
join Sales.SalesOrderDetail sod
on p.ProductID = sod.ProductID
Group By p.ProductID, p.Name
Having sum(sod.OrderQty) > 50 
Order by sum(sod.OrderQty) desc;

-- 2-5
select sh.SalesPersonID, sh.SalesOrderID, count(distinct sd.ProductID) [Product Count]
from Sales.SalesOrderHeader sh
join Sales.SalesOrderDetail sd
on sh.SalesOrderID = sd.SalesOrderID
group by sh.SalesPersonID, sh.SalesOrderID
having count(distinct sd.ProductID) > 70
order by SalesPersonID;

-- 2-6
Select ProductID, Name 
From Production.Product
Where ProductID not in 
   (Select distinct sod.ProductID
    From Sales.SalesOrderHeader soh 
    join Sales.SalesOrderDetail sod
    on soh.SalesOrderID = sod.SalesOrderID
    Where year(OrderDate) = '2007')
Order by ProductID;

-- OR
Select p.ProductID, p.Name
From Production.Product p 
left outer join 
  ( Select distinct ProductID
    From Sales.SalesOrderHeader soh 
	left join Sales.SalesOrderDetail sod
    on soh.SalesOrderID = sod.SalesOrderID
    Where year(OrderDate) = '2007'
  ) sales 
on p.ProductID = sales.ProductID
Where sales.ProductID is null
Order by p.ProductID;


