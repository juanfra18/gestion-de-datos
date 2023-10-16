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
