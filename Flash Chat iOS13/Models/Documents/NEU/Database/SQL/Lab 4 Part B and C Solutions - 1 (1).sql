
------------
-- PART B --
------------
USE AdventureWorks2008R2;

Select distinct SalesOrderID, 
Stuff((Select ', ' + rtrim(cast(ProductId as char)) 
       From Sales.SalesOrderDetail 
       Where SalesOrderId = h.SalesOrderId
       Order By ProductId
       FOR XML PATH('')) , 1, 2, '') as Products
From Sales.SalesOrderHeader h
Order by h.SalesOrderID


------------
-- PART C --
------------
USE AdventureWorks2008R2;

-- Creating temporary table #temp_aq_component_list
WITH Parts(AssemblyID, ComponentID, PerAssemblyQty, EndDate, ComponentLevel) AS
(
SELECT b.ProductAssemblyID, b.ComponentID, b.PerAssemblyQty,
b.EndDate, 0 AS ComponentLevel
FROM Production.BillOfMaterials AS b
WHERE b.ProductAssemblyID = 992 AND b.EndDate IS NULL
UNION ALL
SELECT bom.ProductAssemblyID, bom.ComponentID, p.PerAssemblyQty,
bom.EndDate, ComponentLevel + 1
FROM Production.BillOfMaterials AS bom
INNER JOIN Parts AS p
ON bom.ProductAssemblyID = p.ComponentID AND bom.EndDate IS NULL
)
SELECT AssemblyID, ComponentID, ListPrice, Name, PerAssemblyQty, ComponentLevel,
Rank() over (Partition by ComponentLevel Order By ListPrice Desc) as PricePerLevel
Into #temp_aq_component_list
FROM Parts AS p
INNER JOIN Production.Product AS pr
ON p.ComponentID = pr.ProductID
ORDER BY ComponentLevel, PricePerLevel, AssemblyID, ComponentID

-- Using temporary table #temp_aq_component_list to filter the most expensive component(s) per level
Select ComponentLevel, AssemblyID, ListPrice, ComponentID, Name
From #temp_aq_component_list
Where PricePerLevel = 1
Order by ComponentLevel

-- Deleting temporary table #temp_aq_component_list
Drop Table #temp_aq_component_list
