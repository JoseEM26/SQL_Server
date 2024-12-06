-------------------PREGUNTA1.A-------------------------------------
INSERT INTO Products (ProductName,UnitPrice,UnitsInStock,Discontinued)
VALUES
('PRODUCTO1',32.2,100,1),
('PRODUCTO2',33.1,101,0)

--EN ESTA PARTE NO LE PUSE EL PRODUCTOID YA QUE ES IDENTITY 
--Y SE CREA POR SI SOLO
SELECT*FROM Products
-------------------PREGUNTA1.B-------------------------------------
INSERT INTO Shippers(CompanyName,Phone)VALUES
('COMERCIAÑ ROSITA SRL.','(001) 451-5641'),
('LA CASITA DE LOS DULCES EIRL.','(001) 358.7414'),
('LA BITECA S.A.','(001) 551-63254'),
('RESTAURANTE EL BUEN SABOR.','(001) 451-1167'),
('RESTOBAR NAUTICAS S.A.','(001) 362-8541')
--EN ESTA PARTE TMBN TIENE LO QUE ES IDENTITY Y NO ES NECESARIO INSERTARLO.
SELECT*FROM Shippers

-------------------PREGUNTA1.C-------------------------------------
CREATE TABLE #TEMPORAL (
   ShipperID INT PRIMARY KEY IDENTITY,
   CompanyName NVARCHAR(80),
   Phone NVARCHAR(48)
)
--EN ESTA PARTE TMBN TIENE LO QUE ES IDENTITY Y NO ES NECESARIO INSERTARLO.
INSERT INTO #TEMPORAL(CompanyName,Phone)VALUES
('COMERCIAÑ ROSITA SRL.','(001) 451-5641'),
('LA CASITA DE LOS DULCES EIRL.','(001) 358.7414'),
('LA BITECA S.A.','(001) 551-63254'),
('RESTAURANTE EL BUEN SABOR.','(001) 451-1167'),
('RESTOBAR NAUTICAS S.A.','(001) 362-8541')

SELECT*FROM #TEMPORAL

-------------------PREGUNTA1.D-------------------------------------
INSERT INTO Orders (
                    CustomerID,
                    EmployeeID,
                    OrderDate,
                    RequiredDate,
                    ShippedDate,
                    ShipVia,
                    Freight,
                    ShipName,
                    ShipAddress,
                    ShipCity,
                    ShipRegion,
                    ShipPostalCode,
                    ShipCountry)
VALUES 
    ( 'ALFKI', 1, '2024-10-01', '2024-10-08', '2024-10-05', 1, 10.50, 'Alfreds Futterkiste', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany'),
    ( 'ANATR', 2, '2024-10-02', '2024-10-09', '2024-10-06', 2, 20.75, 'Ana Trujillo Emparedados y Frios', 'Av. de la Constitución 222', 'México D.F.', NULL, '05021', 'Mexico'),
    ( 'ANTON', 3, '2024-10-03', '2024-10-10', '2024-10-07', 1, 15.00, 'Antonio Moreno Taquería', 'Mataderos 231', 'México D.F.', NULL, '05023', 'Mexico');
--EN ESTA PARTE TMBN TIENE LO QUE ES IDENTITY Y NO ES NECESARIO INSERTARLO.

   SELECT*FROM Orders

-------------------PREGUNTA2-A-------------------------------------
UPDATE Customers 
SET Address='AV.URUAGUAY NRO.514',
    City='LIMA',
    Country='PERU',
	Phone='(051)2121214'
WHERE CustomerID='CACTU'



SELECT*FROM Customers
WHERE CustomerID='CACTU'

-------------------PREGUNTA2-B-------------------------------------

UPDATE Products
       SET UnitPrice=UnitPrice*1.25
	   WHERE ProductID=5

SELECT*FROM Products
WHERE ProductID=5

-------------------PREGUNTA2-C-------------------------------------

UPDATE Products  
       SET UnitsInStock =UnitsInStock*1.50
	   WHERE UnitPrice BETWEEN 25 AND 50

SELECT*FROM Products
WHERE UnitPrice BETWEEN 25 AND 50

-------------------PREGUNTA3-------------------------------------

CREATE TABLE PRODUCTO_TEST (
    ProductoID INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(255),
    UnidadesEnExistencia INT
);

INSERT INTO PRODUCTO_TEST (Nombre, UnidadesEnExistencia) VALUES
( 'Producto A', 10),
( 'Producto B', 0),
( 'Producto C', 15),
( 'Producto D', 2),
( 'Producto E', 3),
( 'Producto F', 6),
( 'Producto G', 9)


DECLARE @CODIGO INT =2
DECLARE @NOMBRE NVARCHAR(255) = 'Producto B Modificado';

MERGE INTO PRODUCTO_TEST AS TARGET
USING (SELECT @CODIGO AS ProductoID ,@NOMBRE AS Nombre) AS SOURCE 
ON(TARGET.ProductoID = SOURCE.ProductoID)
WHEN MATCHED AND TARGET.UnidadesEnExistencia<=0 THEN
    DELETE
WHEN MATCHED THEN
    UPDATE SET TARGET.Nombre=@NOMBRE;

SELECT*FROM PRODUCTO_TEST

-------------------PREGUNTA4-------------------------------------

SELECT C.Country,
       C.Address,
       C.City,
       P.CustomerID,
       E.EmployeeID,
       COUNT(E.EmployeeID) AS [CANTIDAD_EMPLOYEED_ID],
	   DATEPART(YEAR,E.BirthDate)AS BIRTDAY
FROM Orders AS P
INNER JOIN Customers AS C ON P.CustomerID = C.CustomerID
INNER JOIN Employees AS E ON E.EmployeeID = P.EmployeeID
WHERE DATEPART(YEAR,E.BirthDate) BETWEEN 1940 AND 1950
GROUP BY C.Country, C.Address, C.City, P.CustomerID, E.EmployeeID,E.BirthDate
HAVING COUNT(E.EmployeeID)>2 AND COUNT(E.EmployeeID)<6
ORDER BY C.City DESC;


SELECT*FROM Employees
SELECT*FROM Customers
SELECT*FROM Orders