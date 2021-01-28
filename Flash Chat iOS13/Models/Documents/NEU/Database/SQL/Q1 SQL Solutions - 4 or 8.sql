
-- Question 3 (2 points)

with temp as
(select month(OrderDate) Month, count(distinct color) Colors
from Sales.SalesOrderHeader sh
join Sales.SalesOrderDetail sd
on sh.SalesOrderID = sd.SalesOrderID
join Production.Product p
on sd.ProductID = p.ProductID
where year(OrderDate) = 2007 and p.Color is not null
group by month(OrderDate))

select Month, Colors
from temp 
where Colors > 6
order by Month;



-- Question 4 (2 points)

WITH Temp1 AS

   (select sh.TerritoryID, name, sum(TotalDue) ttl
    from Sales.SalesOrderHeader sh
	join Sales.SalesTerritory t
	on sh.TerritoryID = t.TerritoryID
    group by sh.TerritoryID, name) ,

Temp2 AS

   (select sum(TotalDue) ttl
	from Sales.SalesOrderHeader)

select t1.territoryid, name, t1.ttl / t2.ttl * 100 [% of Total Sale]
from temp1 t1
cross join temp2 t2
order by t1.ttl desc;



-- Question 5 (3 points)

with temp as
(select year(OrderDate) year, sh.SalesOrderID, TotalDue,  sum(OrderQty) total,
rank() over (partition by year(OrderDate) order by TotalDue desc) as ranking
from Sales.SalesOrderHeader sh
join Sales.SalesOrderDetail sd
on sh.SalesOrderID = sd.SalesOrderID
group by year(OrderDate), sh.SalesOrderID, TotalDue)

select t.year, t.SalesOrderID, t.TotalDue, t.total
from temp t
where ranking = 1
order by year;


