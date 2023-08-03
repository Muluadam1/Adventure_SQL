/*From the following table write a query in SQL to calculate the sum of the ListPrice and 
StandardCost for each color. Return color, sum of ListPrice and sum of StandardCost.
Sample table: production.Product*/

SELECT color, SUM(ListPrice) AS TotalListPrice, SUM(StandardCost) AS TotalStandardCost
FROM production.Product
GROUP BY color;

/*From the following table write a query in SQL to find the TotalSalesYTD of each SalesQuota. 
Show the summary of the TotalSalesYTD amounts for all SalesQuota groups. Return SalesQuota and TotalSalesYTD.
Sample table: Sales.SalesPerson*/

SELECT SalesQuota, SUM(SalesYTD) AS TotalSalesYTD
FROM Sales.SalesPerson
where SalesQuota is not null
GROUP BY SalesQuota;

SELECT SalesQuota, SUM(SalesYTD) as "TotalSalesYTD" 
FROM Sales.SalesPerson 
where SalesQuota is not null
GROUP BY SalesQuota;

/* From the following table write a query in SQL to return the total ListPrice and StandardCost of
products for each color. Products that name starts with 'Mountain' and ListPrice is more than zero.
Return Color, total list price, total standardcode. Sort the result set on color in ascending order.

Sample table: production.Product*/

select color, sum(ListPrice) as TotalPrice, sum(StandardCost) as TotalStandardCost
from production.product
where color is not null and name like 'Mountain%' and ListPrice > 0
group by color
order by color 

SELECT Color, SUM(ListPrice), SUM(StandardCost)  
FROM Production.Product  
WHERE Color IS NOT NULL   
    AND ListPrice != 0.00   
    AND Name LIKE 'Mountain%'  
GROUP BY Color  
ORDER BY Color;

/*From the following table write a query in SQL to populate the variance of all unique values as well as all values, 
including any duplicates values of SalesQuota column.

Sample table: sales.salespersonquotahistory*/

SELECT 
    VARP(SalesQuota) AS Distinct_Values,
    VAR(SalesQuota) AS All_Values  
FROM sales.salespersonquotahistory;
--Note
/*In this query, we are using 'VARP' function to calculate the population variance (variance of all unique values) 
of the SalesQuota column, and 'VAR' function to calculate the sample variance (variance of all values, including duplicates)
in the SalesQuota column.Remember, SQL Server's 'VAR' function calculates the sample variance, 
whereas 'VARP' calculates the population variance, so choose the one that suits your specific needs.*/

/* From the following table write a query in SQL to find the number of products that ordered
in each of the specified sales orders.

Sample table: Sales.SalesOrderDetail*/

SELECT SalesOrderID, COUNT(*) AS NumberOfProductsOrdered
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID;

SELECT DISTINCT COUNT(Productid) OVER(PARTITION BY SalesOrderid) AS ProductCount  
    ,SalesOrderid  
FROM sales.salesorderdetail  
WHERE SalesOrderid IN (45363,45365);

/*From the following tables write a SQL query to return the departments of a company that each have more than 15 employees.

Sample table: humanresources.employee*/


SELECT jobtitle,   
       COUNT(businessentityid) AS EmployeesInDesig  
FROM humanresources.employee e  
GROUP BY jobtitle  
HAVING COUNT(businessentityid) > 15;

SELECT jobtitle, EmployeesInDesig
FROM (
    SELECT jobtitle, COUNT(businessentityid) AS EmployeesInDesig
    FROM humanresources.employee
    GROUP BY jobtitle
) AS subquery
WHERE EmployeesInDesig > 15;

/* From the following tables wirte a query in SQL to return aggregated values for each department. 
Return name, minimum salary, maximum salary, average salary, and number of employees in each department.

Sample table: HumanResources.employeepayhistory*/
	SELECT DISTINCT Name  
       , MIN(Rate) OVER (PARTITION BY edh.DepartmentID) AS MinSalary  
       , MAX(Rate) OVER (PARTITION BY edh.DepartmentID) AS MaxSalary  
       , AVG(Rate) OVER (PARTITION BY edh.DepartmentID) AS AvgSalary  
       ,COUNT(edh.BusinessEntityID) OVER (PARTITION BY edh.DepartmentID) AS EmployeesPerDept  
FROM HumanResources.EmployeePayHistory AS eph  
JOIN HumanResources.EmployeeDepartmentHistory AS edh  
     ON eph.BusinessEntityID = edh.BusinessEntityID  
JOIN HumanResources.Department AS d  
ON d.DepartmentID = edh.DepartmentID
WHERE edh.EndDate IS NULL  
ORDER BY Name;

/*From the following table write a query in SQL to find the average bonus for the salespersons 
who achieved the sales quota above 25000. Return number of salespersons, and average bonus.

Sample table: Sales.SalesPerson*/

SELECT
    COUNT(*) AS NumberOfSalespersons,
    AVG(Bonus) AS AverageBonus
FROM
    Sales.SalesPerson
WHERE
    SalesQuota > 25000;

/*From the following table write a query in SQL to find the total number of employees.

Sample table: HumanResources.Employee*/

select distinct count (BusinessEntityID) as TotalEmploy from HumanResources.Employee;

select distinct count(*) as TotalEmployee from HumanResources.Employee;

/*From the following table write a query in SQL to return the number of different titles that employees can hold.

Sample table: HumanResources.Employee*/

select count(distinct JobTitle) as DifferentTitles from HumanResources.Employee

/*From the following table write a query in SQL to return a moving average of sales, by year, for all sales territories. 
Return BusinessEntityID, TerritoryID, SalesYear, SalesYTD, average SalesYTD as MovingAvg, and total SalesYTD as CumulativeTotal.

Sample table: Sales.SalesPerson*/

;

SELECT BusinessEntityID, TerritoryID
   , YEAR(ModifiedDate) AS SalesYear
   , CAST(SalesYTD AS VARCHAR(20)) AS  SalesYTD
   , AVG(SalesYTD) OVER (ORDER BY YEAR(ModifiedDate)) AS MovingAvg
   , SUM(SalesYTD) OVER (ORDER BY YEAR(ModifiedDate)) AS CumulativeTotal
FROM Sales.SalesPerson
WHERE TerritoryID IS NULL OR TerritoryID < 5
ORDER BY SalesYear;


