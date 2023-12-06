--1.	List the customers from California who bought red mountain bikes in September 2003. Use order date as date bought.--
SELECT C.CustomerID, C.LastName, C.FirstName, B.ModelType, P.Colorlist, B.OrderDate, B.SaleState
FROM Customer C JOIN Bicycle B ON C.CustomerID = B.CustomerID
	JOIN Paint P ON P.PaintID = B.PaintID
WHERE B.OrderDate BETWEEN '2003-10-1' AND '2003-10-30'
	AND P.ColorList = 'RED'
	AND B.ModelType LIKE '%Mountain%'

--2.	List all of the (distinct) rear derailleurs installed on road bikes sold in Florida in 2002.--
SELECT Distinct(C.ComponentID), M.ManufacturerName, C.ProductNumber
FROM Component C LEFT JOIN Manufacturer M ON M.ManufacturerID = C.ManufacturerID
	  INNER JOIN BikeParts BP ON C.ComponentID = BP.ComponentID
		 JOIN Employee E ON BP.EmployeeID = E.EmployeeID
			JOIN Bicycle B ON E.EmployeeID = B.EmployeeID
WHERE C.Category LIKE '%Rear derailleur%'
	AND C.Road LIKE '%Road%'
	AND B.SaleState LIKE '%FL%'
	AND B.OrderDate LIKE '%2002%'

--3.	Who bought the largest (frame size) full suspension mountain bike sold in Georgia in 2004?--
SELECT C.CustomerID, C.LastName, C.FirstName, ModelType,SaleState,FrameSize, OrderDate
FROM Customer C JOIN Bicycle B ON C.CustomerID = B.CustomerID
WHERE B.SaleState LIKE '%GA%'
	AND B.ModelType LIKE '%Mountain Full'
	AND B.OrderDate LIKE '%2004%'
ORDER BY B.FrameSize DESC



--4.	Which manufacturer gave us the largest discount on an order in 2003?--
SELECT TOP 1 M.ManufacturerID, ManufacturerName
FROM Manufacturer M JOIN PurchaseOrder P ON M.ManufacturerID = P.ManufacturerID
WHERE P.OrderDate LIKE '%2003%'
ORDER BY P.Discount/P.TotalList DESC

--5.	What is the most expensive road bike component we stock that has a quantity on hand greater than 200 units? --
SELECT TOP 1 ComponentID, ManufacturerName, ProductNumber,Road,Category,ListPrice,QuantityOnHand
FROM Component C JOIN Manufacturer M ON C.ManufacturerID = M.ManufacturerID
WHERE QuantityOnHand > 200
	AND Road LIKE '%Road%'
ORDER BY EstimatedCost DESC

--6.	Which inventory item represents the most money sitting on the shelf—based on estimated cost?--
SELECT ComponentID, ManufacturerName, ProductNumber, Category, Year, (EstimatedCost*QuantityOnHand) AS 'VALUE'
FROM Component C JOIN Manufacturer M ON C.ManufacturerID = M. ManufacturerID
ORDER BY VALUE DESC

--7.	What is the greatest number of components ever installed in one day by one employee?--
SELECT E.EmployeeID, LastName, DateInstalled, COUNT(ComponentID) AS 'CountOfComponentID'
FROM Employee E JOIN BikeParts B ON E.EmployeeID = B.EmployeeID
	WHERE DateInstalled IS NOT NULL
GROUP BY E.EmployeeID, LastName, DateInstalled
ORDER BY CountOfComponentID DESC



--8.	What was the most popular letter style on race bikes in 2003?--
SELECT LetterStyleID, COUNT(SerialNumber) AS CountOfSerialNumber
FROM Bicycle
WHERE ModelType LIKE '%Race%'
	AND OrderDate LIKE '%2003%'
GROUP BY LetterStyleID
ORDER BY CountOfSerialNumber DESC


--9.	Which California bike shop helped sell the most bikes (by value) in 2003?--
SELECT B.StoreID,StoreName,City, SUM(SalePrice) as SumOfSalePrice
FROM Bicycle B JOIN RetailStore RS ON B.StoreID = RS.StoreID
	JOIN City C ON RS.CityID = C.CityID
WHERE SaleState LIKE '%CA%'
	AND OrderDate LIKE '%2003%'
GROUP BY B.StoreID, StoreName, City
ORDER BY SumOfSalePrice DESC

--10.	What is the total weight of the components on bicycle 11356?--
SELECT SUM(Quantity * Weight) AS TotalWeight
FROM Component C JOIN BikeParts BP ON C.ComponentID = BP.ComponentID
WHERE SerialNumber = 11356



--11.	What is the total list price of all items in the 2002 Campy Record groupo?--
SELECT GroupName, SUM(ListPrice*QuantityOnHand) As SumOfListPrice
FROM Component C JOIN GroupComponents GC ON C.ComponentID = GC.ComponentID
	 JOIN Groupo G ON GC.GroupID = G.ComponentGroupID
WHERE GroupName LIKE '%Campy Record 2002%'
GROUP BY GroupName

--12.	What is the average price paid for the 2001 Shimano XTR rear derailleurs?--
SELECT AVG(PricePaid) AS AvgOfPricePaid
FROM Component C JOIN PurchaseItem P ON C.ComponentID = P.ComponentID
	JOIN Manufacturer M ON C.ManufacturerID = M.ManufacturerID
WHERE Category LIKE '%Rear derailleur%'
	AND ProductNumber Like '%XTR%'
	AND ManufacturerName LIKE '%Shimano%'
	AND Year LIKE '%2001%'



--13.	What is the average top tube length for a 54 cm (frame size) road bike built in 1999?--
SELECT AVG(TopTube) As AverageOfTopTube
FROM Bicycle B JOIN Employee E ON B.EmployeeID = E.EmployeeID
	JOIN BikeParts BP ON E.EmployeeID = BP.EmployeeID
WHERE B.FrameSize = 54
 AND BP.DateInstalled LIKE '%1999%'
 AND B.ModelType LIKE '%Road%'



--14.	On average, which costs (list price) more: road tires or mountain bike tires?--
SELECT Road, AVG(ListPrice) AS AvgOfListPrice FROM Component
WHERE category LIKE '%Tire%'
GROUP BY Road
ORDER BY AvgOfListPrice DESC

--15.	In May 2003, which employees sold road bikes that they also painted?--
SELECT E.EmployeeID, E.LastName
FROM CustomerTransaction CT JOIN Bicycle B ON CT.CustomerID=B.CustomerID
	JOIN Employee E ON B.EmployeeID = E.EmployeeID
WHERE  E.EmployeeID = Painter
	AND OrderDate BETWEEN '2003-05-1' AND '2003-05-31'
	AND ModelType LIKE '%Road%'
GROUP BY E.EmployeeID, LastName


--16.	In 2002, was the Old English letter style more popular with some paint jobs?--
SELECT B.PaintID, ColorName, Count(SerialNumber) AS NumberOfBikesPainted
FROM Bicycle B JOIN Paint P ON B.PaintID = P.PaintID
WHERE B.LetterStyleID LIKE '%English%'
	AND OrderDate LIKE '%2002%'
GROUP BY B.PaintID, ColorName
ORDER BY NumberOfBikesPainted DESC




--17.	Which race bikes in 2003 sold for more than the average price of race bikes in 2002?--
SELECT SerialNumber,ModelType,OrderDate,SalePrice FROM Bicycle
WHERE ModelType = 'Race'
	AND OrderDate LIKE '%2003%'
	AND SalePrice > (SELECT AVG(SalePrice) FROM Bicycle WHERE ModelType = 'race' AND OrderDate LIKE '%2002%')

--18.	Which component that had no sales (installations) in 2004 has the highest inventory value (cost basis)?--
SELECT M.ManufacturerName,C.ProductNumber,C.Category,(QuantityOnHand * EstimatedCost) AS 'InventoryValue'	,C.ComponentID
FROM Component C JOIN Manufacturer M ON C.ManufacturerID = M.ManufacturerID
	JOIN BikeParts BP ON C.ComponentID = BP.ComponentID
WHERE DateInstalled NOT LIKE '%2004%'
GROUP BY ManufacturerName,ProductNumber,Category, C.ComponentID, QuantityOnHand, EstimatedCost
ORDER BY InventoryValue DESC

--19.	Create a vendor contacts list of all manufacturers and retail stores in California.Include only the columns for VendorName and Phone. The retail stores should only include stores that participated in the sale of at least one bicycle in 2004--
 SELECT DISTINCT RS.StoreName, RS.Phone
 FROM RetailStore RS JOIN Bicycle B ON RS.StoreID = B.StoreID 
 WHERE OrderDate LIKE '%2004%'
	AND SaleState LIKE '%CA%'
	AND RS.Phone IS NOT NULL
UNION
SELECT DISTINCT M.ManufacturerName, M.Phone
FROM Manufacturer M JOIN City C ON C.CityID = M.CityID
WHERE M.Phone IS NOT NULL

--20.	List all of the employees who report to Venetiaan.--

SELECT B.LastName, A.EmployeeID, A.LastName, A.FirstName, A.Title
FROM Employee A, Employee B
WHERE B.EmployeeID = A.CurrentManager
	AND B.LastName LIKE '%Venetiaan%'

