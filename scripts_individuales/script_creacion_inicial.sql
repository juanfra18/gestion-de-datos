USE GD2C2023
GO

-- BORRADO DE PROCEDURES/

IF OBJECT_ID('GUISO_DE_LENTEJAS.MIGRAR_TABLA_BARRIO') IS NOT NULL
BEGIN
	DROP PROCEDURE GUISO_DE_LENTEJAS.MIGRAR_TABLA_BARRIO
	PRINT('Procedure GUISO_DE_LENTEJAS.MIGRAR_TABLA_BARRIO eliminado')
END

/*TODO*/
-----------------------------------------------------------------------------------------------------
/*Borrado de FKS de las tablas si existen*/

/*BORRO CONSTRAINS FK A LA TABLA BARRIO*/
IF EXISTS (SELECT * 
    		   FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS 
               WHERE CONSTRAINT_NAME ='FK_BARRIO_LOCALIDAD')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.LOCALIDAD DROP CONSTRAINT FK_BARRIO_LOCALIDAD
END
GO
/*TODO*/
-----------------------------------------------------------------------------------------------------
/*Borrado de tablas*/
IF OBJECT_ID('GUISO_DE_LENTEJAS.BARRIO', 'U') IS NOT NULL
BEGIN
	DROP TABLE GUISO_DE_LENTEJAS.BARRIO
	PRINT('Tabla GUISO_DE_LENTEJAS.BARRIO eliminada')
END
/*TODO*/
-----------------------------------------------------------------------------------------------------
/*BORRADO DE ESQUEMA*/

IF EXISTS (SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'GUISO_DE_LENTEJAS')
BEGIN
   DROP SCHEMA GUISO_DE_LENTEJAS
   PRINT('Esquema GUISO_DE_LENTEJAS borrado')
END
GO

USE GD2C2023
GO
USE GD2C2023
GO
----------------------------------------------------------------------------------------------------------
/*CREACION DE ESQUEMA*/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'GUISO_DE_LENTEJAS')
BEGIN
    EXEC ('CREATE SCHEMA GUISO_DE_LENTEJAS')
	PRINT('Esquema GUISO_DE_LENTEJAS creado')
END
GO
USE GD2C2023
GO  
----------------------------------------------------------------------------------------------------------
/*CREACION DE TABLAS*/

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id= OBJECT_ID(N'[GUISO_DE_LENTEJAS].BARRIO') AND type = 'U')
BEGIN
	CREATE TABLE GUISO_DE_LENTEJAS.BARRIO (
		
        BARRIO_ID decimal(18,0) NOT NULL IDENTITY(1,1),
        BARRIO_NOMBRE nvarchar(?) NOT NULL,
        BARRIO_LOCALIDAD decimal(18,0) NOT NULL, --FK A 
	)
	PRINT('Tabla GUISO_DE_LENTEJAS.BARRIO creada')
END
GO

/*TODO*/USE GD2C2023
GO  
----------------------------------------------------------------------------------------------------------
/*CREANDO CONSTRAINT PK PARA LAS TABLAS DE LA BASE DE DATOS*/

/*AGREGANDO CONSTRAINT PK A LA TABLA BARRIO*/
IF NOT EXISTS (SELECT * 
    		   FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
               WHERE CONSTRAINT_NAME ='PK_BARRIO')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.LOCALIDAD
	ADD CONSTRAINT PK_LOCALIDAD PRIMARY KEY (LOCALIDAD_CODIGO)
	PRINT('Primary key de la tabla GUISO_DE_LENTEJAS.LOCALIDAD agregada')
END
GO

