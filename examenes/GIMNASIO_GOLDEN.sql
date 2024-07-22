USE MASTER
GO

IF DB_ID('GOLDEN_GYMM') IS NOT NULL
	DROP DATABASE GOLDEN_GYMM
GO

CREATE DATABASE GOLDEN_GYMM
GO

USE GOLDEN_GYMM
GO

--CREACION DE LA TABLAS

CREATE TABLE CLIENTE(
  ID_CLIENTE      CHAR(4)      NOT NULL   PRIMARY KEY,
  NOMBRE          VARCHAR(50)  NOT NULL,
  APELLIDO        VARCHAR(60)  NOT NULL,
  DIRECCION       VARCHAR(80)  NOT NULL,
  EMAIL           VARCHAR(80)  NOT NULL,
  TELEFONO        CHAR(9)      NOT NULL,
)
CREATE TABLE MEMBRESIA(
  ID_MEMBRESIA    CHAR(4)      NOT NULL   PRIMARY KEY,
  PRECIO          MONEY        NOT NULL,
  DURACION_MESES    INT        NOT NULL,
  ID_CLIENTE      CHAR(4)      NOT NULL   REFERENCES CLIENTE,

)
CREATE TABLE EMPLEADO(
  ID_EMPLEADP    CHAR(4)      NOT NULL   PRIMARY KEY,
  CARGO          VARCHAR(50)  NOT NULL,
  DIRECCION      VARCHAR(50)  NOT NULL,
  NOMBRE         VARCHAR(50)  NOT NULL,
  GENERO         CHAR(1)      NOT NULL,
  APELLIDO       VARCHAR(50)  NOT NULL,
  TELEFONO       CHAR(9)      NOT NULL,
)

CREATE TABLE CLASEoRUTINA(
  ID_CLASEoRUTINA CHAR(4)      NOT NULL   PRIMARY KEY,
  NOMBRE          VARCHAR(50)  NOT NULL,
  HORARIO         CHAR(1)      NOT NULL,
)
CREATE TABLE CLIENTE_CLASEoRUTINA(
  ID_CLASEoRUTINA    CHAR(4)   NOT NULL      REFERENCES CLASEoRUTINA,
  ID_CLIENTE      CHAR(4)      NOT NULL      REFERENCES CLIENTE,
  DESCRIPCION     VARCHAR(100) NOT NULL   ,
  PRIMARY KEY(ID_CLASEoRUTINA,ID_CLIENTE)
)
CREATE TABLE EQUIPO(
  ID_EQUIPO       CHAR(4)      NOT NULL   PRIMARY KEY,
  NOMBRE          VARCHAR(50)  NOT NULL,
  CANTIDAD        INT          NOT NULL,
  UBICACION       VARCHAR(70)  NOT NULL,
)
CREATE TABLE EQUIPO_CLASEoRUTINA(
  ID_EQUIPO       CHAR(4)      NOT NULL   REFERENCES EQUIPO,
  ID_CLASEoRUTINA CHAR(4)      NOT NULL   REFERENCES CLASEoRUTINA,
  EQUIPO_ESPECF   VARCHAR(50)  NOT NULL,
  PRIMARY KEY(ID_EQUIPO,ID_CLASEoRUTINA)

)
CREATE TABLE RESERVA(
  ID_RESERVA      CHAR(4)      NOT NULL   PRIMARY KEY,
  ID_EQUIPO       CHAR(4)      NOT NULL   REFERENCES EQUIPO,
  ID_CLASEoRUTINA CHAR(4)      NOT NULL   REFERENCES CLASEoRUTINA,
  ID_CLIENTE      CHAR(4)      NOT NULL   REFERENCES CLIENTE,
  FECHA           DATE         NOT NULL,
)
CREATE TABLE ASISTENCIA(
  ID_ASISTENCIA    CHAR(4)     NOT NULL   PRIMARY KEY,
  ID_CLIENTE       CHAR(4)     NOT NULL   REFERENCES CLIENTE,
  FECHA            DATE        NOT NULL,
)
CREATE TABLE FACTURA(
  ID_FACTURA      CHAR(4)      NOT NULL   PRIMARY KEY,
  ID_CLIENTE      CHAR(4)      NOT NULL   REFERENCES CLIENTE,
  ESTADO_PAGO     VARCHAR(20)  NOT NULL,
  MONTO           MONEY        NOT NULL,
  FECHA           DATE         NOT NULL,
)

CREATE TABLE RECEPCIONISTA(
  ID_EMPLEADO     CHAR(4)      NOT NULL   REFERENCES EMPLEADO,
  HAB_TECNICAS    VARCHAR(100) NOT NULL,
  SALARIO         MONEY        NOT NULL,
  PRIMARY KEY(ID_EMPLEADO)
)
CREATE TABLE RECEPCIONISTA_MEMBRESIA(
  ID_EMPLEADO       CHAR(4)      NOT NULL   REFERENCES EMPLEADO,
  ID_MEMBRESIA      CHAR(4)      NOT NULL   REFERENCES MEMBRESIA,
  NOM_RECEPCIONISTA VARCHAR(50)  NOT NULL,
  FECHA_FIN         DATE         NOT NULL,
  PRIMARY KEY(ID_EMPLEADO,ID_MEMBRESIA)

)
CREATE TABLE ENTRENADOR(
  ID_EMPLEADO      CHAR(4)      NOT NULL   REFERENCES EMPLEADO,
  ESPECIALIDAD     VARCHAR(50)  NOT NULL,
  SALARIO          MONEY        NOT NULL,
  PRIMARY KEY(ID_EMPLEADO)
)
CREATE TABLE CLIENTE_ENTRENADOR(
  ID_EMPLEADO    CHAR(4)      NOT NULL   REFERENCES EMPLEADO,
  ID_CLIENTE     CHAR(4)      NOT NULL   REFERENCES CLIENTE,
  HORARIO        VARCHAR(50)  NOT NULL,
  PRIMARY KEY(ID_EMPLEADO,ID_CLIENTE)

)
CREATE TABLE NUTRICIONISTA(
  ID_EMPLEADO    CHAR(4)      NOT NULL   REFERENCES EMPLEADO,
  CERTIF_LICENC  VARCHAR(50)  NOT NULL,
  SALARIO        MONEY        NOT NULL,
  PRIMARY KEY(ID_EMPLEADO)
)
CREATE TABLE SUPLEMENTO(
  ID_SUPLEMENTO  CHAR(4)      NOT NULL   PRIMARY KEY,
  NOMBRE         VARCHAR(50)  NOT NULL,
  SABOR          VARCHAR(50)  NOT NULL,
  DESCRIPCION    VARCHAR(50)  NOT NULL,
  MARCA          VARCHAR(50)  NOT NULL,
  PRECIO         MONEY        NOT NULL,
)
CREATE TABLE SUPLEMENTO_NUTRICIONISTA(
  ID_EMPLEADO        CHAR(4)  NOT NULL   REFERENCES EMPLEADO,
  ID_SUPLEMENTO      CHAR(4)  NOT NULL   REFERENCES SUPLEMENTO,
  CANT_RECOMENDADA_G DECIMAL  NOT NULL,
  FECH_RECOMENDADO   DATE     NOT NULL,
  PRIMARY KEY(ID_EMPLEADO,ID_SUPLEMENTO)
)
CREATE TABLE LIMPIEZA(
  ID_EMPLEADO        CHAR(4)      NOT NULL   REFERENCES EMPLEADO,
  ZONA_LIMPIEZA      VARCHAR(50)  NOT NULL,
  REFERENCIA_LABORAL VARCHAR(50)  NOT NULL,
  SALARIO            MONEY        NOT NULL,
  PRIMARY KEY(ID_EMPLEADO)
)






--RESTRICCIONES ASISTENCIA

--RESTRICCIONES CLASEoRUTINA
  ALTER TABLE CLASEoRUTINA ADD CHECK(ID_CLASEoRUTINA LIKE 'A[0-9][0-9][0-9]')
  ALTER TABLE CLASEoRUTINA ADD CHECK (HORARIO IN('M','T','N'))

--RESTRICCIONES CLIENTE
  ALTER TABLE CLIENTE ADD CHECK(ID_CLIENTE LIKE 'C[0-9][0-9][0-9]')
  ALTER TABLE CLIENTE ADD DEFAULT 'NO REGISTRA' FOR DIRECCION
  ALTER TABLE CLIENTE ADD DEFAULT 'NO TIENE EMAIL' FOR EMAIL
  ALTER TABLE CLIENTE ADD DEFAULT '000000000' FOR TELEFONO


--RESTRICCIONES CLIENTE_CLASEoRUTINA
  ALTER TABLE CLIENTE_CLASEoRUTINA ADD DEFAULT 'NO REGISTRA' FOR DESCRIPCION

--RESTRICCIONES CLIENTE_ENTRENADOR
  ALTER TABLE CLIENTE_ENTRENADOR ADD CHECK(HORARIO IN('M','T','N'))


--RESTRICCIONES EMPLEADO
  ALTER TABLE EMPLEADO ADD CHECK(CARGO IN('LIMPIEZA','RECEPCIONISTA','ENTRENADOR','NUTRICIONISTA'))
  ALTER TABLE EMPLEADO ADD DEFAULT 'NO REGISTRA' FOR DIRECCION
  ALTER TABLE EMPLEADO ADD CHECK(GENERO IN('M','F','O'))
  ALTER TABLE EMPLEADO ADD DEFAULT '000000000' FOR TELEFONO

--RESTRICCIONES ENTRENADOR
  ALTER TABLE ENTRENADOR ADD CHECK(ESPECIALIDAD IN('POWERLIFF','CARDIO','MUJERES','CROSFIT','CALISTENIA'))
  ALTER TABLE ENTRENADOR ADD CHECK(SALARIO >1200)


--RESTRICCIONES EQUIPO
  ALTER TABLE EQUIPO ADD CHECK(UBICACION IN ('SJL','BAYOBAR','SANTA ANITA','CENTRO LIMA'))

--RESTRICCIONES EQUIPO_CLASEoRUTINA
  ALTER TABLE EQUIPO_CLASEoRUTINA ADD CHECK(EQUIPO_ESPECF IN ('MANCUERNA','MAQUINA','CORREDORA','BANCA','JAULA'))


--RESTRICCIONES FACTURA
  ALTER TABLE FACTURA ADD CHECK(ESTADO_PAGO IN ('ATRASADO','ALDIA','PENDIENTE'))
  ALTER TABLE FACTURA ADD CHECK(FECHA<GETDATE())

--RESTRICCIONES LIMPIEZA
  ALTER TABLE LIMPIEZA ADD DEFAULT 'TODA LA SEDE' FOR ZONA_LIMPIEZA
  ALTER TABLE LIMPIEZA ADD CHECK(REFERENCIA_LABORAL IN ('SP','NP'))
  ALTER TABLE LIMPIEZA ADD CHECK(SALARIO>1025)

--RESTRICCIONES MEMBRESIA
  ALTER TABLE MEMBRESIA ADD CHECK (PRECIO>=150)
  
--RESTRICCIONES NUTRICIONISTA
  ALTER TABLE NUTRICIONISTA ADD DEFAULT 'NO REGISTRA' FOR CERTIF_LICENC
  ALTER TABLE NUTRICIONISTA ADD CHECK (SALARIO>=2000)


--RESTRICCIONES RECEPCIONISTA
  ALTER TABLE RECEPCIONISTA ADD CHECK(HAB_TECNICAS IN ('WORD','EXCEL','BD'))
  ALTER TABLE RECEPCIONISTA ADD CHECK (SALARIO>=1700)

--RESTRICCIONES RECEPCIONISTA_MEMBRESIA
  ALTER TABLE RECEPCIONISTA_MEMBRESIA ADD DEFAULT 'NO REGISTRA' FOR NOM_RECEPCIONISTA


--RESTRICCIONES RESERVA
  ALTER TABLE RESERVA ADD CHECK(FECHA>=GETDATE())

--RESTRICCIONES SUPLEMENTO
  ALTER TABLE SUPLEMENTO ADD CHECK(SABOR IN ('CHOCOLATE','VAINILLA','FRESA'))
  ALTER TABLE SUPLEMENTO ADD DEFAULT 'NO REGISTRA' FOR DESCRIPCION
  ALTER TABLE SUPLEMENTO ADD CHECK(MARCA IN ('UN','RONIKOLEMAN','UM'))


--RESTRICCIONES SUPLEMENTO_NUTRICIONISTA
  ALTER TABLE SUPLEMENTO_NUTRICIONISTA ADD CHECK(FECH_RECOMENDADO<=GETDATE())


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------INSERCIONES DE DATOS DE LAS TABLAS----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



SELECT*FROM CLIENTE
--INSERCION DE DATOS EN LA TABLA CLIENTE
INSERT INTO CLIENTE VALUES ('C001','Celeste Martínez','ESPINIZA MORALES','LIMA','EMAIL1@GMAIL.COM','912345678')
INSERT INTO CLIENTE VALUES ('C002','Sofía Mendoza','Facundo Silva','LIMA','EMAIL1@GMAIL.COM','912345678')
INSERT INTO CLIENTE VALUES ('C003','Mateo González','García','LIMA','EMAIL2@GMAIL.COM','912345672')
INSERT INTO CLIENTE VALUES ('C004','Camila Ríos','Rodríguez','LIMA','EMAIL3@GMAIL.COM','912345673')
INSERT INTO CLIENTE VALUES ('C005','Santiago López','López','LIMA','EMAIL4@GMAIL.COM','912345674')
INSERT INTO CLIENTE VALUES ('C006','Valentina Ortiz','Ramírez','LIMA','EMAIL5@GMAIL.COM','912345676')
INSERT INTO CLIENTE VALUES ('C007','Emilio Castro','Ramírez','LIMA','EMAIL6@GMAIL.COM','912345677')
INSERT INTO CLIENTE VALUES ('C008','Luciana Álvarez','Gómez','LIMA','EMAIL7@GMAIL.COM','912345671')
--INSERCION DE DATOS EN LA TABLA ASISTENCIA
INSERT INTO ASISTENCIA VALUES ('0331','C002','2024/12/22')
INSERT INTO ASISTENCIA VALUES ('0332','C002','2020/02/29')
INSERT INTO ASISTENCIA VALUES ('0333','C007','2023/11/27')
INSERT INTO ASISTENCIA VALUES ('0334','C007','2020/10/25')
INSERT INTO ASISTENCIA VALUES ('0335','C001','2020/03/21')
INSERT INTO ASISTENCIA VALUES ('0336','C002','2021/04/23')
INSERT INTO ASISTENCIA VALUES ('0337','C003','2012/10/22')
INSERT INTO ASISTENCIA VALUES ('0388','C005','2014/12/12')
--INSERCION DE DATOS EN LA TABLA CLASEoRUTINA
INSERT INTO CLASEoRUTINA VALUES ('A001','Serena Castillo','M')
INSERT INTO CLASEoRUTINA VALUES ('A002','Maxián Galván','T')
INSERT INTO CLASEoRUTINA VALUES ('A003','Valeria Montes','N')
INSERT INTO CLASEoRUTINA VALUES ('A004','Hugo Ramírez','M')
INSERT INTO CLASEoRUTINA VALUES ('A005','Celeste Martínez','N')
INSERT INTO CLASEoRUTINA VALUES ('A006','Damián Sánchez','M')
INSERT INTO CLASEoRUTINA VALUES ('A007','Mariana Flores','M')
INSERT INTO CLASEoRUTINA VALUES ('A008','Gael Salazar','N')
INSERT INTO CLASEoRUTINA VALUES ('A009','Abril Torres','M')
INSERT INTO CLASEoRUTINA VALUES ('A010','Lucas Herrera','T')

SELECT*FROM CLIENTE_CLASEoRUTINA
--INSERCION DE DATOS EN LA TABLA CLIENTE_CLASEoRUTINA
INSERT INTO CLIENTE_CLASEoRUTINA VALUES ('A001','C001',DEFAULT)
INSERT INTO CLIENTE_CLASEoRUTINA VALUES ('A002','C002',DEFAULT)
INSERT INTO CLIENTE_CLASEoRUTINA VALUES ('A003','C003',DEFAULT)
INSERT INTO CLIENTE_CLASEoRUTINA VALUES ('A004','C004',DEFAULT)
INSERT INTO CLIENTE_CLASEoRUTINA VALUES ('A003','C005',DEFAULT)
INSERT INTO CLIENTE_CLASEoRUTINA VALUES ('A002','C006',DEFAULT)
INSERT INTO CLIENTE_CLASEoRUTINA VALUES ('A001','C007',DEFAULT)

SELECT*FROM CLIENTE_ENTRENADOR
--INSERCION DE DATOS EN LA TABLA CLIENTE_ENTRENADOR
INSERT INTO CLIENTE_ENTRENADOR VALUES ('1231','C001','M')
INSERT INTO CLIENTE_ENTRENADOR VALUES ('1232','C002','T')
INSERT INTO CLIENTE_ENTRENADOR VALUES ('1233','C003','M')
INSERT INTO CLIENTE_ENTRENADOR VALUES ('1234','C004','M')
INSERT INTO CLIENTE_ENTRENADOR VALUES ('1235','C005','M')
INSERT INTO CLIENTE_ENTRENADOR VALUES ('1236','C006','T')
INSERT INTO CLIENTE_ENTRENADOR VALUES ('1237','C007','N')
INSERT INTO CLIENTE_ENTRENADOR VALUES ('1238','C008','T')

--INSERCION DE DATOS EN LA TABLA EMPLEADO
INSERT INTO EMPLEADO VALUES ('1231','ENTRENADOR','DIRECCION1','Santiago López','O','Gómez',912345678)
INSERT INTO EMPLEADO VALUES ('1232','NUTRICIONISTA','DIRECCION2','Sofía Mendoza','O','Sánchez',DEFAULT)
INSERT INTO EMPLEADO VALUES ('1233','NUTRICIONISTA','DIRECCION3','Lucas Herrera','O','Gómez',912345678)
INSERT INTO EMPLEADO VALUES ('1234','LIMPIEZA','DIRECCION2','Celeste Martínez','O','Moreno',DEFAULT)
INSERT INTO EMPLEADO VALUES ('1235','NUTRICIONISTA','DIRECCION4','Santiago López','O','Torres',912345678)
INSERT INTO EMPLEADO VALUES ('1236','LIMPIEZA','DIRECCION2','Santiago López','O','García',DEFAULT)
INSERT INTO EMPLEADO VALUES ('1237','NUTRICIONISTA','DIRECCION5','Gael Salazar','O','Romero',DEFAULT)
INSERT INTO EMPLEADO VALUES ('1238','ENTRENADOR','DIRECCION6','Lucas Herrera','O','Gómez',912345678)

--INSERCION DE DATOS EN LA TABLA ENTRENADOR
INSERT INTO ENTRENADOR VALUES ('1231','MUJERES','1300')
INSERT INTO ENTRENADOR VALUES ('1232','CALISTENIA','1500')
INSERT INTO ENTRENADOR VALUES ('1233','CROSFIT','1300')
INSERT INTO ENTRENADOR VALUES ('1234','CALISTENIA','1700')
INSERT INTO ENTRENADOR VALUES ('1235','CALISTENIA','1300')
INSERT INTO ENTRENADOR VALUES ('1236','MUJERES','1300')
INSERT INTO ENTRENADOR VALUES ('1237','CARDIO','12200')
INSERT INTO ENTRENADOR VALUES ('1238','CARDIO','1300')

--INSERCION DE DATOS EN LA TABLA EQUIPO
INSERT INTO EQUIPO VALUES ('1111','Lucas','12','CENTRO LIMA')
INSERT INTO EQUIPO VALUES ('1112','Valencia','1','SANTA ANITA')
INSERT INTO EQUIPO VALUES ('1113','Benítez','22','BAYOBAR')
INSERT INTO EQUIPO VALUES ('1114','Emilio ','2','SJL')
INSERT INTO EQUIPO VALUES ('1115','Facundo ','11','BAYOBAR')
INSERT INTO EQUIPO VALUES ('1116','Álvarez','15','BAYOBAR')

--INSERCION DE DATOS EN LA TABLA EQUIPO_CLASEoRUTINA
INSERT INTO EQUIPO_CLASEoRUTINA VALUES ('1111','A001 ','JAULA')
INSERT INTO EQUIPO_CLASEoRUTINA VALUES ('1112','A002 ','JAULA')
INSERT INTO EQUIPO_CLASEoRUTINA VALUES ('1113','A003 ','CORREDORA')
INSERT INTO EQUIPO_CLASEoRUTINA VALUES ('1114','A004 ','MAQUINA')
INSERT INTO EQUIPO_CLASEoRUTINA VALUES ('1115','A005 ','MAQUINA')
INSERT INTO EQUIPO_CLASEoRUTINA VALUES ('1116','A006 ','MANCUERNA')

--INSERCION DE DATOS EN LA TABLA FACTURA
INSERT INTO FACTURA VALUES ('F111','C001','ATRASADO',140,'2023-12-12')
INSERT INTO FACTURA VALUES ('F112','C002','PENDIENTE',120,'2023-11-12')
INSERT INTO FACTURA VALUES ('F113','C003','ATRASADO',110,'2023-12-11')
INSERT INTO FACTURA VALUES ('F114','C004','PENDIENTE',1110,'2023-12-17')
INSERT INTO FACTURA VALUES ('F115','C005','ALDIA',190,'2023-10-12')
INSERT INTO FACTURA VALUES ('F116','C006','ALDIA',148,'2023-09-12')
INSERT INTO FACTURA VALUES ('F117','C007','ATRASADO',150,'2023-12-23')
INSERT INTO FACTURA VALUES ('F118','C008','PENDIENTE',140,'2023-12-13')

--INSERCION DE DATOS EN LA TABLA LIMPIEZA
INSERT INTO LIMPIEZA VALUES ('1231',DEFAULT,'NP',1400)
INSERT INTO LIMPIEZA VALUES ('1232',DEFAULT,'NP',1200)
INSERT INTO LIMPIEZA VALUES ('1233',DEFAULT,'SP',14300)
INSERT INTO LIMPIEZA VALUES ('1234',DEFAULT,'NP',1300)
INSERT INTO LIMPIEZA VALUES ('1235',DEFAULT,'SP',1550)
INSERT INTO LIMPIEZA VALUES ('1236',DEFAULT,'NP',1340)
INSERT INTO LIMPIEZA VALUES ('1237',DEFAULT,'SP',14230)

--INSERCION DE DATOS EN LA TABLA NUTRICIONISTA
INSERT INTO NUTRICIONISTA VALUES ('1231','CERTIFICADO DE UTP','3000')
INSERT INTO NUTRICIONISTA VALUES ('1232','CERTIFICADO DE CIBERTEC','3120')
INSERT INTO NUTRICIONISTA VALUES ('1233',DEFAULT,'6000')
INSERT INTO NUTRICIONISTA VALUES ('1234','CERTIFICADO DE UTP','3200')
INSERT INTO NUTRICIONISTA VALUES ('1235','CERTIFICADO DE UPN','3000')
INSERT INTO NUTRICIONISTA VALUES ('1236','CERTIFICADO DE UTP','3332')

--INSERCION DE DATOS EN LA TABLA RECEPCIONISTA
INSERT INTO RECEPCIONISTA VALUES ('1231','EXCEL','2333')
INSERT INTO RECEPCIONISTA VALUES ('1232','WORD','2253')
INSERT INTO RECEPCIONISTA VALUES ('1233','EXCEL','2323')
INSERT INTO RECEPCIONISTA VALUES ('1234','BD','4333')
INSERT INTO RECEPCIONISTA VALUES ('1235','EXCEL','2333')
INSERT INTO RECEPCIONISTA VALUES ('1236','BD','2873')
INSERT INTO RECEPCIONISTA VALUES ('1237','WORD','2333')
 
--INSERCION DE DATOS EN LA TABLA MEMBRESIA
INSERT INTO MEMBRESIA VALUES ('0001','210','2','C001')
INSERT INTO MEMBRESIA VALUES ('0002','310','1','C002')
INSERT INTO MEMBRESIA VALUES ('0003','410','3','C003')
INSERT INTO MEMBRESIA VALUES ('0004','250','2','C004')
INSERT INTO MEMBRESIA VALUES ('0005','220','2','C005')
INSERT INTO MEMBRESIA VALUES ('0006','230','1','C006')
--INSERCION DE DATOS EN LA TABLA RECEPCIONISTA_MEMBRESIA
INSERT INTO RECEPCIONISTA_MEMBRESIA VALUES ('1231','0001','Reyes','2024-12-01')
INSERT INTO RECEPCIONISTA_MEMBRESIA VALUES ('1232','0002','Espinoza','2024-12-01')
INSERT INTO RECEPCIONISTA_MEMBRESIA VALUES ('1233','0003','Torres','2024-12-01')
INSERT INTO RECEPCIONISTA_MEMBRESIA VALUES ('1234','0002','Vázquez','2024-12-01')
INSERT INTO RECEPCIONISTA_MEMBRESIA VALUES ('1235','0005','Vázquez','2024-12-01')
INSERT INTO RECEPCIONISTA_MEMBRESIA VALUES ('1236','0002','Morales','2024-12-01')
INSERT INTO RECEPCIONISTA_MEMBRESIA VALUES ('1237','0005','Jiménez','2024-12-01')
INSERT INTO RECEPCIONISTA_MEMBRESIA VALUES ('1238','0002','Morales','2024-12-01')

--INSERCION DE DATOS EN LA TABLA RESERVA
INSERT INTO RESERVA VALUES ('M121','1111','A001','C001','2024-12-14')
INSERT INTO RESERVA VALUES ('M122','1112','A002','C002','2024-10-14')
INSERT INTO RESERVA VALUES ('M123','1113','A003','C003','2024-11-14')
INSERT INTO RESERVA VALUES ('M124','1114','A004','C002','2024-12-25')
INSERT INTO RESERVA VALUES ('M125','1115','A005','C005','2024-02-26')
INSERT INTO RESERVA VALUES ('M126','1116','A006','C006','2024-03-27')
INSERT INTO RESERVA VALUES ('M127','1117','A004','C002','2024-12-14')

--INSERCION DE DATOS EN LA TABLA SUPLEMENTO
INSERT INTO SUPLEMENTO VALUES ('2221','Álvarez','CHOCOLATE',DEFAULT,'UN','111')
INSERT INTO SUPLEMENTO VALUES ('2222','Camila ','CHOCOLATE',DEFAULT,'UM','1')
INSERT INTO SUPLEMENTO VALUES ('2223','López','CHOCOLATE',DEFAULT,'RONIKOLEMAN','1')
INSERT INTO SUPLEMENTO VALUES ('2224','López','FRESA',DEFAULT,'UN','2')
INSERT INTO SUPLEMENTO VALUES ('2225','Álvarez','CHOCOLATE',DEFAULT,'RONIKOLEMAN',' 1')
INSERT INTO SUPLEMENTO VALUES ('2226','Emilio ','VAINILLA',DEFAULT,'UM','3')
INSERT INTO SUPLEMENTO VALUES ('2227','Facundo ','FRESA',DEFAULT,'RONIKOLEMAN','2')
INSERT INTO SUPLEMENTO VALUES ('2228','Emilio ','VAINILLA',DEFAULT,'UN','4')
SELECT*FROM SUPLEMENTO

--INSERCION DE DATOS EN LA TABLA SUPLEMENTO_NUTRICIONISTA
INSERT INTO SUPLEMENTO_NUTRICIONISTA VALUES ('1231','2221 ',1.12,'2023-05-12')
INSERT INTO SUPLEMENTO_NUTRICIONISTA VALUES ('1232','2222 ',2.12,'2022-11-12')
INSERT INTO SUPLEMENTO_NUTRICIONISTA VALUES ('1233','2223 ',1.12,'2021-05-12')
INSERT INTO SUPLEMENTO_NUTRICIONISTA VALUES ('1234','2224 ',3.12,'2023-05-12')
INSERT INTO SUPLEMENTO_NUTRICIONISTA VALUES ('1235','2225 ',1.12,'2022-10-27')
INSERT INTO SUPLEMENTO_NUTRICIONISTA VALUES ('1236','2226 ',2.12,'2023-05-25')
INSERT INTO SUPLEMENTO_NUTRICIONISTA VALUES ('1237','2227 ',1.12,'2022-02-12')
INSERT INTO SUPLEMENTO_NUTRICIONISTA VALUES ('1238','2228 ',1.12,'2023-03-11')

--EN LA CONSULTA LLAMA A LOS DATOS NOMBRE APELLIDO ,DURACION DEL MES , Y PRECIO QUE PAGO, EN ESTE PROCEDIMIENTO ALMACENADO TENEMOS EL PARAMETRO ID_CLIENTE QUE NOS HACE REFERENCIA
--A UN PARAMETRO QUE INGRESARA CUANDO HAGA LLAMADO AL PROCEDURE ESTO HACE QUE SEA FUNCIONAL EL PROCEDURE Y NOS PERMITA SAVER EL VALOR DE LOS DATOS DEL CLIENTE ESPECIFICO Y 
--LA CONSULTA SEA MAS EFICAZ Y CONSIZA.
SELECT*FROM CLIENTE

--CREATE OR ALTER PROCEDURE USP_CONSULTA_MENSUALIDAD_PRECIO_CLIENTE
--   @PARAMETRO1 INT,
--   @PARAMETRO2 INT,
--   @ID_CLIENTE CHAR(4)

--AS
--BEGIN

--SELECT
--  MEM.ID_CLIENTE AS ID_CLIENTE,
--  CL.NOMBRE AS NOMBRE_CL,
--  CL.APELLIDO  AS APELLIDO_CL,
--  MEM.DURACION_MESES  AS DURACION,
--  MEM.PRECIO AS PRECIO_PAGADO
--from MEMBRESIA as MEM
--   INNER JOIN CLIENTE AS CL ON CL.ID_CLIENTE=MEM.ID_CLIENTE
--WHERE MEM.DURACION_MESES BETWEEN @PARAMETRO1 AND @PARAMETRO2
--   AND CL.ID_CLIENTE=@ID_CLIENTE
--END

--EXECUTE USP_CONSULTA_MENSUALIDAD_PRECIO_CLIENTE  1, 4,'C005'
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select*from NUTRICIONISTA

--SELECT
--   MAX(ENT.SALARIO) AS MAXIMO_ENTRENADOR,
--   MAX(NUT.SALARIO) AS MAXIMO_NUTRICIONISTA,
--   MAX(REC.SALARIO)AS MAXIMO_RECEPCIONISTA,
--   MAX(LIM.SALARIO)AS MAXIMO_LIMPIEZA,
--   CASE
--      WHEN MAX(ENT.SALARIO) >= MAX(NUT.SALARIO) AND
--           MAX(ENT.SALARIO) >= MAX(REC.SALARIO) AND
--           MAX(ENT.SALARIO) >= MAX(LIM.SALARIO) THEN 'Entrenador'
--      WHEN MAX(NUT.SALARIO) >= MAX(ENT.SALARIO) AND
--           MAX(NUT.SALARIO) >= MAX(REC.SALARIO) AND
--           MAX(NUT.SALARIO) >= MAX(LIM.SALARIO) THEN 'Nutricionista'
--      WHEN MAX(REC.SALARIO) >= MAX(ENT.SALARIO) AND
--           MAX(REC.SALARIO) >= MAX(NUT.SALARIO) AND
--           MAX(REC.SALARIO) >= MAX(LIM.SALARIO) THEN 'Recepcionista'
--      ELSE 'Limpieza'
--   END AS EMPLEADO_CON_MAXIMO_SALARIO
--FROM EMPLEADO AS EMP
--INNER JOIN ENTRENADOR AS ENT ON ENT.ID_EMPLEADO=EMP.ID_EMPLEADP
--INNER JOIN NUTRICIONISTA AS NUT ON NUT.ID_EMPLEADO=EMP.ID_EMPLEADP
--INNER JOIN RECEPCIONISTA AS REC ON REC.ID_EMPLEADO=EMP.ID_EMPLEADP
--INNER JOIN LIMPIEZA AS LIM ON LIM.ID_EMPLEADO=EMP.ID_EMPLEADP
--GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select*from FACTURA

--CREATE OR ALTER PROC USP_CONSULTA_ESTADO_ECONOMICO_CLIENTE
--  @ID_CLIENTE CHAR(4),
--  @MONTO MONEY
--AS
--BEGIN

--SELECT
--   CL.NOMBRE+''+CL.APELLIDO AS CLIENTE,
--   FAC.MONTO,
--   FAC.ESTADO_PAGO,
--   DAY(FAC.FECHA) AS 'DIA INSCRIPCION',
--   MONTH(FAC.FECHA)AS 'MES INSCRIPCION',
--   YEAR(FAC.FECHA)AS 'AÑO INSCRIPCION'
--FROM FACTURA AS FAC
--  INNER JOIN CLIENTE AS CL ON FAC.ID_CLIENTE=CL.ID_CLIENTE
--  WHERE CL.ID_CLIENTE=@ID_CLIENTE AND
--  FAC.MONTO>=@MONTO

--END

--EXEC USP_CONSULTA_ESTADO_ECONOMICO_CLIENTE 'C004',1000

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----PARA SABER EL MAYOR Y MENOR MONTO
--select*from FACTURA

--SELECT 
--    (SELECT TOP 1 FAC.ID_CLIENTE 
--    FROM FACTURA AS FAC 
--    ORDER BY FAC.MONTO DESC) AS ID_CLIENTE_CON_MAX_MONTO,
--   MAX(FAC.MONTO) AS MAX_MONTO,
--   (SELECT TOP 1 FAC.ID_CLIENTE 
--    FROM FACTURA AS FAC 
--    ORDER BY FAC.MONTO ASC) AS ID_CLIENTE_CON_MAX_MONTO,
--   MIN(FAC.MONTO) AS MIN_MONTO,
--   AVG(FAC.MONTO) AS PROMEDIO_MONTO
--FROM FACTURA AS FAC;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----SUBCONSULTA DENTRO DE UN PROCEDURE
--select*from RESERVA

--CREATE PROC USP_CONSULTA_EQUIPO_RESERVA
--@ID_EQUIPO CHAR(4)
--AS
--BEGIN
--SELECT DISTINCT C.NOMBRE, C.APELLIDO
--FROM CLIENTE AS C
--WHERE C.ID_CLIENTE IN (
--    SELECT R.ID_CLIENTE
--    FROM RESERVA AS R
--    WHERE R.ID_EQUIPO =@ID_EQUIPO
--)
--END

--EXEC USP_CONSULTA_EQUIPO_RESERVA '1111'


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--SELECT*FROM EQUIPO

--SELECT 
--    E.NOMBRE AS Nombre_Equipo,
--    COUNT(DISTINCT R.ID_CLIENTE) AS Total_Clientes_Reservaron,
--    SUM(E.CANTIDAD) AS Total_Repuestos_En_Inventario
--FROM 
--    EQUIPO AS E
--INNER JOIN 
--    RESERVA AS R ON E.ID_EQUIPO = R.ID_EQUIPO
--INNER JOIN 
--    CLIENTE_CLASEoRUTINA AS CCR ON R.ID_CLIENTE = CCR.ID_CLIENTE
--INNER JOIN 
--    EQUIPO_CLASEoRUTINA AS ECR ON E.ID_EQUIPO = ECR.ID_EQUIPO
--GROUP BY 
--    E.NOMBRE;




-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--SELECT*FROM CLIENTE

--CREATE OR ALTER PROCEDURE BuscarClientePorNombre
--    @Nombre VARCHAR(50),
--    @Apellido VARCHAR(60)
--AS
--BEGIN
--    SELECT C.* 
--    FROM CLIENTE AS C
--    INNER JOIN CLIENTE_ENTRENADOR AS CE ON C.ID_CLIENTE = CE.ID_CLIENTE
--    WHERE C.NOMBRE LIKE '%'+@Nombre+'%' AND C.APELLIDO = '%'+@Apellido+'%';
--END
--GO
--EXEC BuscarClientePorNombre 'Celeste Martínez','ESPINIZA MORALES'
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--SELECT*FROM EMPLEADO

--CREATE OR ALTER PROCEDURE INSERCION_DATOS
--    @ID_EMPLEADO CHAR(4),
--    @CARGO VARCHAR(50),
--    @DIRECCION VARCHAR(50),
--    @NOMBRE VARCHAR(50),
--    @GENERO CHAR(1),
--    @APELLIDO VARCHAR(50),
--    @TELEFONO CHAR(9)
--AS
--BEGIN
--    INSERT INTO EMPLEADO (ID_EMPLEADP, CARGO, DIRECCION, NOMBRE, GENERO, APELLIDO, TELEFONO)
--    VALUES (@ID_EMPLEADO, @CARGO, @DIRECCION, @NOMBRE, @GENERO, @APELLIDO, @TELEFONO);
--END
   

--EXEC INSERCION_DATOS '1279','ENTRENADOR','DIRECCION7','Lucas Herrer','M','Góme',912341111

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--SELECT*FROM ENTRENADOR

--CREATE OR ALTER PROCEDURE ACTUALIZAR_SALARIO_EMPLEADOS
--  @PORCENTAJE_ENTRENADOR MONEY,
--  @PORCENTAJE_NUTRICIONISTA MONEY,
--  @PORCENTAJE_RECEPCIONISTA MONEY,
--  @PORCENTAJE_LIMPIEZA MONEY
--AS 
--BEGIN
--  -- Actualizar salario de los entrenadores
--  UPDATE ENTRENADOR
--  SET SALARIO = SALARIO * @PORCENTAJE_ENTRENADOR; -- Aumento del 10% para los entrenadores

--  -- Actualizar salario de los nutricionistas
--  UPDATE NUTRICIONISTA
--  SET SALARIO = SALARIO * @PORCENTAJE_NUTRICIONISTA; -- Aumento del 5% para los nutricionistas

--  -- Actualizar salario de los recepcionistas
--  UPDATE RECEPCIONISTA
--  SET SALARIO = SALARIO * @PORCENTAJE_RECEPCIONISTA; -- Aumento del 3% para los recepcionistas

--  -- Actualizar salario del personal de limpieza
--  UPDATE LIMPIEZA
--  SET SALARIO = SALARIO * @PORCENTAJE_LIMPIEZA; -- Aumento del 2% para el personal de limpieza
--END;

--EXEC ACTUALIZAR_SALARIO_EMPLEADOS 1.3,1.2,1.5,1.6

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select *from RESERVA 

--CREATE OR ALTER PROC ELIMINAR_UN_CAMPO_ESPEFICO_TABLA
--   @ID_RESERVA CHAR(4), 
--   @FECHA DATE
--AS
--BEGIN
--	   DELETE FROM RESERVA 
--       WHERE ID_RESERVA=@ID_RESERVA  AND @FECHA<GETDATE()-- LA FECHA INGRESADA DEBE SER MENOR AL DIA ACTUAL

--END

--EXEC ELIMINAR_UN_CAMPO_ESPEFICO_TABLA 'M121','2020-12-14'


---- Primera vista
--CREATE VIEW Vista1 AS
--SELECT ID_CLIENTE, NOMBRE, APELLIDO
--FROM CLIENTE;


---- Segunda vista
--CREATE VIEW Vista2 AS
--SELECT ID_MEMBRESIA, PRECIO, DURACION_MESES
--FROM MEMBRESIA;

---- Tercera vista
--CREATE VIEW Vista3 AS
--SELECT ID_EMPLEADO, CARGO, NOMBRE, APELLIDO
--FROM EMPLEADO;

--SELECT *
--FROM Vista2;