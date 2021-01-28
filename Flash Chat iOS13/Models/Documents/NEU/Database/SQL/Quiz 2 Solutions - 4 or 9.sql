
-- Q1

SELECT TerritoryID, ISNULL([2008-1-1], 0) '2008-1-1',
       ISNULL([2008-1-2], 0) '2008-1-2',
	   ISNULL([2008-1-3], 0) '2008-1-3',
	   ISNULL([2008-1-4], 0) '2008-1-4',
	   ISNULL([2008-1-5], 0) '2008-1-5'
FROM (SELECT TerritoryID, CAST(OrderDate AS DATE) [Order Date], sd.OrderQty
      FROM Sales.SalesOrderHeader sh
      JOIN Sales.SalesOrderDetail sd
      ON sh.SalesOrderID = sd.SalesOrderID
WHERE OrderDate BETWEEN '1-1-2008' AND '1-5-2008') AS S
PIVOT
     (SUM(OrderQty) FOR [Order Date] IN
	  ([2008-1-1], [2008-1-2], [2008-1-3], [2008-1-4], [2008-1-5]) )AS P;




-- Q2

WITH Temp1 AS

   (select month(OrderDate) Month, CustomerID, sum(TotalDue) ttl,
    rank() over (partition by month(OrderDate) order by sum(TotalDue) desc) as TopCustomer
    from Sales.SalesOrderHeader
	where year(OrderDate) = 2007
    group by month(OrderDate), CustomerID) ,

Temp2 AS

   (select month(OrderDate) Month, sum(TotalDue) ttl
	from Sales.SalesOrderHeader
	where year(OrderDate) = 2007
    group by month(OrderDate))

select t1.Month, sum(t1.ttl) / t2.ttl * 100 [% of Total Sale], cast(t2.ttl as int) [Total Territory Sale],

STUFF((SELECT  ', '+RTRIM(CAST(CustomerID as char))  
       FROM temp1 
       WHERE Month = t1.Month and TopCustomer <=3
       FOR XML PATH('')) , 1, 2, '') AS Top3Customers

from temp1 t1
join temp2 t2
on t1.Month = t2.Month
where t1.topcustomer <= 3
group by t1.Month, t2.ttl
order by t1.Month;



-- Q3

create function ufLookUpFine (@CustID int)
returns money
begin
   declare @amt money;
   select @amt = sum(Amount)
      from Fine
      where CustomerID = @CustID and PaidDate is null;
   return @amt;
end

alter table CheckOut add CONSTRAINT ckfine CHECK (dbo.ufLookUpFine (CustomerID) = 0);




-- Q4

create trigger trAuditLoan
on Loan
after INSERT
as
begin
   declare @ttlLoan int, @empID int, @enterAmount int, @yr int;
   set @yr = (select year(LoanDate) from inserted);
   set @empID = (select EmployeeID from inserted);
   select @ttlLoan = sum(LoanAmount)
      from Loan
      where EmployeeID = @empID and year(LoanDate) = @yr;

   if @ttlLoan > 10000
      begin
         rollback transaction;
         set @enterAmount = (select LoanAmount from inserted);
         insert into LoanAudit (EnteredAmount)
            values (@enterAmount);
      end
end


