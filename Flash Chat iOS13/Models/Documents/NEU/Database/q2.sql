
-- Q1
USE AdventureWorks2008R2;
SELECT TerritoryID, CAST(OrderDate AS DATE) [Order Date], SUM(sd.OrderQty) AS [Order Count]
FROM Sales.SalesOrderHeader sh
JOIN Sales.SalesOrderDetail sd
ON sh.SalesOrderID = sd.SalesOrderID
WHERE OrderDate BETWEEN '1-1-2008' AND '1-5-2008'
GROUP BY TerritoryID, OrderDate
ORDER BY TerritoryID, OrderDate;

SELECT TerritoryID, isNull([2008-01-01],0), isNull([2008-01-02],0), isNull([2008-01-03],0),isNull([2008-01-04],0), isNull([2008-01-05],0)
FROM 
(SELECT TerritoryID, CAST(OrderDate AS DATE) [Order Date], SUM(sd.OrderQty) AS [Order Count]
FROM AdventureWorks2008R2.Sales.SalesOrderHeader sh
JOIN Sales.SalesOrderDetail sd 
ON sh.SalesOrderID = sd.SalesOrderID
WHERE OrderDate BETWEEN '2008-01-01' AND '2008-01-05'
GROUP BY TerritoryID, OrderDate
) Src
PIVOT(
SUM([Order Count])
FOR [Order Date] IN(
[2008-01-01], [2008-01-02], [2008-01-03],[2008-01-04], [2008-01-05]
)
)AS PivotTable;


--Q2
USE AdventureWorks2008R2;
/* Write a query to retrieve the top 3 customers, based on the total purchase,
   for each month of 2007. Use TotalDue of SalesOrderHeader to calculate the total purchase.
   The top 3 customers have the 3 highest total purchase amounts.
   Also calculate the top three customer's total purchase as a percentage of the total
   territory sale for the month. Return the data in the following format.

Month	% of Total Sale		Total Territory Sale	Top3Customers
1			14.12				1968647				29594, 29772, 29827
2			8.71				3226056				30074, 29924, 29716
3			12.57				2297693				29715, 29639, 29701
4			12.02				2660724				29646, 29594, 29827
5			8.91				3866365				29616, 30112, 30074
6			11.69				2852210				29701, 29715, 29639
7			10.58				3998943				29641, 29987, 30048
8			7.21				5712201				29913, 29940, 29617
9			6.48				5702088				30050, 30046, 29701
10			10.26				3767722				29641, 29693, 30048
11			7.39				5250314				29923, 29913, 29818
12			5.04				5868526				29629, 29796, 29770

*/

SELECT distinct (TerritoryID),
       STUFF(
	   (SELECT TOP 3 WITH TIES ', ' + CAST(a.CustomerID AS CHAR(5))
	    FROM Sales.SalesOrderHeader a
		WHERE a.TERRITORYID = b.TERRITORYID
	    GROUP BY TERRITORYID, CustomerID
		ORDER BY  COUNT(SalesOrderID) DESC --a.totaldue desc
		FOR XML PATH('')
	   ), 1, 2, '') OrderCount
FROM Sales.SalesOrderHeader b
ORDER BY TERRITORYID;




-Q3
USE ZHAO_KAIYUAN_TEST;



/* Given the following tables, there is a business rule
   preventing a user from checking out a book if there is
   an unpaid fine. Please write a table-level constraint
   to implement the business rule. */
create table Book
(InventoryID int primary key,
 ISBN varchar (20),
 Title varchar(50),
 AuthorID int,
 CategoryID int);

create table Customer
(CustomerID int primary key,
 LastName varchar (50),
 FirstName varchar (50),
 PhoneNumber varchar (20));

create table CheckOut
(InventoryID int references Book(InventoryID),
 CustomerID int references Customer(CustomerID),
 CheckOutDate date,
 ReturnDate date
 primary key (InventoryID, CustomerID, CheckOutDate));

create table Fine
(CustomerID int references Customer(CustomerID),
 IssueDate date,
 Amount money,
 PaidDate date
 primary key (CustomerID, IssueDate));

CREATE FUNCTION CheckFine(@CID INT)
RETURN VARCHAR(5)
AS BEGIN
		DECLARE @CurrentDate DATE = SELECT CAST(GETDATE() AS DATE)
		IF EXISTS(
		SELECT ReturnDate FROM CheckOut WHERE CustomerID = @CID
		HAVING ReturnDate < @CurrentDate
		)
		RETURN 'TRUE'
		RETURN 'FALSE'
	END
GO
ALTER TABLE Customer ADD CONSTRAINT badCheck CHECK(CheckFine(Customer.CustomerID= 'FALSE')



--q4
/* A company loans money to employees for emergency. There is a
   business rule that no employee can borrow more than $10,000 
   per year. Any attempt to borrow more than $10,000 by an employee
   in a year must be logged in an audit table and the violating
   loan is not allowed.

   Given the following 3 tables, please write a trigger to implement
   the business rule. The rule must be enforced every year.
   Assume only one loan is entered in the database at a time.
   You can just consider the INSERT scenarios.
*/
create table Employee
(EmployeeID int primary key,
 EmpLastName varchar(50),
 EmpFirstName varchar(50),
 DepartmentID smallint);

create table Loan
(LoanID int identity primary key,
 LoanAmount int,
 LoanDate date NOT NULL,
 EmployeeID int NOT NULL);

create table LoanAudit  -- Audit Table
(AuditID int identity primary key,
 EnteredBy varchar(50) default original_login(),
 EnterTime datetime default getdate(),
 EnteredAmount int not null);


CREATE TRIGGER borrowNoMore
ON LoanAudit
AFTER INSERT
AS 
BEGIN
   DECLARE @Count INT=0;
   SELECT @Count = COUNT(LoanID) 
      FROM Loan
      WHERE LoanID = (SELECT LoanID FROM Inserted)
      AND LoanAmount > 10000
     (SELECT LoadDate FROM Load) AS LDATE;
   IF @Count > 0 AND DAYPART(LDATE) < 365
      BEGIN
      Rollback;
      END
END;


