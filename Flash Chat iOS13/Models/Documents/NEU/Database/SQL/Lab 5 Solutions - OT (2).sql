use test;
/* Question 1 */
CREATE FUNCTION ufGetSale (@beg_year INT,@end_year INT,@month INT)
RETURNS MONEY
AS BEGIN
  DECLARE @Output MONEY = 0;
  SELECT @Output = SUM(TotalDue) FROM AdventureWorks2008R2.Sales.SalesOrderHeader
  WHERE DATEPART(YEAR, OrderDate) BETWEEN @beg_year AND @end_year
	AND DATEPART(MONTH, OrderDate) = @month;
  RETURN ISNULL(@Output, 0);
END
GO

select dbo.ufGetSale(2005, 2007, 3);
drop function dbo.ufGetSale;

/* Question 2 */

CREATE TABLE DateRange
(DateID INT IDENTITY,
DateValue DATE,
Year INT,
Quarter INT,
Month INT,
DayOfWeek INT);

CREATE PROCEDURE dbo.uspDate
	@StartDate DATE,
	@NumDays INT
AS
	BEGIN
		DECLARE @counter INT;
		SET @counter = @NumDays
		WHILE @counter > 0 
			BEGIN 
				INSERT INTO DateRange (DateValue, Year, Quarter, Month, DayOfWeek)
				VALUES (@StartDate, DATEPART(Year,@startDate), DATEPART(QUARTER,@startDate),
				        DATEPART(MONTH,@startDate), DATEPART(WEEKDAY,@startDate));
				SET @StartDate = DATEADD(DAY,1,@StartDate);
				SET @counter = @counter - 1;
			END	
	END

DECLARE @InputDate Date = '2018-07-01';
DECLARE @IntputNumDays Int = 15;

EXEC uspDate @inputDate, @IntputNumDays;
SELECT * from DateRange;
DROP PROC dbo.uspDate;
DROP TABLE DateRange;

/* Question 3 */

-- Create a table-valued function
create function uf_GetCustomerName
(@CustID int)
returns @tbl table  (name varchar(200))
  begin
     declare @fullname varchar(200) = '' ;

     select @fullname = p.FirstName + ' ' + p.LastName
     from AdventureWorks2008R2.Sales.Customer c
     join AdventureWorks2008R2.Person.Person p
     on c.PersonID = p.BusinessEntityID
     where c.CustomerID = @custID;

     insert into @tbl values (@fullname);

     return;
  end

-- Test run the function
select * from dbo.uf_GetCustomerName(11000);

select s.CustomerID, n.name,
count(distinct s.SalesOrderID) OrderTotal,
count(distinct d.ProductID) UniqueProductTotal
from Sales.SalesOrderHeader s
join Sales.SalesOrderDetail d
on s.SalesOrderID = d.SalesOrderID
cross apply dbo.uf_GetCustomerName(s.CustomerID) n
group by s.CustomerID, n.name
order by s.CustomerID;

drop function dbo.uf_GetCustomerName

/* Question 4 */

CREATE TABLE Customer
(CustomerID INT PRIMARY KEY,
CustomerLName VARCHAR(30),
CustomerFName VARCHAR(30));

CREATE TABLE SaleOrder
(OrderID INT IDENTITY PRIMARY KEY,
CustomerID INT REFERENCES Customer(CustomerID),
OrderDate DATE,
LastModified datetime);

CREATE TABLE SaleOrderDetail
(OrderID INT REFERENCES SaleOrder(OrderID),
ProductID INT,
Quantity INT,
UnitPrice INT,
PRIMARY KEY (OrderID, ProductID));

CREATE TRIGGER dbo.utrLastModified
ON dbo.SaleOrderDetail 
AFTER INSERT, UPDATE, DELETE
AS  BEGIN
    DECLARE @oid INT;
	SET @oid = ISNULL((SELECT OrderID FROM Inserted), (SELECT OrderID FROM Deleted));
    UPDATE dbo.SaleOrder SET LastModified = GETDATE()
	WHERE OrderID = @oid
	END

