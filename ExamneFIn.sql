

DECLARE @EmployeeID INT,
        @FullName VARCHAR(100),
        @Phone VARCHAR(50),
        @OrderCount INT,
        @Message VARCHAR(100);

DECLARE empleado_cursor CURSOR FOR
SELECT EmployeeID, CONCAT(FirstName,' ',LastName), HomePhone
FROM Employees;

OPEN empleado_cursor;

FETCH NEXT FROM empleado_cursor INTO @EmployeeID, @FullName, @Phone;

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @OrderCount = COUNT(*)
    FROM Orders
    WHERE EmployeeID = @EmployeeID;

    IF @OrderCount = 1
        SET @Message = 'Aplicar estrategia.';
    ELSE IF @OrderCount > 1
        SET @Message = 'Diseñar estrategia.';
    ELSE
        SET @Message = 'Sin pedidos.';

    PRINT CAST(@EmployeeID AS VARCHAR) +SPACE (10)+
	                @FullName +SPACE(20-LEN(@FullName))+
					@Phone +SPACE(20-LEN(@Phone))+
		  CAST(@OrderCount AS VARCHAR) +SPACE (10-LEN(@OrderCount))+
					           @Message;

    FETCH NEXT FROM empleado_cursor INTO @EmployeeID, @FullName, @Phone;
END;

CLOSE empleado_cursor;
DEALLOCATE empleado_cursor;





----------------------------------------------------------
CREATE OR ALTER FUNCTION MI_FUNCTION (@ID INT) RETURNS TABLE
AS
RETURN(
   SELECT O.OrderID,
          C.CompanyName,
		  C.Country,
		  E.FirstName
   FROM Orders AS O
   INNER JOIN Customers AS C ON C.CustomerID=O.CustomerID 
   INNER JOIN Employees AS E ON E.EmployeeID=O.EmployeeID
   WHERE O.OrderID=@ID
   )
  go

SELECT*
FROM MI_FUNCTION(10249)
go



--------------------------------------------------------

CREATE OR ALTER PROC MI_PROCEDIMIENTO
  @RegionID INT ,
  @RegionDescription varchar(100)
AS
BEGIN
   if exists(select r.RegionID
      from Region as r
	  where r.RegionID=@RegionID)
   begin

     raiserror('Ocurrio un error el codigo ya existe',1,16)
	 return
   end
   INSERT INTO Region(RegionID,RegionDescription) VALUES(
   @RegionID,@RegionDescription)
END
go

EXEC MI_PROCEDIMIENTO 7,'Lima'
go



delete from Region
where RegionID in(5,6)

SELECT*FROM Region



-----------------------------------------

CREATE OR ALTER FUNCTION dbo.function_escalar(@nombre VARCHAR(30))
RETURNS VARCHAR(200)
AS
BEGIN
    DECLARE @resultado VARCHAR(200);

    SELECT TOP 1 @resultado = r.RegionDescription
    FROM Region AS r
    WHERE r.RegionDescription LIKE '%' + @nombre + '%';

    RETURN @resultado; 
END;
GO

-- Ejecutar la función
SELECT dbo.function_escalar('a') AS resultado;
GO


------------------------------------------------
create table categoria_auxiliar(
  CategoryID int,
  CategoryName varchar(30),
  Description varchar(100),
  Picture image
)

INSERT INTO categoria_auxiliar(CategoryID, CategoryName, Description, Picture)
VALUES 
(4, 'Beverages', 'Soft drinks, coffees, teas, beers, and ales', NULL);

select*from categoria_auxiliar
truncate table categoria_auxiliar
select*from Categories


CREATE OR ALTER TRIGGER mi_trigger 
ON categoria_auxiliar
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 

    IF EXISTS (
        SELECT 1
        FROM inserted AS i
        INNER JOIN Categories AS ca ON i.CategoryID = ca.CategoryID
    )
    BEGIN
        RAISERROR('La inserción no es posible ya que existe en la tabla Categories.', 1, 16);
        ROLLBACK TRANSACTION; 
        RETURN; 
    END

    INSERT INTO Categories (CategoryID, CategoryName, Description)
    SELECT CategoryID, CategoryName, Description
    FROM inserted;
END;
GO





