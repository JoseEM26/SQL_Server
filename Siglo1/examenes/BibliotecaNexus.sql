USE MASTER
GO

IF DB_ID('BIBLIOTECA_NEXUZ') IS NOT NULL
	DROP DATABASE BIBLIOTECA_NEXUZ
GO

CREATE DATABASE BIBLIOTECA_NEXUZ
GO

USE BIBLIOTECA_NEXUZ
GO

CREATE TABLE CATEGORIA(
  ID_CATEGORIA    CHAR(4)      NOT NULL   PRIMARY KEY,
  DESCRIPCION     VARCHAR(50)  NOT NULL
)

CREATE TABLE USUARIO(
  ID_USUARIO     CHAR(5)       NOT NULL   PRIMARY KEY,
  NOM_USUARIO    VARCHAR(30)   NOT NULL,
  APE_USUARIO    VARCHAR(30)   NOT NULL,
  FECH_REGISTRO  DATE          NOT NULL,
  CORREO_USUARIO VARCHAR(50)   NOT NULL
)

CREATE TABLE TRABAJADORES(
  ID_DNI         CHAR(8)       NOT NULL,
  SALARIO        MONEY         NOT NULL,
  PUESTO         VARCHAR(20)   NOT NULL,
  NOMBRE         VARCHAR(30)   NOT NULL,
  DIRECCION      VARCHAR(40)   NOT NULL,
  DNI_SUPERVISOR CHAR(8)       NOT NULL   REFERENCES TRABAJADORES,
  PRIMARY KEY(ID_DNI)
)

CREATE TABLE AUTOR(
  ID_AUTOR       CHAR(4)       NOT NULL   PRIMARY KEY,
  NOM_AUTOR      VARCHAR(50)   NOT NULL, 
  APE_AUTOR      VARCHAR(40)   NOT NULL,
  NACIONALIDAD   VARCHAR(20)   NOT NULL,
)

CREATE TABLE LIBRO(
  ID_LIBRO       CHAR(5)       NOT NULL   ,
  ID_CATEGORIA   CHAR(4)       NOT NULL   REFERENCES CATEGORIA,
  NOM_LIBRO      VARCHAR(50)   NOT NULL, 
  FECH_LANZAMIENTO DATE        NOT NULL, 
  ID_AUTOR       CHAR(4)       NOT NULL   REFERENCES AUTOR,
  ID_DNI         CHAR(8)       NOT NULL   REFERENCES TRABAJADORES,
  PRIMARY KEY(ID_LIBRO)
)

CREATE TABLE PRESTAMO(
  ID_PRESTAMO   CHAR(4)         NOT NULL  ,
  ID_USUARIO    CHAR(5)         NOT NULL  REFERENCES USUARIO,
  FECH_PRESTAMO DATE            NOT NULL,
  ID_DNI        CHAR(8)         NOT NULL  REFERENCES TRABAJADORES,
  PRIMARY KEY(ID_PRESTAMO)
)

CREATE TABLE LIBRO_PRESTAMO(
  ID_LIBRO     CHAR(5)          NOT NULL   REFERENCES LIBRO,
  ID_PRESTAMO  CHAR(4)          NOT NULL  REFERENCES PRESTAMO,
  FECHA_DEVOLUCION DATE         NOT NULL ,
  PRIMARY KEY(ID_LIBRO,ID_PRESTAMO)
)

CREATE TABLE LIMPIEZA(
  ID_DNI      CHAR(8)           NOT NULL  REFERENCES TRABAJADORES,
  HAB_ESPECIFICA  VARCHAR(40)   NOT NULL,
  HORARIO     CHAR(1)				NOT NULL
  PRIMARY KEY(ID_DNI)
)

CREATE TABLE RECEPCIONISTA(
  ID_DNI      CHAR(8)           NOT NULL  REFERENCES TRABAJADORES,
  CORREO      VARCHAR(40)       NOT NULL,
  CONOC_INFORMATICO VARCHAR(40) NOT NULL
  PRIMARY KEY(ID_DNI)
)


--AGREGANDO RESTRICCIONES A LAS TABLAS

--RESTRICCIONES EN LA TABLA CATEGORIA
ALTER TABLE CATEGORIA ADD DEFAULT 'NO HAY DESCRIPCION' FOR DESCRIPCION
ALTER TABLE CATEGORIA ADD UNIQUE (ID_CATEGORIA)

-- RESTRICCIONES EN LA TABLA USUARIO
ALTER TABLE USUARIO ADD CHECK (FECH_REGISTRO <= GETDATE())
ALTER TABLE USUARIO ADD UNIQUE (CORREO_USUARIO)
ALTER TABLE USUARIO ADD UNIQUE (ID_USUARIO)

--RESTRICCIONES EN LA TABLA TRABAJADORES
ALTER TABLE TRABAJADORES  ADD CHECK (SALARIO >= 1025)
ALTER TABLE TRABAJADORES  ADD CHECK (PUESTO IN ('LIMPIEZA','RECEPCIONISTA'))
ALTER TABLE TRABAJADORES  ADD UNIQUE (ID_DNI)

--RESTRICCIONES EN LA TABLA AUTOR
ALTER TABLE AUTOR  ADD UNIQUE (ID_AUTOR)

--RESTRICCIONES EN LA TABLA LIBRO
ALTER TABLE LIBRO ADD CHECK(FECH_LANZAMIENTO > GETDATE())
ALTER TABLE LIBRO ADD UNIQUE (ID_LIBRO)

--RESTRICCIONES EN LA TABLA PRESTAMO
ALTER TABLE PRESTAMO ADD CHECK (FECH_PRESTAMO <= GETDATE())
ALTER TABLE PRESTAMO ADD UNIQUE(ID_PRESTAMO)


--RESTRICCIONES EN LA TABLA LIBRO_PRESTAMO
ALTER TABLE LIBRO_PRESTAMO ADD CHECK (FECHA_DEVOLUCION > GETDATE())

--RESTRICCIONES EN LA TABLA LIMPIEZA 
ALTER TABLE LIMPIEZA ADD CHECK (HAB_ESPECIFICA IN('BARRER','DESEMPOLVAR LOS LIBROS','ORDENAR LOS LIBROS')) 
ALTER TABLE LIMPIEZA ADD CHECK (HORARIO IN('T','M','N'))

--RESTRICCIONES EN LA RECEPCIONISTA
ALTER TABLE RECEPCIONISTA ADD UNIQUE (CORREO)
ALTER TABLE RECEPCIONISTA ADD CHECK (CONOC_INFORMATICO IN ('WORD','EXCEL'))


--INSERTANDO DATOS A LAS TABLAS

--INSERTANDO DATOS A LA TABLA CATEGORIAS
INSERT INTO CATEGORIA VALUES ('CA01','LÍRICO')
INSERT INTO CATEGORIA VALUES ('CA02','DRAMÁTICO')
INSERT INTO CATEGORIA VALUES ('CA03','ÉPICO')
INSERT INTO CATEGORIA VALUES ('CA04','RELIGIOSO')
INSERT INTO CATEGORIA VALUES ('CA05','AUTOAYUDA')
INSERT INTO CATEGORIA VALUES ('CA06','INTERACTIVO')
INSERT INTO CATEGORIA VALUES ('CA07','BIOGRAFICOS')
INSERT INTO CATEGORIA VALUES ('CA08','CIENTIFICOS')
INSERT INTO CATEGORIA VALUES ('CA09','NOVELAS')
INSERT INTO CATEGORIA VALUES ('CA10','FABULAS')
GO

SELECT * FROM CATEGORIA

--INSERTANDO DATOS A LA TABLA USUARIO
INSERT INTO USUARIO VALUES ('0001', 'JUAN', 'PÉREZ', '2006/09/12', 'juanperez@gmail.com');
INSERT INTO USUARIO VALUES ('0002', 'MARÍA', 'GONZÁLEZ', '2019/05/28', 'mariagonzalez@gmail.com');
INSERT INTO USUARIO VALUES ('0003', 'CARLOS', 'LÓPEZ', '2002/03/10', 'carloslopez@gmail.com');
INSERT INTO USUARIO VALUES ('0004', 'ANA', 'MARTÍNEZ', '2008/07/20', 'anamartinez@gmail.com');
INSERT INTO USUARIO VALUES ('0005', 'PEDRO', 'SÁNCHEZ', '2014/02/15', 'pedrosanchez@gmail.com');
INSERT INTO USUARIO VALUES ('0006', 'LAURA', 'RODRÍGUEZ', '2017/11/05', 'laurarodriguez@gmail.com');
INSERT INTO USUARIO VALUES ('0007', 'PABLO', 'FERNÁNDEZ', '2001/08/22', 'pablofernandez@gmail.com');
INSERT INTO USUARIO VALUES ('0008', 'LUCÍA', 'GÓMEZ', '2004/01/04', 'luciagomez@gmail.com');
INSERT INTO USUARIO VALUES ('0009', 'NELSON', 'ESPÍRITU', '2010/10/05', 'nelsones@gmail.com');
INSERT INTO USUARIO VALUES ('0010', 'LUIS', 'ÁLVAREZ', '2009/12/20', 'luisalvarez@gmail.com');
INSERT INTO USUARIO VALUES ('0011', 'ELENA', 'DÍAZ', '2005/04/17', 'elenadiaz@gmail.com');
INSERT INTO USUARIO VALUES ('0012', 'MIGUEL', 'HERNÁNDEZ', '2003/06/03', 'miguelhernandez@gmail.com');
INSERT INTO USUARIO VALUES ('0013', 'SARA', 'VÁZQUEZ', '2016/08/28', 'saravazquez@gmail.com');
INSERT INTO USUARIO VALUES ('0014', 'JAVIER', 'TORRES', '2012/10/12', 'javiertorres@gmail.com');
INSERT INTO USUARIO VALUES ('0015', 'CARMEN', 'RUIZ', '2000/11/09', 'carmenruiz@gmail.com');
INSERT INTO USUARIO VALUES ('0016', 'DIEGO', 'GARCÍA', '2018/03/22', 'diegogarcia@gmail.com');
INSERT INTO USUARIO VALUES ('0017', 'SOFÍA', 'NAVARRO', '2007/07/14', 'sofianavarro@gmail.com');
INSERT INTO USUARIO VALUES ('0018', 'MARTÍN', 'JIMÉNEZ', '2013/09/02', 'martinjimenez@gmail.com');
INSERT INTO USUARIO VALUES ('0019', 'PAULA', 'MORENO', '2015/01/05', 'paulamoreno@gmail.com');
INSERT INTO USUARIO VALUES ('0020', 'MARIO', 'ORTEGA', '2023/08/19', 'marioortega@gmail.com');
GO 

SELECT * FROM USUARIO

--INSERTANDO DATOS A LA TABLA TRABAJADORES 
INSERT INTO TRABAJADORES VALUES ('234567', 2500.00, 'RECEPCIONISTA', 'JOSÉ GARCÍA', 'CALLE PRINCIPAL 123', 234567);
INSERT INTO TRABAJADORES VALUES ('345678', 1800.50, 'RECEPCIONISTA', 'MARINA HERNÁNDEZ', 'AVENIDA CENTRAL 456', 234567);
INSERT INTO TRABAJADORES VALUES ('456789', 2100.75, 'LIMPIEZA', 'ANDRÉS MARTÍNEZ', 'CALLE DEL SOL 789', 234567);
INSERT INTO TRABAJADORES VALUES ('567890', 3000.00, 'RECEPCIONISTA', 'SOFÍA LÓPEZ', 'PASEO DE LA LUNA 987', 234567);
INSERT INTO TRABAJADORES VALUES ('678901', 2200.25, 'LIMPIEZA', 'GABRIELA RODRÍGUEZ', 'AVENIDA DE LOS ÁRBOLES', 234567);
INSERT INTO TRABAJADORES VALUES ('789012', 2600.75, 'RECEPCIONISTA', 'ANTONIO SÁNCHEZ', 'CALLE DE LA MONTAÑA 12', 234567);
INSERT INTO TRABAJADORES VALUES ('890123', 3500.00, 'LIMPIEZA', 'CAROLINA FERNÁNDEZ', 'PLAZA MAYOR 3', 345678);
INSERT INTO TRABAJADORES VALUES ('901234', 2800.50, 'RECEPCIONISTA', 'MARTÍN GÓMEZ', 'CALLE DEL PARQUE 45', 345678);
INSERT INTO TRABAJADORES VALUES ('012345', 1900.25, 'LIMPIEZA', 'VALERIA ESPÍRITU', 'PASEO DEL RÍO 678', 345678);
INSERT INTO TRABAJADORES VALUES ('123123', 2400.75, 'RECEPCIONISTA', 'DANIEL ÁLVAREZ', 'AVENIDA DE LA PLAYA 90', 345678);
INSERT INTO TRABAJADORES VALUES ('234234', 2700.00, 'LIMPIEZA', 'FERNANDA DÍAZ', 'CALLE DEL BOSQUE 34', 345678);
INSERT INTO TRABAJADORES VALUES ('345345', 2000.50, 'RECEPCIONISTA', 'MIGUEL HERNÁNDEZ', 'PLAZA DEL MERCADO 67', 345678);
INSERT INTO TRABAJADORES VALUES ('456456', 2300.25, 'LIMPIEZA', 'ISABEL VÁZQUEZ', 'PASEO DE LAS FLORES 23', 345678);
INSERT INTO TRABAJADORES VALUES ('567567', 3200.75, 'RECEPCIONISTA', 'ANA TORRES', 'AVENIDA DE LOS CAMPOS', 345678);
INSERT INTO TRABAJADORES VALUES ('678678', 2900.00, 'LIMPIEZA', 'JUAN RUIZ', 'CALLE DE LOS OLIVOS 78', 345678);
GO

SELECT * FROM TRABAJADORES

--INSERTANDO DATOS A LA TABLA AUTOR
INSERT INTO AUTOR VALUES ('0001', 'GABRIEL', 'GARCÍA MÁRQUEZ', 'COLOMBIANA');
INSERT INTO AUTOR VALUES ('0002', 'JORGE', 'BORGES', 'ARGENTINA');
INSERT INTO AUTOR VALUES ('0003', 'JULIO', 'CORTÁZAR', 'ARGENTINA');
INSERT INTO AUTOR VALUES ('0004', 'MARIO', 'VARGAS LLOSA', 'PERUANA');
INSERT INTO AUTOR VALUES ('0005', 'ISABEL', 'ALLENDE', 'CHILENA');
INSERT INTO AUTOR VALUES ('0006', 'PABLO', 'NERUDA', 'CHILENA');
INSERT INTO AUTOR VALUES ('0007', 'GABRIELA', 'MISTRAL', 'CHILENA');
INSERT INTO AUTOR VALUES ('0008', 'MIGUEL', 'DE CERVANTES', 'ESPAÑOLA');
INSERT INTO AUTOR VALUES ('0009', 'FEDERICO', 'GARCÍA LORCA', 'ESPAÑOLA');
INSERT INTO AUTOR VALUES ('0010', 'FRANZ', 'KAFKA', 'AUSTRIACA');
GO

SELECT * FROM AUTOR

--INSERTANDO DATOS EN LA TABLA LIBRO

INSERT INTO LIBRO VALUES ('00001', 'CA01', 'CIEN AÑOS DE SOLEDAD', '2027/06/15', '0001', '234567');
INSERT INTO LIBRO VALUES ('00002', 'CA02', 'EL ALEPH', '2026/03/21', '0002', '234567');
INSERT INTO LIBRO VALUES ('00003', 'CA01', 'RAYUELA', '2028/09/10', '0003', '234567');
INSERT INTO LIBRO VALUES ('00004', 'CA10', 'LA CIUDAD Y LOS PERROS', '2025/11/02', '0004', '345345');
INSERT INTO LIBRO VALUES ('00005', 'CA05', 'CIEN AÑOS DE SOLEDAD', '2029/05/30', '0001', '345345');
INSERT INTO LIBRO VALUES ('00006', 'CA04', 'EL AMOR EN LOS TIEMPOS DEL CÓLERA', '2026/07/18', '0001', '567890');
INSERT INTO LIBRO VALUES ('00007', 'CA08', 'FICCIONES', '2025/08/05', '0002', '567890');
INSERT INTO LIBRO VALUES ('00008', 'CA03', 'PEDRO PÁRAMO', '2030/02/17', '0005', '567890');
INSERT INTO LIBRO VALUES ('00009', 'CA09', 'DON QUIJOTE DE LA MANCHA', '2028/04/23', '0008', '567890');
INSERT INTO LIBRO VALUES ('00010', 'CA02', 'CIEN AÑOS DE SOLEDAD', '2027/10/12', '0001', '567890');
INSERT INTO LIBRO VALUES ('00011', 'CA10', 'EL TÚNEL', '2029/08/30', '0006', '234567');
INSERT INTO LIBRO VALUES ('00012', 'CA07', 'CRÓNICA DE UNA MUERTE ANUNCIADA', '2026/11/17', '0001', '234567');
INSERT INTO LIBRO VALUES ('00013', 'CA07', 'LA CASA DE LOS ESPÍRITUS', '2028/03/05', '0005', '234567');
INSERT INTO LIBRO VALUES ('00014', 'CA03', 'LA INVENCIÓN DE MOREL', '2027/06/28', '0003', '234567');
INSERT INTO LIBRO VALUES ('00015', 'CA01', 'LA GUERRA Y LA PAZ', '2030/01/01', '0004', '234567');
GO

SELECT * FROM LIBRO

--INSERTANDO DATOS A LA TABLA PRESTAMO 
INSERT INTO PRESTAMO VALUES ('0001', '0010', '2022/03/15', '123456');
INSERT INTO PRESTAMO VALUES ('0002', '0007', '2022/04/20', '234567');
INSERT INTO PRESTAMO VALUES ('0003', '0003', '2022/05/10', '345678');
INSERT INTO PRESTAMO VALUES ('0004', '0016', '2022/06/22', '234567');
INSERT INTO PRESTAMO VALUES ('0005', '0001', '2022/07/11', '345678');
INSERT INTO PRESTAMO VALUES ('0006', '0018', '2022/08/05', '234567');
INSERT INTO PRESTAMO VALUES ('0007', '0012', '2022/09/30', '345678');
INSERT INTO PRESTAMO VALUES ('0008', '0009', '2022/10/18', '234567');
INSERT INTO PRESTAMO VALUES ('0009', '0004', '2022/11/29', '345678');
INSERT INTO PRESTAMO VALUES ('0010', '0020', '2022/12/03', '234567');
INSERT INTO PRESTAMO VALUES ('0011', '0014', '2023/01/07', '345678');
INSERT INTO PRESTAMO VALUES ('0012', '0011', '2023/02/15', '234567');
INSERT INTO PRESTAMO VALUES ('0013', '0006', '2023/03/20', '345678');
INSERT INTO PRESTAMO VALUES ('0014', '0013', '2023/04/12', '234567');
INSERT INTO PRESTAMO VALUES ('0015', '0019', '2023/05/25', '345678');
INSERT INTO PRESTAMO VALUES ('0016', '0008', '2023/06/18', '234567');
INSERT INTO PRESTAMO VALUES ('0017', '0015', '2023/07/29', '345678');
INSERT INTO PRESTAMO VALUES ('0018', '0005', '2023/08/13', '234567');
INSERT INTO PRESTAMO VALUES ('0019', '0017', '2023/09/02', '345678');
INSERT INTO PRESTAMO VALUES ('0020', '0002', '2023/10/04', '234567');
INSERT INTO PRESTAMO VALUES ('0021', '0019', '2023/11/21', '345678');
INSERT INTO PRESTAMO VALUES ('0022', '0015', '2023/12/09', '234567');
INSERT INTO PRESTAMO VALUES ('0023', '0002', '2023/01/14', '345678');
INSERT INTO PRESTAMO VALUES ('0024', '0020', '2023/02/28', '234567');
INSERT INTO PRESTAMO VALUES ('0025', '0012', '2023/03/08', '345678');
GO

SELECT * FROM PRESTAMO

--INSERTANDO DATOS A LA TABLA LIBRO_PRESTAMO
INSERT INTO LIBRO_PRESTAMO VALUES ('00005', '0023', '2024/10/15');
INSERT INTO LIBRO_PRESTAMO VALUES ('00002', '0002', '2024/11/20');
INSERT INTO LIBRO_PRESTAMO VALUES ('00003', '0003', '2024/07/10');
INSERT INTO LIBRO_PRESTAMO VALUES ('00004', '0004', '2024/06/22');
INSERT INTO LIBRO_PRESTAMO VALUES ('00005', '0005', '2024/07/11');
INSERT INTO LIBRO_PRESTAMO VALUES ('00006', '0006', '2024/08/05');
INSERT INTO LIBRO_PRESTAMO VALUES ('00007', '0007', '2024/09/30');
INSERT INTO LIBRO_PRESTAMO VALUES ('00008', '0008', '2024/10/18');
INSERT INTO LIBRO_PRESTAMO VALUES ('00009', '0009', '2024/11/29');
INSERT INTO LIBRO_PRESTAMO VALUES ('00010', '0010', '2024/12/03');
INSERT INTO LIBRO_PRESTAMO VALUES ('00011', '0011', '2025/01/07');
INSERT INTO LIBRO_PRESTAMO VALUES ('00012', '0012', '2025/02/15');
INSERT INTO LIBRO_PRESTAMO VALUES ('00013', '0013', '2025/03/20');
INSERT INTO LIBRO_PRESTAMO VALUES ('00014', '0014', '2025/04/12');
INSERT INTO LIBRO_PRESTAMO VALUES ('00015', '0015', '2025/05/25');
INSERT INTO LIBRO_PRESTAMO VALUES ('00016', '0016', '2025/06/18');
INSERT INTO LIBRO_PRESTAMO VALUES ('00017', '0017', '2025/07/29');
INSERT INTO LIBRO_PRESTAMO VALUES ('00018', '0018', '2025/08/13');
INSERT INTO LIBRO_PRESTAMO VALUES ('00019', '0019', '2025/09/02');
INSERT INTO LIBRO_PRESTAMO VALUES ('00020', '0020', '2025/10/04');


SELECT * FROM LIBRO_PRESTAMO

--INSERTANDO DATOS A LA TABLA LIMPIEZA
INSERT INTO LIMPIEZA VALUES ('456789', 'BARRER', 'T');
INSERT INTO LIMPIEZA VALUES ('456789', 'DESEMPOLVAR LOS LIBROS', 'T');
INSERT INTO LIMPIEZA VALUES ('456789', 'ORDENAR LOS LIBROS', 'M');
INSERT INTO LIMPIEZA VALUES ('678901', 'BARRER', 'N');
INSERT INTO LIMPIEZA VALUES ('678901', 'ORDENAR LOS LIBROS', 'M');
INSERT INTO LIMPIEZA VALUES ('678901', 'DESEMPOLVAR LOS LIBROS', 'N');
INSERT INTO LIMPIEZA VALUES ('890123', 'ORDENAR LOS LIBROS', 'M');
INSERT INTO LIMPIEZA VALUES ('012345', 'ORDENAR LOS LIBROS', 'T');
INSERT INTO LIMPIEZA VALUES ('234234', 'DESEMPOLVAR LOS LIBROS', 'T');
INSERT INTO LIMPIEZA VALUES ('678678', 'BARRER', 'N');

SELECT * FROM LIMPIEZA
--INSERTANDO DATOS A LA TABLA RECEPCIONISTA
INSERT INTO RECEPCIONISTA VALUES ('234567', 'recepcionista1@gmail.com', 'WORD')
INSERT INTO RECEPCIONISTA VALUES ('345678', 'recepcionista2@gmail.com', 'EXCEL')
INSERT INTO RECEPCIONISTA VALUES ('567890', 'recepcionista3@gmail.com', 'WORD')
INSERT INTO RECEPCIONISTA VALUES ('789012', 'recepcionista4@gmail.com', 'WORD')
INSERT INTO RECEPCIONISTA VALUES ('901234', 'recepcionista5@gmail.com', 'EXCEL')
INSERT INTO RECEPCIONISTA VALUES ('123123', 'recepcionista6@gmail.com', 'EXCEL')
INSERT INTO RECEPCIONISTA VALUES ('345345', 'recepcionista7@gmail.com', 'WORD')
INSERT INTO RECEPCIONISTA VALUES ('567567', 'recepcionista8@gmail.com', 'EXCEL')
GO

SELECT * FROM RECEPCIONISTA


---------Consultas---------------------------------------Consultas---------------------------------------------------------------------------------------------------Consultas-------------------------Consultas----------------------------------------
---------------------------------Consultas-------------------------------------------------------------------------------------Consultas-------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------Consultas------------------------------------------------Consultas-----------------------------------------------Consultas-------------------------------------------------------------------------------------------------------------
---------Consultas------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------Consultas---------------------------------------------------------------------------------------------Consultas-----------------------------------------------------------------------------------------------------
---------------------------------------------------------Consultas----------------------------------------------------------------------------------------------------------------Consultas--------------------------------------------------

-- CONSULTAS De Daniel

-- INNER JOIN (PRESTAMO - USUARIO)
SELECT *
FROM PRESTAMO;

SELECT *
FROM USUARIO;

SELECT *
FROM PRESTAMO
INNER JOIN USUARIO
ON PRESTAMO.ID_USUARIO = USUARIO.ID_USUARIO


-- INNER JOIN (TRABAJADORES - LIMPIEZA)
SELECT *
FROM TRABAJADORES;

SELECT *
FROM LIMPIEZA;

SELECT *
FROM TRABAJADORES
INNER JOIN LIMPIEZA
ON TRABAJADORES.ID_DNI = LIMPIEZA.ID_DNI


-- INNER JOIN (LIBRO - LIBRO_PRESTAMO)
SELECT *
FROM LIBRO;

SELECT *
FROM LIBRO_PRESTAMO;

SELECT *
FROM LIBRO
INNER JOIN LIBRO_PRESTAMO
ON LIBRO.ID_LIBRO = LIBRO_PRESTAMO.ID_LIBRO


--INNER JOIN (LIBRO_PRESTAMO - PRESTAMO)
SELECT *
FROM LIBRO_PRESTAMO;

SELECT *
FROM PRESTAMO;

SELECT *
FROM LIBRO_PRESTAMO
INNER JOIN PRESTAMO
ON LIBRO_PRESTAMO.ID_PRESTAMO = PRESTAMO.ID_PRESTAMO

--INNER JOIN (LIBRO - AUTOR)
SELECT *
FROM LIBRO;

SELECT *
FROM AUTOR;

SELECT *
FROM LIBRO
INNER JOIN AUTOR
ON LIBRO.ID_AUTOR = AUTOR.ID_AUTOR

--INNER JOIN (LIBRO - CATEGORIA)
SELECT *
FROM LIBRO;

SELECT *
FROM CATEGORIA;

SELECT *
FROM LIBRO
INNER JOIN CATEGORIA
ON LIBRO.ID_CATEGORIA = CATEGORIA.ID_CATEGORIA

-- USANDO PARAMETROS INNER JOIN
--1.
CREATE OR ALTER PROC Consulta_Prestamo_Usuario
    @Parametro1 CHAR(5),
    @Parametro2 CHAR(8)
AS
BEGIN
    -- Consulta para PRESTAMO
    SELECT *
    FROM PRESTAMO
    WHERE ID_USUARIO = @Parametro1
    AND ID_DNI = @Parametro2;

    -- Consulta para USUARIO
    SELECT *
    FROM USUARIO AS USU
    WHERE ID_USUARIO = @Parametro2;

    -- Consulta JOIN
    SELECT *
    FROM PRESTAMO AS PRES
    INNER JOIN USUARIO AS USU ON PRES.ID_USUARIO = USU.ID_USUARIO
    WHERE PRES.ID_USUARIO = @Parametro1
    AND PRES.ID_DNI = @Parametro2;
END
GO

EXEC DBO.Consulta_Prestamo_Usuario @Parametro1 = '0007', @Parametro2 = '0001'
GO

--2. 
CREATE OR ALTER PROC Consulta_Trabajadores_Limpieza
    @Parametro1 CHAR(5),
    @Parametro2 CHAR(8)
AS
BEGIN
    -- Consulta para TRABAJADORES
    SELECT *
    FROM TRABAJADORES AS TRAB
    WHERE TRAB.ID_DNI = @Parametro1;
    

    -- Consulta para LIMPIEZA
    SELECT *
    FROM LIMPIEZA AS LIMP
    WHERE LIMP.ID_DNI = @Parametro2;

    -- Consulta JOIN
    SELECT *
    FROM TRABAJADORES AS TRAB
    INNER JOIN LIMPIEZA AS LIMP ON TRAB.ID_DNI = LIMP.ID_DNI
    WHERE TRAB.ID_DNI = @Parametro1
    AND LIMP.ID_DNI = @Parametro2;
END
GO

EXEC DBO.Consulta_Trabajadores_Limpieza @Parametro1 = '012345' ,@Parametro2 = '012345'
GO

--3.
CREATE OR ALTER PROC Consulta_libro_autor
    @Parametro1 CHAR(5),
    @Parametro2 CHAR(4)
AS
BEGIN
    -- Consulta para LIBRO
    SELECT *
    FROM LIBRO AS LIB
    WHERE LIB.ID_AUTOR  = @Parametro1;
  
    -- Consulta para autor
    SELECT *
    FROM AUTOR AS AUT
    WHERE AUT.ID_AUTOR = @Parametro2;

    -- Consulta JOIN
    SELECT *
    FROM LIBRO AS LIB
    INNER JOIN AUTOR AS AUT ON LIB.ID_AUTOR = AUT.ID_AUTOR
    WHERE LIB.ID_AUTOR = @Parametro1
    AND AUT.ID_AUTOR = @Parametro2;
END
GO

EXEC DBO.Consulta_libro_autor @Parametro1 = '00001', @Parametro2 = '0001'
GO


---------Consultas---------------------------------------Consultas---------------------------------------------------------------------------------------------------Consultas-------------------------Consultas----------------------------------------
---------------------------------Consultas-------------------------------------------------------------------------------------Consultas-------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------Consultas------------------------------------------------Consultas-----------------------------------------------Consultas-------------------------------------------------------------------------------------------------------------
---------Consultas------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------Consultas---------------------------------------------------------------------------------------------Consultas-----------------------------------------------------------------------------------------------------
---------------------------------------------------------Consultas----------------------------------------------------------------------------------------------------------------Consultas--------------------------------------------------

-- CONSULTAS De Michael
CREATE PROCEDURE SP_MostrarCategoriaMasSolicitada
AS
BEGIN
    SELECT TOP 1 CAT.ID_CATEGORIA, COUNT(*) AS TotalPrestamos
    FROM LIBRO_PRESTAMO AS LP
    INNER JOIN LIBRO AS L ON LP.ID_LIBRO = L.ID_LIBRO
    INNER JOIN CATEGORIA AS CAT ON L.ID_CATEGORIA = CAT.ID_CATEGORIA
    GROUP BY CAT.ID_CATEGORIA
    ORDER BY TotalPrestamos DESC;
END;

EXEC SP_MostrarCategoriaMasSolicitada
GO






CREATE PROCEDURE SP_MostrarRecepcionistasConMasDe3Supervisados
AS
BEGIN
    SELECT REC.*
    FROM RECEPCIONISTA AS REC
    INNER JOIN (
        SELECT DNI_SUPERVISOR, COUNT(*) AS NumEmpleados
        FROM TRABAJADORES AS T
        GROUP BY DNI_SUPERVISOR
        HAVING COUNT(*) > 3
    ) T ON REC.ID_DNI = T.DNI_SUPERVISOR;
END;

EXEC SP_MostrarRecepcionistasConMasDe3Supervisados
GO






CREATE PROCEDURE SP_FiltrarRecepcionistasConConocimientoWord
AS
BEGIN
    SELECT REC.*
    FROM RECEPCIONISTA AS REC
    INNER JOIN (
        SELECT DNI_SUPERVISOR
        FROM TRABAJADORES
    ) T ON REC.ID_DNI = T.DNI_SUPERVISOR
    WHERE REC.CONOC_INFORMATICO = 'WORD';
END;

EXEC SP_FiltrarRecepcionistasConConocimientoWord
GO





---------Consultas---------------------------------------Consultas---------------------------------------------------------------------------------------------------Consultas-------------------------Consultas----------------------------------------
---------------------------------Consultas-------------------------------------------------------------------------------------Consultas-------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------Consultas------------------------------------------------Consultas-----------------------------------------------Consultas-------------------------------------------------------------------------------------------------------------
---------Consultas------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------Consultas---------------------------------------------------------------------------------------------Consultas-----------------------------------------------------------------------------------------------------
---------------------------------------------------------Consultas----------------------------------------------------------------------------------------------------------------Consultas--------------------------------------------------

-- CONSULTAS De Trainor

SELECT ID_DNI, HAB_ESPECIFICA, HORARIO
FROM LIMPIEZA;

CREATE VIEW V_LIMPIEZA AS
SELECT ID_DNI, HAB_ESPECIFICA, HORARIO
FROM LIMPIEZA;


SELECT * FROM V_LIMPIEZA

EXEC sp_helptext V_LIMPIEZA; --PROCEDIMIENTO ALMACENADO MUESTRA ORIGEN VISTAS (view)
ALTER VIEW V_LIMPIEZA WITH ENCRYPTION
AS
SELECT ID_DNI, HAB_ESPECIFICA, HORARIO
FROM LIMPIEZA;

---------Consultas---------------------------------------Consultas---------------------------------------------------------------------------------------------------Consultas-------------------------Consultas----------------------------------------
---------------------------------Consultas-------------------------------------------------------------------------------------Consultas-------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------Consultas------------------------------------------------Consultas-----------------------------------------------Consultas-------------------------------------------------------------------------------------------------------------
---------Consultas------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------Consultas---------------------------------------------------------------------------------------------Consultas-----------------------------------------------------------------------------------------------------
---------------------------------------------------------Consultas----------------------------------------------------------------------------------------------------------------Consultas--------------------------------------------------

-- CONSULTAS De Jose EM
select*from AUTOR


CREATE OR ALTER PROC USP_CONSULTA_LIBRO_LANZAMIENTO
   @INICIAL_AUTOR VARCHAR(50),
   @DESDE_AÑO DATE,
   @HASTA_AÑO DATE
AS
BEGIN

SELECT
      li.NOM_LIBRO,
	  AUT.NOM_AUTOR,
	  li.FECH_LANZAMIENTO
FROM LIBRO AS li
INNER JOIN AUTOR AS AUT ON AUT.ID_AUTOR = li.ID_AUTOR
WHERE AUT.NOM_AUTOR LIKE  @INICIAL_AUTOR + '%' 
      AND li.FECH_LANZAMIENTO BETWEEN @DESDE_AÑO AND @HASTA_AÑO

END


EXEC USP_CONSULTA_LIBRO_LANZAMIENTO 'G','2020-05-30', '2029-05-30'





CREATE OR ALTER PROCEDURE USP_CONSULTA_TRABAJADORES
    @NOMBRE VARCHAR(30),
    @PUESTO VARCHAR(20)
AS
BEGIN
    SELECT *
    FROM TRABAJADORES AS T
    WHERE T.NOMBRE LIKE '%' + @NOMBRE + '%'
        AND T.PUESTO = @PUESTO;
END

EXEC USP_CONSULTA_TRABAJADORES 'GARCÍA', 'RECEPCIONISTA';


---------Consultas---------------------------------------Consultas---------------------------------------------------------------------------------------------------Consultas-------------------------Consultas----------------------------------------
---------------------------------Consultas-------------------------------------------------------------------------------------Consultas-------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------Consultas------------------------------------------------Consultas-----------------------------------------------Consultas-------------------------------------------------------------------------------------------------------------
---------Consultas------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------Consultas---------------------------------------------------------------------------------------------Consultas-----------------------------------------------------------------------------------------------------
---------------------------------------------------------Consultas----------------------------------------------------------------------------------------------------------------Consultas--------------------------------------------------

-- CONSULTAS De JOSUE
--INSERTANDO SUBCONSULTAS
SELECT U.ID_USUARIO, LP.ID_LIBRO, LP.ID_PRESTAMO, CONCAT(U.NOM_USUARIO, '', U.APE_USUARIO) AS NOM_USER, P.FECH_PRESTAMO
FROM USUARIO U
INNER JOIN PRESTAMO P ON U.ID_USUARIO = P.ID_USUARIO
INNER JOIN LIBRO_PRESTAMO LP ON P.ID_PRESTAMO = LP.ID_PRESTAMO
WHERE LP.ID_PRESTAMO % 2 = 0
GO
--Uusuarios del 2022 cuyo ID sea al menos igual a uno de los valores devueltos por la subconsulta
SELECT U.ID_USUARIO, NOM_USUARIO, APE_USUARIO, P.FECHA_DEL_PRESTAMO
FROM USUARIO U
INNER JOIN (
	SELECT DISTINCT ID_USUARIO, YEAR(FECH_PRESTAMO) AS FECHA_DEL_PRESTAMO
	FROM PRESTAMO
) P ON U.ID_USUARIO  = P.ID_USUARIO
GO
--Uusuarios que hayan generado al menos un prestamo
SELECT U.ID_USUARIO, CONCAT(U.NOM_USUARIO, '', U.APE_USUARIO) AS NOM_USER
FROM USUARIO U
WHERE EXISTS (
	SELECT *
	FROM PRESTAMO P
	WHERE P.ID_USUARIO = U.ID_USUARIO
)
GO
--Usuarios que no tengan prestamo 
SELECT U.ID_USUARIO, U.NOM_USUARIO, U.APE_USUARIO 
FROM USUARIO U
WHERE EXISTS (
	SELECT *
	FROM PRESTAMO P
	WHERE P.ID_USUARIO = U.ID_USUARIO
 --AND NOT EXISTS (
	SELECT *
	FROM LIBRO_PRESTAMO LP 
	WHERE LP.ID_PRESTAMO = P.ID_PRESTAMO
))
go
--registro de prestamos de cada usuario
SELECT U.ID_USUARIO, U.NOM_USUARIO, U.APE_USUARIO, COUNT(P.ID_PRESTAMO) AS CANTIDAD_DE_PRESTAMOS
FROM USUARIO U
LEFT JOIN PRESTAMO P ON U.ID_USUARIO = P.ID_USUARIO
GROUP BY U.ID_USUARIO, U.NOM_USUARIO, U.APE_USUARIO
GO