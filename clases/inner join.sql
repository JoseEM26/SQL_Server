	--ABRIENDO LA BASE DE DATOS DEL SISTEMA
	USE MASTER
	GO

	--VALIDAR LA BASE DE DATOS
	IF DB_ID('VENTAS2017') IS NOT NULL
		DROP DATABASE VENTAS2017
	GO
	--CREANDO LA BASE DE DATOS
	CREATE DATABASE VENTAS2017
	GO

	--ABRIENDO LA BASE DE DATOS
	USE VENTAS2017
	GO

	--CAMBIANDO EL FORMATO DE LA FECHA
	SET DATEFORMAT DMY
	GO

	--CREANDO TABLAS Y VALIDANDO

	--TABLA CATEGORIAS
	IF OBJECT_ID ('CATEGORIAS') IS NOT NULL
	BEGIN
	DROP TABLE CATEGORIAS
	END 
	CREATE TABLE CATEGORIAS
	( 
	  COD_CATE			CHAR		(3) 	NOT NULL PRIMARY KEY,
	  NOMBRE			VARCHAR		(25) 	NOT NULL
	)
	GO

	--TABLA DISTRITOS
	IF OBJECT_ID('DISTRITOS') IS NOT NULL
	BEGIN
	DROP TABLE DISTRITOS
	END

	CREATE TABLE DISTRITOS 
	(
	ID_DISTRITO			CHAR		(4) 	NOT NULL PRIMARY KEY,
	NOMBRE_DISTRITO		VARCHAR 	(40) 	NOT NULL
	 )
	GO

	--TABLA CARGOS

	IF OBJECT_ID('CARGOS') IS NOT NULL
	 BEGIN
	 DROP TABLE CARGOS
	 END
	 CREATE TABLE CARGOS
	 (
	COD_CARGO	  		CHAR 		(3) 	NOT NULL PRIMARY KEY,
	NOMBRE_CARGO 		VARCHAR 	(30) 	NOT NULL
	  )
	  GO

	--TABLA EMPLEADO

	IF OBJECT_ID('EMPLEADO') IS NOT NULL
	BEGIN
	DROP TABLE EMPLEADO
	END

	CREATE TABLE EMPLEADO
	(
	 COD_EMPLE			CHAR	 	(5) 	NOT NULL PRIMARY KEY,
	 NOMBRES			VARCHAR 	(25) 	NOT NULL,
	 APELLIDOS			VARCHAR 	(25) 	NOT NULL,
	 DNI_EMPLE			CHAR	 	(8) 	NOT NULL,
	 DIRECCION			VARCHAR 	(60) 	NOT NULL,
	 ESTADO_CIVIL		CHAR    	(1) 	NOT NULL,
	 NIVEL_EDUCA		VARCHAR 	(30) 	NOT NULL,
	 TELEFONO			VARCHAR 	(12) 	NOT NULL,
	 EMAIL				VARCHAR 	(35) 	NOT NULL,
	 SUELDO_BASICO		MONEY	 	NOT 	NULL,
	 FECHA_INGRESO		DATE		NOT 	NULL,
	 ID_DISTRITO		CHAR    	(4) 	NOT NULL REFERENCES DISTRITOS,
	 COD_CARGO			CHAR	 	(3) 	NOT NULL REFERENCES CARGOS
	 )
	 GO
 		
	--TABLA CLIENTE

	IF OBJECT_ID('CLIENTE') IS NOT NULL
	BEGIN
	DROP TABLE CLIENTE
	END

	CREATE TABLE CLIENTE
	(
	ID_CLIENTE			CHAR	 	(6) 	NOT NULL PRIMARY KEY,
	NOMBRES				VARCHAR 	(25) 	NOT NULL,
	APELLIDOS			VARCHAR 	(25) 	NOT NULL,
	DIRECCION			VARCHAR 	(60) 	NULL,
	FONO				CHAR    	(9) 	NULL,
	ID_DISTRITO			CHAR	 	(4) 	NOT NULL REFERENCES DISTRITOS,
	EMAIL				VARCHAR 	(35) 	NULL
	)
	GO

		--TABLA PRODUCTO

		IF OBJECT_ID('PRODUCTO') IS NOT NULL
		BEGIN
		DROP TABLE PRODUCTO
		END

		CREATE TABLE PRODUCTO
		(
		ID_PRODUCTO			CHAR	 	(6)  	NOT NULL PRIMARY KEY,
		DESCRIPCION			VARCHAR 	(45) 	NOT NULL,
		PRECIO_VENTA		MONEY        		NOT NULL,
		STOCK_MINIMO		INT					NULL,
		STOCK_ACTUAL		INT					NULL,
		FECHA_VENC			DATE				NULL,
		COD_CATE			CHAR		(3)		NOT NULL REFERENCES CATEGORIAS
		)

		GO

	--TABLA BOLETA

	IF OBJECT_ID('BOLETA') IS NOT NULL
	BEGIN
	DROP TABLE BOLETA
	END

	CREATE TABLE BOLETA
	(
	 NUM_BOLETA			CHAR	 	(8) 	NOT NULL PRIMARY KEY,
	 FECHA_EMI			DATE	     		NOT NULL,
	 ID_CLIENTE			CHAR	 	(6) 	NOT NULL REFERENCES CLIENTE,
	 COD_EMPLE			CHAR	 	(5) 	NOT NULL REFERENCES EMPLEADO,
	 ESTADO_BOLETA		VARCHAR 	(25) 	NOT NULL
	 )
	 GO

	  --TABLA DETALLE_BOLETA

	IF OBJECT_ID ('DETALLEBOLETA') IS NOT NULL
	BEGIN
	DROP TABLE DETALLEBOLETA
	END

	CREATE TABLE DETALLEBOLETA
	(
	 NUM_BOLETA			CHAR 		(8) 	NOT NULL REFERENCES BOLETA,
	 ID_PRODUCTO		CHAR 		(6) 	NOT NULL REFERENCES PRODUCTO,
	 CANTIDAD			INT	  				NOT NULL,
	 IMPORTE			MONEY	  			NOT NULL,
	 PRIMARY KEY (NUM_BOLETA, ID_PRODUCTO)
	 )
	 GO

	 --@@@@@@@@@@@@@@@@@@@@@IMPLEMENTACI�N DE RESTRICCIONES@@@@@@@@@@@@@@@@@@@@
							--@@DEFAULT, CHECK, UNIQUE@@


	--@@@@@ DEFAULT @@@@@

	 --ASIGNAR EL VALOR CERO AL STOCK MINIMO Y STOCK ACTUAL DE LA TABLA PRODUCTO 
	ALTER TABLE PRODUCTO  
	ADD CONSTRAINT DF_STOCKACT 
	   DEFAULT 0 FOR STOCK_ACTUAL 
	GO 
 
	ALTER TABLE PRODUCTO  
	ADD CONSTRAINT DF_STOCKMIN 
	   DEFAULT 0 FOR STOCK_MINIMO 
	GO 
 
	--ASIGNAR EL VALOR �AC� AL ESTADO DE LA BOLETA DE LA TABLA BOLETA. 
	ALTER TABLE BOLETA  
	ADD CONSTRAINT DF_ESTADO 
	   DEFAULT 'AC' FOR ESTADO_BOLETA 
	GO 
 
	--ASIGNAR EL VALOR �NO REGISTRA� AL CORREO ELECTRONICO (EMAIL) DE LA TABLA CLIENTE
	ALTER TABLE CLIENTE  
	ADD CONSTRAINT DF_EMAIL 
	   DEFAULT 'NO REGISTRA' FOR EMAIL 
	GO 
 
	--ASIGNAR EL VALOR �0000000� AL TELEFONO DE LA TABLA CLIENTE 
	ALTER TABLE CLIENTE  
	ADD CONSTRAINT DF_TELEFONO 
	   DEFAULT '000000000' FOR FONO 
	GO 
 
	--@@@@@ CHECK @@@@@

	--EL PRECIO DE VENTA DEL PRODUCTO DEBE SER MAYOR A CERO 
	ALTER TABLE PRODUCTO 
	  ADD CONSTRAINT CHK_PRECIOVENTA 
	  CHECK (PRECIO_VENTA>0) 
	GO

	--EL ESTADO DE LA BOLETA SOLO DEBE PERMITIR LOS VALORES AC(ACTIVO) Y AN(ANULADO)
	ALTER TABLE BOLETA 
	  ADD CONSTRAINT CHK_ESTADO 
	  CHECK (ESTADO_BOLETA IN('AC','AN')) 
	GO 
 
	--LA FECHA DE EMISI�N DE LA BOLETA DEBE MAYOR O IGUAL A LA FECHA ACTUAL.
	--ALTER TABLE BOLETA
	--ADD CONSTRAINT CHK_FECHA_EMI
	--CHECK (FECHA_EMI>=GETDATE())
	--GO

	--EL CAMPO ESTADO CIVIL DE LA TABLA EMPLEADO SOLO DEBE PERMITIR LOS VALORES C (CASADO), S (SOLTERO), T (CONVIVIENTE), D (DIVORCIADO), V (VIUDO)
	ALTER TABLE EMPLEADO
	ADD CONSTRAINT CK_ESTADOCIVIL
	CHECK (ESTADO_CIVIL IN('S','C','V','D','T'))
	GO

	--EL CAMPO NIVEL DE EDUCACI�N DE LOS EMPLEADOS DEBE PERMITIR LOS VALORES (PRIMARIA, SECUNDARIA, SUPERIOR, UNIVERSITARIO).
	ALTER TABLE EMPLEADO
	ADD CONSTRAINT CK_NIVELEDUCA
	CHECK (NIVEL_EDUCA IN('PRIMARIA','SECUNDARIA','SUPERIOR','UNIVERSITARIO'))
	GO

	--EL SUELDO B�SICO DE LOS EMPLEADOS DEBE SER COMO M�NIMO 850.00
	ALTER TABLE EMPLEADO
	ADD CONSTRAINT CKSUELDO
	CHECK(SUELDO_BASICO>=850.00)
	GO

	--EL CAMPO C�DIGO DE LA TABLA EMPLEADO DEBE EMPEZAR CON LA LETRA E
	ALTER TABLE EMPLEADO
	ADD CONSTRAINT CHK_CODEMPLE
	CHECK (COD_EMPLE   LIKE 'E[0-9][0-9][0-9][0-9]')
	GO

	--EL CAMPO C�DIGO DE LA TABLA EMPLEADO DEBE EMPEZAR CON LA LETRA E

	ALTER TABLE CATEGORIAS
	ADD CONSTRAINT CHK_CODCATE
	CHECK (COD_CATE LIKE 'C[0-9][0-9]')
	GO

	--@@@@@ UNIQUE @@@@@

	--LOS NOMBRES DE LOS DISTRITOS DEBEN SER VALORES UNICOS 
	ALTER TABLE DISTRITOS 
	  ADD CONSTRAINT UQ_NOMBRE_DIST 
	  UNIQUE (NOMBRE_DISTRITO) 
	GO 
 
	--LA DESCRIPCI�N DEL PRODUCTO DEBEN SER VALORES UNICOS 
	ALTER TABLE PRODUCTO 
	  ADD CONSTRAINT UQ_DESCRIPCION_PROD 
	  UNIQUE (DESCRIPCION) 
	GO 
 
	--EL DNI DE LA TABLA EMPLEADO DEBEN SER VALORES UNICOS 
	ALTER TABLE EMPLEADO 
	  ADD CONSTRAINT UQ_DNIEMPLE 
	  UNIQUE (DNI_EMPLE) 
	GO 

	--EL DNI DE LA TABLA EMPLEADO DEBEN SER VALORES UNICOS 
	ALTER TABLE EMPLEADO 
	  ADD CONSTRAINT UQ_DIRECCION 
	  UNIQUE (DIRECCION) 
	GO 

	--VERIFICAR TODAS LAS RESTRICCIONES DE LA TABLA PRODUCTO 
	SP_HELPCONSTRAINT PRODUCTO 
 
	--ELIMINAR LA RESTRICCION UQ_DESCRIPCION_PROD DE LA TABLA PRODUCTO 
	--ALTER TABLE PRODUCTO 
	--DROP UQ_DESCRIPCION_PROD

	--LISTANDO LAS TABLAS CREADAS EN UNA BASE DE DATOS
		 SELECT * FROM INFORMATION_SCHEMA.TABLES
		 GO


	--LISTADO LAS COLUMNAS DE LA TABLA PRODUCTO
		 GO
		 SP_COLUMNS PRODUCTO
		 GO



 --@@@@@@@@@@@@@@@@@@@TRATAMIENTO DE DATOS DATOS@@@@@@@@@@@@@@@@@@@@@@@@@
 --@@@@@@@@@@@@@@@@@@@SENTENCIAS DML - INSERT, UPDATE, DELETE@@@@@@@@@@@@


 
 --INSERTANDO REGISTROS

 --INSERTAR REGISTROS A LA TABLA CATEGORIAS --Inserci�n individual

 INSERT INTO CATEGORIAS(COD_CATE, NOMBRE)VALUES ('C01', 'ABARROTES')
 INSERT INTO CATEGORIAS (COD_CATE, NOMBRE) VALUES('C02','LACTEOS')
 INSERT INTO CATEGORIAS (COD_CATE, NOMBRE) VALUES('C03','FRUTAS')
 INSERT INTO CATEGORIAS (COD_CATE, NOMBRE) VALUES('C04','BEBIDAS')
 INSERT INTO CATEGORIAS (COD_CATE, NOMBRE) VALUES('C05','CONDIMENTOS')
 INSERT INTO CATEGORIAS (COD_CATE, NOMBRE) VALUES('C06','VERDURAS')
 INSERT INTO CATEGORIAS (COD_CATE, NOMBRE) VALUES('C07','MENESTRAS')
 INSERT INTO CATEGORIAS (COD_CATE, NOMBRE) VALUES('C08','CEREALES')
 INSERT INTO CATEGORIAS (COD_CATE, NOMBRE) VALUES('C09','DETERGENTES')
 INSERT INTO CATEGORIAS (COD_CATE, NOMBRE) VALUES('C10','GOLOSINAS')
 INSERT INTO CATEGORIAS (COD_CATE, NOMBRE) VALUES('C11','CONSERVAS')
 INSERT INTO CATEGORIAS (COD_CATE, NOMBRE) VALUES('C12','HELADOS')


 SELECT * FROM CATEGORIAS
 GO

 --INSERTAR REGISTROS A LA TABLA DISTRITOS --Inserci�n individual

 INSERT INTO DISTRITOS (ID_DISTRITO, NOMBRE_DISTRITO) VALUES ('D001','COMAS')
 INSERT INTO DISTRITOS (ID_DISTRITO, NOMBRE_DISTRITO) VALUES ('D002','LINCE')
 INSERT INTO DISTRITOS (ID_DISTRITO, NOMBRE_DISTRITO) VALUES ('D003','CERCADO')
 INSERT INTO DISTRITOS (ID_DISTRITO, NOMBRE_DISTRITO) VALUES ('D004','MIRAFLORES')
 INSERT INTO DISTRITOS (ID_DISTRITO, NOMBRE_DISTRITO) VALUES ('D005','LOS OLIVOS')
 INSERT INTO DISTRITOS (ID_DISTRITO, NOMBRE_DISTRITO) VALUES ('D006','S.J.L.')
 INSERT INTO DISTRITOS (ID_DISTRITO, NOMBRE_DISTRITO) VALUES ('D007','S.J.M.')
 INSERT INTO DISTRITOS (ID_DISTRITO, NOMBRE_DISTRITO) VALUES ('D008','INDEPENDENCIA')
 INSERT INTO DISTRITOS (ID_DISTRITO, NOMBRE_DISTRITO) VALUES ('D009','PUENTE PIEDRA')
 INSERT INTO DISTRITOS (ID_DISTRITO, NOMBRE_DISTRITO) VALUES ('D010','ANC�N')
  
 
 SELECT * FROM DISTRITOS
 GO

 --INSERTAR REGISTROS A LA TABLA CARGOS --Inserci�n individual
 
 INSERT INTO CARGOS VALUES('C01','GERENTE')
 INSERT INTO CARGOS VALUES('C02','ADMINISTRADOR(A)')
 INSERT INTO CARGOS VALUES('C03','VENDEDOR(A)')
 INSERT INTO CARGOS VALUES('C04','CONTADOR(A)')
 INSERT INTO CARGOS VALUES('C05','SECRETARIA')
 go

 SELECT * FROM CARGOS
 GO

--INSERTAR REGISTROS A LA TABLA CLIENTE --Inserci�n individual
INSERT INTO CLIENTE VALUES ('CLI001','ANETH LUANA','TINEO URIBE','AV. LOS GIRASOLES # 1800','990990230','D006','LUANITAHERMOSA@GMAIL.COM')
INSERT INTO CLIENTE VALUES ('CLI002','JOSE LUIS','TARAZONA ZELA','AV. LAS FLORES # 1800',NULL,'D006','JOSESITO@GMAIL.COM')
INSERT INTO CLIENTE VALUES ('CLI003','ANA MARIA','VILLAVICENCIO CASTRO','AV. LAS FLORES # 2560','989434228','D005','ANITAMARIA@GMAIL.COM')
INSERT INTO CLIENTE VALUES ('CLI004','JOSE ANTONIO','ENCISO NOLASCO','AV. PROCERES DE LA INDEPENDENCIA # 5000','987845874','D006','JOSANTONIO@GMAIL.COM')
INSERT INTO CLIENTE VALUES ('CLI005','ALEJANDRA','CHUCO HUERTA','AV. GRAN CHIMU # 3500','963245874','D005','ALEJANDRITA5245@HOTMAIL.COM')
INSERT INTO CLIENTE VALUES ('CLI006','MARIO','CERPA CARRASCO','AV. JOSE CARLOS MARIATEGUI # 3600',NULL,'D003','MARIO56345@GMAIL.COM')
INSERT INTO CLIENTE VALUES ('CLI007','ANA TERESA','ANTON PALOMINO','JR. BOLOGNESI # 850','987546321','D007','ANITATERESITA@GMAIL.COM')
INSERT INTO CLIENTE VALUES ('CLI008','MANUEL','VASQUEZ LICAS','PJE. LOS HUEROS # 450','987564789','D007','MANUEL9878@YAHOO.COM')
INSERT INTO CLIENTE VALUES ('CLI009','CARLOS','VEGA REYES','AV. BRASIL # 3562','965487545','D008','CARLITOSVEGUITA@HOTMAIL.COM')
INSERT INTO CLIENTE VALUES ('CLI010','LUANA','VILLA RAMOS','AV. LA VILLA DEL MAR # 2563','965884578','D010','LUANITAVILLA@GMAIL.COM')
INSERT INTO CLIENTE VALUES ('CLI011','BETSANE','VILLANUEVA QUISPE','AV. LAS TORRES # 2562','','D010',DEFAULT)


SELECT * FROM CLIENTE
GO

--INSERTAR REGISTROS A LA TABLA EMPLEADO --Inserci�n individual

INSERT INTO EMPLEADO VALUES ('E0001','BRENDA','QUISPE RAMOS','40138140','JR. PACHITEA # 140','C','SUPERIOR', '990387487','BRENDITA@GMAIL.COM',6000,'02/03/2014','D005','C02')
INSERT INTO EMPLEADO VALUES ('E0002','ANGELICA','ANDRADE CERNA','40138356','JR. MANUEL PRADO # 250','C','SECUNDARIA', '970315487','ANDRADECERNA@GMAIL.COM',1500,'05/06/2014','D005','C03')
INSERT INTO EMPLEADO VALUES ('E0003','ROSAURA','TARAZONA RIVAS','40457140','JR. LOS ROSALES # 350','S','SECUNDARIA', '993315487','TARANOZARIVAS@GMAIL.COM',1500,'05/08/2014','D002','C03')
INSERT INTO EMPLEADO VALUES ('E0004','RUTH','TARDIO HUAMAN','40198740','AV. JOSE BALTA # 1700','S','UNIVERSITARIO', '990115487','HUAMANTAR@GMAIL.COM',2500,'03/05/2015','D003','C04')
INSERT INTO EMPLEADO VALUES ('E0005','GLORIA','ZELADA VELA','78538140','AV. CARLOS MARIATEGUI # 5000','C','SUPERIOR', '900315487','ZELADAVELA@HOTMAIL.COM',1500,'10/10/2015','D005','C03')
INSERT INTO EMPLEADO VALUES ('E0006','SOLEDAD','ZARATE LOPEZ','35638140','AV. ALFONSO UGARTE # 3420','S','SECUNDARIA', '990316687','LOPEZZA@GMAIL.COM',1500,'04/05/2015','D001','C03')
INSERT INTO EMPLEADO VALUES ('E0007','BETSABE','ZAMUDIO SALAS','40134520','JR. URUGUAY # 145','T','SUPERIOR', '99038797','ZAMUDIOZALAS@GMAIL.COM',1500,'03/03/2015','D006','C03')
INSERT INTO EMPLEADO VALUES ('E0008','ANETH','ROSALES TINEO','40138222','AV. BOLIVIA # 1500','T','SUPERIOR', '990377487','ROSALESTINEO@GMAIL.COM',1500,'04/05/2014','D006','C03')
INSERT INTO EMPLEADO VALUES ('E0009','RAUL','BECERRA VILLA','40133647','AV. CARLOS IZAGUIRRE # 3245','S','SECUNDARIA', '990005487','VILLABECE@GMAIL.COM',1500,'12/12/2013','D003','C03')
INSERT INTO EMPLEADO VALUES ('E0010','VICTOR','CANALES HUAMANI','40124140','JR. ANDAHUAYLAS # 354','C','UNIVERSITARIO', '997815487','CANALESHUAMANI@GMAIL.COM',1500,'03/07/2014','D002','C03')
INSERT INTO EMPLEADO VALUES ('E0011','ANGEL','PORRAS LINARES','02338140','AV. WIESSE # 2650','T','UNIVERSITARIO', '990253878','LINARESPOR@GMAIL.COM',1500,'03/11/2013','D004','C03')
INSERT INTO EMPLEADO VALUES ('E0012','CARLA','URIARTE REGINALDO','40008140','AV. LAS FLORES # 4000','D','SUPERIOR', '991254787','REGINALDOURI@GMAIL.COM',1500,'12/05/2014','D004','C03')
INSERT INTO EMPLEADO VALUES ('E0013','CELIA','ESPINAL CHUCO','40130004','AV. MONTENEGRO # 3564','T','SUPERIOR', '988025947','CELIAESPINAL@GMAIL.COM',1000,'03/06/2013','D008','C03')
INSERT INTO EMPLEADO VALUES ('E0014','THALIA','ROMANI VELIZ','40133365','AV. MANCO CAPAC # 2560','S','UNIVERSITARIO', '988315487','THALIAROMA@HOTMAIL.COM',1500,'03/03/2015','D007','C03')
INSERT INTO EMPLEADO VALUES ('E0015','JUANA','PAREDES PAREDES','40888784','PJE. LOS HUERTOS # 250','C','UNIVERSITARIO', '955315487','JUANITAPA@HOTMAIL.COM',1500,'06/06/2014','D002','C03')


SELECT * FROM EMPLEADO
GO

	--INSERTAR REGISTROS A LA TABLA PRODUCTO --Inserci�n individual

	INSERT INTO PRODUCTO VALUES ('PRO001','ARROZ COSTE�O X 50 - SACO',160.0,5,200,'04/03/2018','C01')
	INSERT INTO PRODUCTO VALUES ('PRO002','AZUCAR RUBIA X 50 - SACO',100.0,2,80,'05/05/2018','C01')
	INSERT INTO PRODUCTO VALUES ('PRO003','FIDEOS ANITA X 12 - BOLSA',30.0,3,150,'08/10/2018','C01')
	INSERT INTO PRODUCTO VALUES ('PRO004','FIDEOS MOLITALIA X 12 - BOLSA',35.0,5,120,'08/08/2018','C01')
	INSERT INTO PRODUCTO VALUES ('PRO005','YOGURT GLORIA X 6 - PAQUETE',26.0,5,230,'25/08/2018','C02')
	INSERT INTO PRODUCTO VALUES ('PRO006','LECHE GLORIA X 48 - CAJA',98.0,5,240,'31/12/2017','C02')
	INSERT INTO PRODUCTO VALUES ('PRO007','ACEITE PRIMOR X 12 - CAJA ',75.0,10,180,'10/10/2019','C01')
	INSERT INTO PRODUCTO VALUES ('PRO008','LENTEJAS X 50 - SACO',230.0,5,50,'20/12/2017','C07')
	INSERT INTO PRODUCTO VALUES ('PRO009','PALLARES X 50 - SACO',290.0,2,30,'02/12/2017','C07')
	INSERT INTO PRODUCTO VALUES ('PRO010','ATUN A1 X 48 - CAJA',145.0,2,80,'12/12/2019','C01')
	INSERT INTO PRODUCTO VALUES ('PRO011','GALLETA CHARADA X 100 - BOLSA',72.0,5,160,'30/11/2017','C10')
	INSERT INTO PRODUCTO VALUES ('PRO012','GASEOSA COCACOLA X 24 - CAJA',24.0,2,50,'26/10/2017','C04')
	INSERT INTO PRODUCTO VALUES ('PRO013','DETERGENTE ARIEL X KILO - BOLSA',15.0,2,40,'07/08/2018','C09')
	INSERT INTO PRODUCTO VALUES ('PRO014','COMINO X 100 - CAJA',10.0,5,300,'02/12/2017','C05')
	INSERT INTO PRODUCTO VALUES ('PRO015','GASEOSA PEPSI X 12 MEDIANA- PAQUETE',20.0,5,50,'02/03/2018','C04')
	INSERT INTO PRODUCTO VALUES ('PRO016','DOS CABALLOS X 6 - CAJA',28.0,5,45,'02/03/2019','C11')
	INSERT INTO PRODUCTO VALUES ('PRO017','CEREALES ANGEL X KILO - BOLSA',18.0,5,70,'02/10/2017','C05')
	INSERT INTO PRODUCTO VALUES ('PRO018','QUAKER X KILO - BOLSA',7.00,5,300,'02/12/2017','C01')
	INSERT INTO PRODUCTO VALUES ('PRO019','PEZIDURI X LITRO - POTE',8.50,5,300,'31/12/2017','C12')
	INSERT INTO PRODUCTO VALUES ('PRO020','ARROZ PAISANA SUPERIOR x 5kg- Bolsa',17.0,5,80,'07/12/2017','C01')
	INSERT INTO PRODUCTO VALUES ('PRO021','MANTEQUILLA X 12 - PAQUETE',22.0,3,30,'02/02/2018','C01')
	INSERT INTO PRODUCTO VALUES ('PRO022','ACEITE FRIOL X 6 - BOLSA',25.0,2,60,'02/03/2018','C01')
	INSERT INTO PRODUCTO VALUES ('PRO023','MERMELADA X 12 - PAQUETE',35.0,3,42,'31/12/2017','C01')
	INSERT INTO PRODUCTO VALUES ('PRO024','GASEOSA SPRITE PERSONAL X 24 - PAQUETE',45.0,6,150,'31/12/2018','C04')
	INSERT INTO PRODUCTO VALUES ('PRO025','VINO BORGO�A X 6 - CAJA',60.0,5,100,'07/05/2018','C04')


	SELECT * FROM CATEGORIAS




SELECT * FROM PRODUCTO
GO

--INSERTAR REGISTROS A LA TABLA BOLETA Y SU DETALLE BOLETA -- Inserci�n individual

INSERT INTO BOLETA VALUES('10000001','01/05/2017','CLI002','E0002','AC')
INSERT INTO BOLETA VALUES('10000002','15/04/2017','CLI002','E0005','AC')
INSERT INTO BOLETA VALUES('10000003','03/02/2016','CLI001','E0002','AC')
INSERT INTO BOLETA VALUES('10000004','02/05/2017','CLI003','E0005','AC')
INSERT INTO BOLETA VALUES('10000005','03/04/2015','CLI001','E0005','AC')
INSERT INTO BOLETA VALUES('10000006','30/04/2015','CLI010','E0007','AC')
INSERT INTO BOLETA VALUES('10000007','04/03/2015','CLI009','E0007','AC')
INSERT INTO BOLETA VALUES('10000008','03/10/2015','CLI004','E0001','AC')
INSERT INTO BOLETA VALUES('10000009','10/10/2016','CLI005','E0002','AC')
INSERT INTO BOLETA VALUES('10000010','11/11/2016','CLI009','E0002','AC')

GO



--AHORA INSERTAREMOS A SU DETALLE BOLETA

INSERT INTO DETALLEBOLETA VALUES('10000001','PRO002',3,300.0)
INSERT INTO DETALLEBOLETA VALUES('10000001','PRO010',2,290.0)

INSERT INTO DETALLEBOLETA VALUES('10000002','PRO002',2,200.0)
INSERT INTO DETALLEBOLETA VALUES('10000002','PRO006',3,294.0)
INSERT INTO DETALLEBOLETA VALUES('10000002','PRO008',1,230.0)

INSERT INTO DETALLEBOLETA VALUES('10000003','PRO008',2,460.0)
INSERT INTO DETALLEBOLETA VALUES('10000003','PRO010',3,435.0)
INSERT INTO DETALLEBOLETA VALUES('10000003','PRO012',6,120.0)
INSERT INTO DETALLEBOLETA VALUES('10000003','PRO014',10,100.0)


INSERT INTO DETALLEBOLETA VALUES('10000004','PRO004',6,210.0)
INSERT INTO DETALLEBOLETA VALUES('10000004','PRO011',11,792.0)
INSERT INTO DETALLEBOLETA VALUES('10000004','PRO013',3,45.0)

INSERT INTO DETALLEBOLETA VALUES('10000005','PRO013',5,75.0)
INSERT INTO DETALLEBOLETA VALUES('10000005','PRO014',8,80.0)
INSERT INTO DETALLEBOLETA VALUES('10000005','PRO011',7,504.0)
INSERT INTO DETALLEBOLETA VALUES('10000005','PRO012',4,96.0)

INSERT INTO DETALLEBOLETA VALUES('10000006','PRO007',2,150.0)
INSERT INTO DETALLEBOLETA VALUES('10000006','PRO009',1,290.0)

INSERT INTO DETALLEBOLETA VALUES('10000007','PRO013',6,90.0)
INSERT INTO DETALLEBOLETA VALUES('10000007','PRO011',2,144.0)
INSERT INTO DETALLEBOLETA VALUES('10000007','PRO001',10,1600.0)
INSERT INTO DETALLEBOLETA VALUES('10000007','PRO003',5,150.0)

INSERT INTO DETALLEBOLETA VALUES('10000008','PRO025',3,180.0)
INSERT INTO DETALLEBOLETA VALUES('10000008','PRO024',2,90.0)

INSERT INTO DETALLEBOLETA VALUES('10000009','PRO023',2,70.0)
INSERT INTO DETALLEBOLETA VALUES('10000009','PRO022',3,75.0)

INSERT INTO DETALLEBOLETA VALUES('10000010','PRO021',2,44.0)
INSERT INTO DETALLEBOLETA VALUES('10000010','PRO017',8,144.0)

GO


SELECT * FROM CATEGORIAS
SELECT * FROM DISTRITOS
SELECT * FROM CARGOS
SELECT * FROM CLIENTE
SELECT * FROM EMPLEADO
SELECT * FROM PRODUCTO
SELECT * FROM BOLETA
SELECT * FROM DETALLEBOLETA

GO

 --**************** USO DE CONBINACION INTERNA INNER JOIN*********************
 --****************CONSULTAS MULTITABLA***************************************
 --****************PROCEDIMIENTOS ALMACENADOS CON INNER JOIN Y CON PAR�METROS DE ENTRADA*******************
  
/**CONSULTAS UTILIZANDO COMBINACIONES INTERNAS**/

--1. Mostrar todos los registros de la tabla productos; as� como el nombre de categor�a.

--2. Mostrar los campos codigo del empleado, nombres, apellidos, sueldo b�sico, 
--fecha de ingreso; as� como el nombre del cargo y nombre del distrito. 
--Utilice Alias para las tablas y cambie el encabezado de las columnas.

--3. Mostrar los campos num_boleta de la tabla detalle boleta, descripci�n del producto, 
--precio_venta, cantidad de detalle boleta, importe de la tabla detalle boleta; 
--pero s�lo aquellos registros cuya cantidad se encuentre entre 5 y 25.

--4. Mostrar los campos num_boleta, Nombre del cliente, Apellidos, el d�a, el mes y 
--el a�o en que se realiz� la venta por separado, de aquellos registros donde el a�o 
--es mayor a 2010. Ord�nalos de forma ascendente por codigo de cliente. 
--Utilizar Alias y Sentencias Day, Month y Year.

--5. Mostrar todos los campos de la tabla cliente a excepci�n de los clientes del distrito 
--de Cercado y Los Olivos y que hayan comprado productos cuya descripci�n comienza con 
--la letra A cantidad>=2. Utilizar alias, operadores de comparaci�n y operador l�gico NOT.

--6. Visualizar el nombre del cliente, apellidos, n�mero de boleta, descripci�n del 
--producto comprados, cantidad y fecha de emisi�n de todos aquellos clientes cuya 
--segunda letra de apellidos sea A.

/**PROCEDIMIENTOS ALMACENADOS 1 parametro**/

--1. Crear un procedimiento almacenado con el nombre sp_ClientesxDistrito 
--que permita mostrar codigo del cliente, nombres, apellidos, direcci�n y nombre del distrito. 
--El procedimiento debe mostrar solo los clientes que viven en un distrito espec�fico. 
--El par�metro de entrada ser� para el nombre del distrito.

--2. Crear un procedimiento almacenado con el nombre sp_Ventas_ProductosxCliente 
--que permita mostrar todos los productos comprados por cierto cliente. 
--El par�metro de entrada ser� para el nombre del cliente.

--3. Crear un procedimiento almacenado con el nombre sp_empleadosxCargo 
--que permita mostrar todos los empleados de un cargo especifico. 
--Pasar el par�metro al nombre del cargo.

--4. Crear un procedimiento almacenado con el nombre sp_BoletaxEmpleado 
--que permita mostrar n�mero de boleta, fecha de emisi�n y estado boleta 
--que ha emitido un empleado espec�fico. Pasar el par�metro de entrada al nombre del empleado.
--Validar, si el empleado existe que se muestre los datos correspondientes; 
--caso contrario que se imprima �No existe empleado�

--5. Crear un procedimiento almacenado con el nombre usp_BoletaxCliente 
--que permita mostrar todas las boletas que pertenecen a un cliente espec�fico. 
--Pasar el par�metro al nombre del cliente.

/**PROCEDIMIENTOS ALMACENADOS 2 o m�s parametro**/

--6. Crear un procedimiento almacenado con el nombre sp_VentasXa�os que permita 
--mostrar n�mero de boleta, fecha de emisi�n, nombre y apellidos del cliente de 
--un rango de a�os. Para ello debe pasar 2 par�metros de entrada aini (a�o inicial) 
--y afin (a�o final).

--7. Crear un procedimiento almacenado con el nombre sp_VentasXBoleta que permita 
--mostrar los datos de los productos que se adquirieron en una boleta. 
--El usuario ingresar� 2 par�metros de entrada para el campo n�mero de boleta.
--Ejemplo: EXECUTE usp_VentasXBoleta '10000001', '10000005' GO

--8. Crear un procedimiento almacenado con el nombre sp_productosxCategoria que permita 
--mostrar todos los productos que pertenecen a 2 categor�as diferentes. 
--Pasar 2 par�metros cat1 y cat2.

--9. Crear un procedimiento almacenado con el nombre sp_Productos_x_a�o_venc que 
--permita mostrar c�digo, descripci�n, precio de venta, fecha de vencimiento y 
--nombre de categor�a para aquellos productos que vencen en un rango de a�os. 
--Pasar 2 par�metros an1 y an2.

--10. Crear un procedimiento almacenado con el nombre sp_emplexNivel_EstCivil_anno_ing que 
--permita mostrar todos los empleados que pertenecen a un nivel de educaci�n y estado civil y
--a�o de ingreso espec�fico. Pasar 3 par�metros @nivel, @estacivil y @a�oingreso.

--11. Crear un procedimiento almacenado con el nombre sp_EmpleadosxCargoDistrito que 
--permita mostrar todos los empleados que pertenecen a un cargo y distrito especifico. 
--Pasar el par�metro al nombre del cargo y nombre del distrito.












