USE MASTER
--COMO CREAR UNA BASE DE DATOS CORRECTAMENTE
IF DB_ID('PRUEBA')IS NOT NULL
DROP DATABASE PRUEBA
GO

CREATE DATABASE PRUEBA
go

USE PRUEBA
go

--CRACION DE UNA TABLA
CREATE TABLE TABLA1(
   CODIGO CHAR(2),
   NOMBRE VARCHAR(10),
   APELLIDO VARCHAR(10)


);
INSERT INTO TABLA1 VALUES (11,'JOSE','ESPINOZA');
INSERT INTO TABLA1 VALUES (12,'JOSE','ESPINOZA');
INSERT INTO TABLA1 VALUES (13,'JOSE','ESPINOZA');
INSERT INTO TABLA1 VALUES (15,'JOSE','ESPINOZA');
INSERT INTO TABLA1 VALUES (16,'JOSE','ESPINOZA');
INSERT INTO TABLA1 VALUES (17,'JOSE','ESPINOZA');
INSERT INTO TABLA1 VALUES (18,'JOSE','ESPINOZA');
INSERT INTO TABLA1 VALUES (19,'JOSE','ESPINOZA');
INSERT INTO TABLA1 VALUES (20,'JOSE','ESPINOZA');
INSERT INTO TABLA1 VALUES (22,'JOSE','ESPINOZA');
INSERT INTO TABLA1 VALUES (23,'JOSE','ESPINOZA');
INSERT INTO TABLA1 VALUES (24,'JOSE','ESPINOZA');
INSERT INTO TABLA1 VALUES (25,'JOSE','ESPINOZA');
INSERT INTO TABLA1 VALUES (26,'JOSE','ESPINOZA');
INSERT INTO TABLA1 VALUES (27,'JOSE','ESPINOZA');
INSERT INTO TABLA1 VALUES (28,'JOSE','ESPINOZA');
INSERT INTO TABLA1 VALUES (29,'JOSE','ESPINOZA');

--CONSULTA A LA TABLA SEGU LA UBICACION
SELECT *FROM TABLA1
	SELECT * 
	FROM TABLA1 
	WHERE CODIGO=11;

--ELIMINAR UNA FILA DE LA TABLA
DELETE FROM TABLA1 
WHERE CODIGO=11;

--actualizar lo que es un espacio especifico de una fila de la tabla
UPDATE TABLA1 SET NOMBRE='LIRA ' WHERE CODIGO=12

--CREAR UNA TABLA NUEVA
CREATE TABLE DATOS(
NOMBRE VARCHAR(30),
APELLIDO VARCHAR(30))

--INSERTAR DATOS DE OTRA TABLA A OTRA
INSERT INTO DATOS (NOMBRE,APELLIDO)
SELECT NOMBRE,APELLIDO FROM TABLA1;

SELECT*FROM DATOS

--aCTUALIZAR UN DATO ESPECIFICO
UPDATE DATOS SET NOMBRE='MIGUEL' WHERE NOMBRE='JOSE'

--top and percent  consulta de la tabla1----------------------------------------------------------------------------------------------------
SELECT TOP 5 * FROM TABLA1
where CODIGO>15

select top 50 percent * from TABLA1


--primary key with constraint ,in his name like pk_enlace_idPersona
create table Persona(
 id char(2)not null,
 nombre varchar(30),
 apellido varchar(30)not null
 );

 --drop table Persona
-- constraint PK_enlace_idPersona primary key (id)

  alter table Persona add constraint uq_nombrePersona unique (nombre)
  alter table TABLA1  add check (CODIGO>0)
  alter table persona  add default 'no hay dato' for NOMBRE
  select *from TABLA1


  insert into TABLA1 values(01,'nombre','apellido')
  insert into TABLA1 values(02,'jose','apellido')
  insert into TABLA1 values(02,'jose',default)
  insert into persona values(02,default,'espinoza')

  select* from persona

 --add a constraint primary key into table Persona with name pl_enlace_idPersona .
 alter table persona add constraint pk_enlace_idPersona primary key (id)



 create table libros(
    idLibro int (1000,2),
	nombre varchar(10)not null,
	apellido varchar(10)not null);

	insert into libros values ('padre rico','librito')
	insert into libros values ('padre rico','librito')
	insert into libros values ('padre rico','librito')
	insert into libros values ('padre rico','librito')
	insert into libros values ('padre rico','librito')
	insert into libros values ('padre rico','librito')
	insert into libros values ('padre rico','librito')
	insert into libros values ('padre rico','librito')
	insert into libros values ('padre rico','librito')
	insert into libros values ('padre rico','librito')
	insert into libros values ('padre rico','librito')
	insert into libros values ('padre rico','librito')
	insert into libros values ('padre rico','librito')
	insert into libros values ('padre rico','librito')
	insert into libros values ('padre rico','librito')
	insert into libros values ('padre rico','librito')
	select*from libros

	--delete a row of the table libro in the column idLibro
    delete from libros where idLibro=2
	drop table libros

	--crear la tabla clientes
CREATE TABLE clientes (
    id INT,
    nombre VARCHAR(30),
    apellido VARCHAR(30),
    direccion VARCHAR(50),
    edad INT,
    telefono VARCHAR(20),
    fecha_nacimiento DATE
);
select*from clientes

--insertar estos registros en la tabla clientes
    insert into clientes values(1, 'Juan', 'Perez', 'Calle 123', 25, '555-1234', '2000-01-01');
    insert into clientes values(2, 'Maria', 'Lopez', 'Avenida 456', 30, '555-5678', '1995-05-10');
    insert into clientes values(3, 'Carlos', 'Gomez', 'Carrera 789', 40, '555-9012', '1983-12-15');
    insert into clientes values(4, 'Ana', 'Rodriguez', 'Plaza 789', 32, '555-4321', '1989-08-20');
    insert into clientes values(5, 'Pedro', 'Martinez', 'Avenida 987', 45, '555-6789', '1978-03-05');
    insert into clientes values(6, 'Laura', 'Sanchez', 'Calle 456', 27, '555-0987', '1996-11-12');
    insert into clientes values(7, 'Luis', 'Hernandez', 'Calle 654', 38, '555-3456', '1984-07-25');
    insert into clientes values(8, 'Carolina', 'Torres', 'Avenida 321', 29, '555-8765', '1992-09-03');
    insert into clientes values(9, 'Diego', 'Gonzalez', 'Carrera 246', 42, '555-6543', '1979-06-18');
    insert into clientes values(10, 'Sofia', 'Rojas', 'Plaza 135', 31, '555-2109', '1990-04-14');
    insert into clientes values(11, 'Andres', 'Fernandez', 'Calle 789', 37, '555-1092', '1985-02-28');
    insert into clientes values(12, 'Valentina', 'Morales', 'Calle 246', 26, '555-5432', '1997-10-23');
    insert into clientes values(13, 'Roberto', 'Gutierrez', 'Avenida 753', 43, '555-4321', '1978-12-09');
    insert into clientes values(14, 'Daniela', 'Navarro', 'Plaza 159', 33, '555-6789', '1988-06-14');
    insert into clientes values(15, 'Jorge', 'Paz', 'Carrera 357', 44, '555-0987', '1977-01-30');
    insert into clientes values(16, 'Catalina', 'Silva', 'Calle 852', 28, '555-3456', '1995-11-05');
    insert into clientes values(17, 'Gonzalo', 'Luna', 'Avenida 951', 39, '555-8765', '1982-08-12');
    insert into clientes values(18, 'Camila', 'Vargas', 'Carrera 753', 30, '555-6543', '1993-03-28');
    insert into clientes values(19, 'Felipe', 'Cortes', 'Calle 357', 35, '555-2109', '1986-09-13');
    insert into clientes values(20, 'Marcela', 'Ortega', 'Plaza 852', 37, '555-1092', '1985-02-28');





	create view EdadMayor30
	as 
	select id,nombre,apellido
	from clientes
	where edad>30

	select*from EdadMayor30

	drop table clientes
	CREATE TABLE clientes (
  id_cliente INT NOT NULL PRIMARY KEY,
  nombre VARCHAR(20) NOT NULL,
  apellido VARCHAR(20) NOT NULL,
  pais VARCHAR(50) NOT NULL,
  compras INT NULL
);
  
  insert into Clientes values(1, 'Juan', 'Pérez', 'Estados Unidos', 1);
  insert into Clientes values(2, 'María', 'Gómez', 'Argentina', 2);
  insert into Clientes values(3, 'Carlos', 'López', 'Brasil', NULL);
  insert into Clientes values(4, 'Laura', 'Martínez', 'Canadá', 4);
  insert into Clientes values(5, 'Pedro', 'Hernández', 'China', 5);
  insert into Clientes values(6, 'Ana', 'Ruiz', 'Colombia', NULL);
  insert into Clientes values(7, 'Luis', 'Torres', 'Egipto', 7);
  insert into Clientes values(8, 'Marta', 'Sánchez', 'España', 8);
  insert into Clientes values(9, 'Roberto', 'García', 'Francia', 9);
  insert into Clientes values(10, 'Sofía', 'López', 'Alemania', 10);
  insert into Clientes values(11, 'David', 'Hernández', 'Argentina', NULL);
  insert into Clientes values(12, 'Andrea', 'Gómez', 'Brasil', 12);
  insert into Clientes values(13, 'Fernando', 'Pérez', 'Canadá', 13);
  insert into Clientes values(14, 'Patricia', 'Martínez', 'China', 14);
  insert into Clientes values(15, 'Javier', 'López', 'Colombia', 15);
  insert into Clientes values(16, 'Carmen', 'Ruiz', 'Egipto', NULL);
  insert into Clientes values(17, 'Ricardo', 'Torres', 'España', 17);
  insert into Clientes values(18, 'Marina', 'Sánchez', 'Francia', 18);
  insert into Clientes values(19, 'Alejandro', 'García', 'Alemania', 19);
  insert into Clientes values(20, 'Claudia', 'López', 'Argentina', 20);
  insert into Clientes values(21, 'Fernanda', 'Gómez', 'Brasil', 21);
  insert into Clientes values(22, 'Rodrigo', 'Pérez', 'Canadá', 22);
  insert into Clientes values(23, 'Luisa', 'Martínez', 'China', 23);
  insert into Clientes values(24, 'Emilio', 'Hernández', 'Colombia', 24);
  insert into Clientes values(25, 'Valeria', 'Ruiz', 'Egipto', 25);
  insert into Clientes values(26, 'Rafael', 'Torres', 'España', 26);
  insert into Clientes values(27, 'Camila', 'Sánchez', 'Francia', 27);
  insert into Clientes values(28, 'Gabriel', 'García', 'Alemania', NULL);
  insert into Clientes values(29, 'Isabella', 'López', 'Argentina', NULL);
  insert into Clientes values(30, 'Santiago', 'Pérez', 'Brasil', 30);

  select*from clientes

  select distinct pais from clientes


  --distinct con los valores nulos tambien funciona con valores igualados en el where
  select distinct nombre from clientes
  where compras is null


  --concatenar palabras t datos diferentes en una consulta
  select nombre+' '+apellido+' '+cast(id_cliente as varchar(4)) as contatenado from clientes
    
	--ordenar los datos
	select *from clientes order by nombre
	select *from clientes order  by nombre desc

	select count(id_cliente),pais 
	from clientes
    group by pais

	-------------------------------------------------------------------------------------

	create table facturas(
  numero int not null,
  fecha datetime,
  cliente varchar(30),
  primary key(numero)
);

create table detalles(
  numerofactura int not null,
  numeroitem int not null, 
  articulo varchar(30),
  precio decimal(5,2),
  cantidad int,
  primary key(numerofactura,numeroitem),
   constraint FK_detalles_numerofactura
   foreign key (numerofactura)
   references facturas(numero)
   on update cascade
   on delete cascade
);

go

set dateformat ymd;

INSERT INTO facturas (numero, fecha, cliente) VALUES
  (1, '2023-06-28', 'Juan Pérez'),
  (2, '2023-06-28', 'María González'),
  (3, '2023-06-28', 'Carlos López'),
  (4, '2023-06-28', 'Ana Rodríguez'),
  (5, '2023-06-28', 'Luisa Martínez'),
  (6, '2023-06-28', 'Pedro Hernández'),
  (7, '2023-06-28', 'Laura Gómez'),
  (8, '2023-06-28', 'Diego Torres'),
  (9, '2023-06-28', 'Valentina Ramírez'),
  (10, '2023-06-28', 'Andrés Silva'),
  (11, '2023-06-28', 'Camila Vargas'),
  (12, '2023-06-28', 'Mateo Castro'),
  (13, '2023-06-28', 'Isabella Rios'),
  (14, '2023-06-28', 'Santiago Morales'),
  (15, '2023-06-28', 'Valeria Rojas'),
  (16, '2023-06-28', 'Daniel Acosta'),
  (17, '2023-06-28', 'Mariana Duarte'),
  (18, '2023-06-28', 'Alejandro Cardona'),
  (19, '2023-06-28', 'Fernanda Mendoza'),
  (20, '2023-06-28', 'Gabriel Medina');

INSERT INTO detalles (numerofactura, numeroitem, articulo, precio, cantidad) VALUES
  (1, 1, 'Lápiz', 1.99, 5),
  (1, 2, 'Cuaderno', 3.99, 3),
  (1, 3, 'Bolígrafo', 0.99, 10),
  (2, 1, 'Goma de borrar', 0.5, 8),
  (2, 2, 'Marcadores', 2.49, 4),
  (2, 3, 'Pegamento', 1.99, 2),
  (3, 1, 'Regla', 1.25, 5),
  (3, 2, 'Tijeras', 2.99, 2),
  (3, 3, 'Notas adhesivas', 0.75, 6),
  (4, 1, 'Lápices de colores', 4.99, 1),
  (4, 2, 'Borrador', 0.99, 3),
  (4, 3, 'Cinta adhesiva', 1.49, 2),
  (5, 1, 'Resaltador', 1.75, 4),
  (5, 2, 'Papel de carta', 2.99, 2),
  (5, 3, 'Clips', 0.25, 10),
  (6, 1, 'Corrector líquido', 1.99, 3),
  (6, 2, 'Carpeta', 2.49, 2),
  (6, 3, 'Sacapuntas', 0.99, 5),
  (7, 1, 'Calculadora', 9.99, 1),
  (7, 2, 'Agenda', 4.99, 1),
  (8, 1, 'Lápiz', 1.99, 5),
  (8, 2, 'Cuaderno', 3.99, 3),
  (8, 3, 'Bolígrafo', 0.99, 10),
  (9, 1, 'Goma de borrar', 0.5, 8),
  (9, 2, 'Marcadores', 2.49, 4),
  (9, 3, 'Pegamento', 1.99, 2),
  (10, 1, 'Regla', 1.25, 5),
  (10, 2, 'Tijeras', 2.99, 2),
  (10, 3, 'Notas adhesivas', 0.75, 6),
  (11, 1, 'Lápices de colores', 4.99, 1),
  (11, 2, 'Borrador', 0.99, 3),
  (11, 3, 'Cinta adhesiva', 1.49, 2),
  (12, 1, 'Resaltador', 1.75, 4),
  (12, 2, 'Papel de carta', 2.99, 2),
  (12, 3, 'Clips', 0.25, 10),
  (13, 1, 'Corrector líquido', 1.99, 3),
  (13, 2, 'Carpeta', 2.49, 2),
  (13, 3, 'Sacapuntas', 0.99, 5),
  (14, 1, 'Calculadora', 9.99, 1),
  (14, 2, 'Agenda', 4.99, 1),
  (15, 1, 'Lápiz', 1.99, 5),
  (15, 2, 'Cuaderno', 3.99, 3),
  (15, 3, 'Bolígrafo', 0.99, 10),
  (16, 1, 'Goma de borrar', 0.5, 8),
  (16, 2, 'Marcadores', 2.49, 4),
  (16, 3, 'Pegamento', 1.99, 2),
  (17, 1, 'Regla', 1.25, 5),
  (17, 2, 'Tijeras', 2.99, 2),
  (17, 3, 'Notas adhesivas', 0.75, 6),
  (18, 1, 'Lápices de colores', 4.99, 1),
  (18, 2, 'Borrador', 0.99, 3),
  (18, 3, 'Cinta adhesiva', 1.49, 2),
  (19, 1, 'Resaltador', 1.75, 4),
  (19, 2, 'Papel de carta', 2.99, 2),
  (19, 3, 'Clips', 0.25, 10),
  (20, 1, 'Corrector líquido', 1.99, 3),
  (20, 2, 'Carpeta', 2.49, 2),
  (20, 3, 'Sacapuntas', 0.99, 5),
  (1, 4, 'Calculadora', 9.99, 1),
  (1, 5, 'Agenda', 4.99, 1);






  --problem with case
  select nombre,apellido,pais,case 
  when compras<5 then 'compras son menores a 5'
  when compras>5 then 'compras ees mayor a 5'
  when compras is null then 'las compras son nulas'
  end as 'compras estado' 
  from clientes

  select *from clientes order by (case
  when nombre is null then apellido else nombre
  end
  );
  




  --insercion de datos dentro de una tbala con la funcion bulkS
  create table autos(
  marca varchar(20),
  modelo varchar(20),
  tipo varchar(20),
  color varchar(20)
  );


  --este es como hacer un bulk para las inserciones de datos . puede insercionarlo atravez de una tabla de excel o un block d notas.
  bulk insert
  autos
  from 'C:\Users\JOSE ANGEL\Pictures\SQL SErver\TABLA_AUTOS.txt'
  with (firstrow=2);

  select*from autos

  ---------------------------------------------------------------
  --------------------------TRIGGER------------------------------
  ---------------------------------------------------------------
  CREATE TABLE CONTROL(
  USUARIO VARCHAR(100),
  FECHA DATE,
  ACCION VARCHAR(20)
  )
  
  CREATE TABLE PRUEBITA(
  ID INT NULL,
  NOMBRE VARCHAR(20),
  FECHA DATE,
  CANTIDAD NUMERIC(3,2)
  )
  --esto me sirve para poder hacer forma de segurar en la tabla pruebita para poder inggresar datos y --
  --y registrar los datos en la tabla control su usuario y datos a mas
   CREATE OR ALTER TRIGGER T_INSERCION ON PRUEBITA
   AFTER INSERT
   AS 
   BEGIN
      DECLARE @USUARIO VARCHAR(30);
	  SET @USUARIO= SUSER_NAME();
	  INSERT INTO CONTROL VALUES (@USUARIO,GETDATE(),'insert');

   END;
   --------------------------------------------------------------
   CREATE OR ALTER TRIGGER T_update ON PRUEBITA
   AFTER UPDATE
   AS 
   BEGIN
      DECLARE @USUARIO VARCHAR(30);
	  SET @USUARIO= SUSER_NAME();
	  INSERT INTO CONTROL VALUES (@USUARIO,GETDATE(),'UPDATE');

   END;
----------------------------------------------------------------------------------------------
------------------trigger mixto--------------------------------------------------
----------------------------------------------------------------------------------------------

   INSERT INTO PRUEBITA VALUES(1,'uuu',GETDATE(),1.20);
   UPDATE PRUEBITA SET NOMBRE='angelito' where id=1;
   delete PRUEBITA where id=1;

   select*FROM PRUEBITA;
   SELECT*FROM CONTROL
   --------------------------------------------------
   create or alter trigger f_control_empleado on pruebita
   for insert,update,delete
   as
   begin
   declare @hora varchar(20)= right(getDate(),8);	
	  if exists(select 0 from inserted)
	    begin
	        if exists (select 0 from deleted)
	  	     begin
	  		    insert into CONTROL values (SUSER_NAME(),GETDATE(),'Uactualiza');
	  		 end
	  	  else
	  	     begin
	  		    insert into CONTROL values (SUSER_NAME(),GETDATE(),'insert , o inserto');
	  		 end
	    
	    end
	 else
	    begin
     		    insert into CONTROL values (SUSER_NAME(),GETDATE(),'delete');
		end
    end;

	----------------------------------------------------------------------------
	--trigerr para restringir un ingreso o actualizacion o eliminacion de datos
	----------------------------------------------------------------------------


	CREATE OR ALTER TRIGGER T_RESTRICCION_INSERT 
	ON PRUEBITA
    INSTEAD OF INSERT
	AS
	BEGIN 
	     SET NOCOUNT ON; --PARA QUE NO MUESTRE MENSAJES
		 INSERT INTO CONTROL VALUES(SUSER_NAME(),right(GETDATE(),8),'INTENTO INSERTAR')
		 PRINT'INTTENTO HACER UNA INSERCION U NO FUE POSIBLE'

	END;

	INSERT INTO PRUEBITA VALUES(100,'NOMBRE',RIGHT(GETDATE(),8),1.44)

	SELECT*FROM PRUEBITA
	SELECT*FROM CONTROL


	----------------------------------------------------------
	-------- RAIZERROR CON TRIGGER----------------------------
	----------------------------------------------------------
	CREATE OR ALTER TRIGGER T_RAIZERROR_DELETE ON PRUEBITA
	FOR DELETE
	AS
	BEGIN
	    IF(SELECT COUNT(*) FROM DELETED)>2
		BEGIN 
		RAISERROR('EN ESTE MOMENTO NO SE PUEDE HACER DOS DELETES',16,1)
		ROLLBACK TRANSACTION
		END
	END;
	----------------------------------------------------------

	CREATE OR ALTER TRIGGER T_RAIZERROR_UPDATE ON PRUEBITA
	FOR UPDATE
	AS
	BEGIN
	    IF UPDATE(PRUEBITA)
		BEGIN 
		RAISERROR('eSTA PROHIBIDO ACTUALIZAR LA TABLA',16,1)
		ROLLBACK TRANSACTION
		END
	END;
	----------------------------------------------------------
	SELECT*FROM PRUEBITA

	CREATE OR ALTER TRIGGER T_RAIZERROR_INSERT ON PRUEBITA
	FOR INSERT
	AS
	BEGIN
	    IF (SELECT NOMBRE FROM INSERTED)='NOMBRE'
		BEGIN 
		RAISERROR('NO PUEDES INSERTAR MAS NOMBRES',16,1)
		ROLLBACK TRANSACTION
		END
	END;


	SELECT *FROM PRUEBITA
    DELETE FROM PRUEBITA WHERE NOMBRE IN ('NOMBRE')
	INSERT INTO PRUEBITA VALUES (2,'NOMBRE',GETDATE(),1.65)
	----------------------------------------------------------
	--desactivar los triger----------------------------------
	-----------------------------------------------------------
    alter table pruebita
	disable trigger T_RESTRICCION_INSERT

	--activar trigger
	alter table pruebita
	enable trigger T_RESTRICCION_INSERT



	----------------------------------------------------------
	------------------------while bucle-----------------------
	----------------------------------------------------------


	declare @contador int=5;

	while (@contador<=10)
	begin

	   if(@contador !=10)
	   begin
	   	   print('el contador es el numero: < '+str(@contador)+' >')
	   end

	   if(@contador=10)
	   begin
	   print('el ultimo numero es <10> ')
	   end
	   set @contador+=1
	end;

	----------------------------------------------------------------------
	-------------CURSOSRES INTRODUCCION ----------------------------------
	----------------------------------------------------------------------

	DECLARE @DESCRIPCION VARCHAR(20);

	DECLARE NOMBRE_CL CURSOR FOR (SELECT NOMBRE FROM clientes)BEGIN
	OPEN NOMBRE_CL
	FETCH NEXT FROM NOMBRE_CL INTO @DESCRIPCION
	WHILE @@FETCH_STATUS = 0
	  BEGIN
	    PRINT @DESCRIPCION
		FETCH NEXT FROM NOMBRE_CL INTO @DESCRIPCION

	  END
	  END;
	CLOSE NOMBRE_CL
	DEALLOCATE NOMBRE_CL


	---CURSOR EN TABLA

	DECLARE 
	@ID INT,
	@NOMBRE VARCHAR(20),
	@APELLIDO VARCHAR(20),
	@PAIS VARCHAR(50),
	@COMPRAS INT

	DECLARE CU_CLIENTE CURSOR  LOCAL STATIC READ_ONLY
	FOR(SELECT id_cliente,nombre,apellido,PAIS,COMPRAS FROM clientes)
	BEGIN
	  OPEN CU_CLIENTE
	  FETCH NEXT FROM CU_CLIENTE INTO @ID,@NOMBRE,@APELLIDO,@PAIS,@COMPRAS

	  WHILE @@FETCH_STATUS=0
	  BEGIN
	      PRINT STR(@ID)+@NOMBRE+@APELLIDO+@PAIS+STR(@COMPRAS)
		  FETCH NEXT FROM CU_CLIENTE INTO @ID,@NOMBRE,@APELLIDO,@PAIS,@COMPRAS
	  END

	END;

	CLOSE CU_CLIENTE
	DEALLOCATE CU_CLIENTE


	---------------------------------------------------------------------------------
	--CURSOR DE UPDATE
	SELECT*FROM TRABAJADORES
	
	DECLARE
	@IDEMPLEADO  INT,
	@PUESTO VARCHAR(50),
	@SALARIO DECIMAL(10,2)

	DECLARE CU_UPDAT CURSOR FOR (SELECT idempleado,puesto,salario FROM TRABAJADORES
	WHERE PUESTO='Secretaria')
	OPEN CU_UPDAT 
	FETCH NEXT FROM CU_UPDAT INTO @IDEMPLEADO,@PUESTO,@SALARIO

	WHILE @@FETCH_STATUS=0
	BEGIN
	   SET @SALARIO=@SALARIO*12
	   UPDATE TRABAJADORES SET SALARIO=@SALARIO
	   WHERE CURRENT OF CU_UPDAT
	   	FETCH NEXT FROM CU_UPDAT INTO @IDEMPLEADO,@PUESTO,@SALARIO

	END
	CLOSE CU_UPDAT
	deallocate CU_UPDAT
		
------------------------------------------------------------------------------------------------------
--------------USO DE LA SINTAXIS OVER SIMPLE U CON PARTITION ------------------------------------------------------------
------------------------------------------------------------------------------------------------------

SELECT*FROM TRABAJADORES
--ES UTIL SI USAMOS UN WHERE Y BUSCAMOS SOLO UN CAMPO NOS MOSTRARA EL PROMEDIO DE TODA LA COLUMNA
SELECT idempleado, nombre,salario ,AVG(salario) OVER() AS 'PROMEDIO' FROM TRABAJADORES


--ESTO ME DEJA HACER PARTITIONES SEGUN LOS PUESTOS Y LOS AGRUPA .
SELECT PUESTO ,AVG(salario) OVER(PARTITION BY PUESTO) AS 'PROMEDIO' FROM TRABAJADORES


---------------------------------------------------------------------------------------
------------------USO DEL OVER CON RACK----------------------------------------
---------------------------------------------------------------------------------------
SELECT * FROM TRABAJADORES

SELECT idempleado,NOMBRE,PUESTO,SALARIO,
RANK() OVER(ORDER BY SALARIO) AS RANGO
FROM TRABAJADORES
ORDER BY RANGO



---------------------------------------------------------------
------------COMMIT Y ROLLBACK-------------------------------
---------------------------------------------------------------
BEGIN TRANSACTION ;

   UPDATE TRABAJADORES SET SALARIO =SALARIO*0.5 ;
   IF(SELECT AVG(salario) FROM TRABAJADORES)>500
   BEGIN
   ROLLBACK TRANSACTION
   PRINT 'NO SE PUDO EJECUTAR'
   END
   ELSE
   BEGIN
   COMMIT TRANSACTION
   PRINT' SI SE LOGRO LA EJECUSION' 
   END



	-----------------------------------------------------------------
	--trucos para sql server----------------------------------------
	-----------------------------------------------------------------

	--eliminar todos los datos de una tabla
	truncate table empleados;

	--renombrar una tabla
	execute sp_rename 'OldNameTable','NewNameTable';

	--podemos covertir una variable a string o otro tipo de dato con estos comandos
	convert(varchar(20),@contador);
	str(@contador);

  --´podemos concatenar palabras
  select CONCAT('hola mundo',' tarados');

  --podemos allar cantidades de digitos de una palabra
  select LEN('hola mundo a todos');

  --podemos redondear numeros a poder arriba ua abajo
  select floor(122.22)
  select CEILING(255.22)

  --podemos convertir todo a minuscula y mayuscula
  select LOWER('hola mundo');
  select upper('hola mundo');

  --podemos recortar del lado insquierdo una palabra
  select RIGHT('hola mundo',1)
  select left('hola mundo',1)

  --recortar los espacios de ambos lados de la palabra
  select trim('                                    hola mundo                                                 ')

  --cambiar todos los datos especificos por otros ojo debe ser el mismo tmaño
  select TRANSLATE('Cosas','Cosas','00000');
  select TRANSLATE('hola mundo','o','0')

  --el tipo de variable identity me sirve que para cada insercion que se haga no sea 
  --necesario insertar un dato nuevo sino que es automatico y correlativo
  create table ejemplo(
  id int identity(1,1000)
  )

















































































