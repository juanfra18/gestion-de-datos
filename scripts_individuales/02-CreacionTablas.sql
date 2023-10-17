USE GD2C2023
GO  
----------------------------------------------------------------------------------------------------------
/*CREACION DE TABLAS*/

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id= OBJECT_ID(N'[GUISO_DE_LENTEJAS].TIPO_INMUEBLE') AND type = 'U')
BEGIN
	CREATE TABLE GUISO_DE_LENTEJAS.TIPO_INMUEBLE (
		
        TIPO_INMUEBLE_ID decimal(18,0) NOT NULL IDENTITY(1,1),
        TIPO_INMUEBLE_DESCRIPCION nvarchar(100) NOT NULL,
	)
	PRINT('Tabla GUISO_DE_LENTEJAS.TIPO_INMUEBLE creada')
END
GO

/*
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
*/
/*TODO*/