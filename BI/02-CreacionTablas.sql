IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id= OBJECT_ID(N'[GUISO_DE_LENTEJAS].BI_Hecho_Venta') AND type = 'U')
BEGIN
	CREATE TABLE GUISO_DE_LENTEJAS.BI_Hecho_Venta (
        VENTA_CODIGO numeric(18,0) NOT NULL IDENTITY(1,1),
        VENTA_TIEMPO numeric(18,0) NOT NULL,
        VENTA_TIPO_INMUEBLE numeric(18,0) NOT NULL,
        VENTA_RANGO_M2 numeric(18,0) NOT NULL,
        VENTA_UBICACION numeric(18,0) NOT NULL,
        VENTA_RANGO_ETARIO_AGENTE numeric(18,0) NOT NULL,
        VENTA_SUCURSAL numeric(18,0) NOT NULL,
        VENTA_AMBIENTES numeric(18,0) NOT NULL,
        VENTA_TIPO_MONEDA numeric(18,0) NOT NULL,
        VENTA_COMISION numeric(18,2) NOT NULL 
	)
	PRINT('Tabla GUISO_DE_LENTEJAS.BI_Hecho_Venta creada')
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id= OBJECT_ID(N'[GUISO_DE_LENTEJAS].BI_Hecho_Alquiler') AND type = 'U')
BEGIN
	CREATE TABLE GUISO_DE_LENTEJAS.BI_Hecho_Alquiler (
        ALQUILER_CODIGO numeric(18,0) NOT NULL IDENTITY(1,1),
        ALQUILER_TIEMPO numeric(18,0) NOT NULL,
        ALQUILER_TIPO_INMUEBLE numeric(18,0) NOT NULL,
        ALQUILER_RANGO_M2 numeric(18,0) NOT NULL,
        ALQUILER_UBICACION numeric(18,0) NOT NULL,
        ALQUILER_RANGO_ETARIO_AGENTE numeric(18,0) NOT NULL,
        ALQUILER_RANGO_ETARIO_INQUILINO numeric(18,0) NOT NULL,
        ALQUILER_SUCURSAL numeric(18,0) NOT NULL,
        ALQUILER_AMBIENTES numeric(18,0) NOT NULL,
        ALQUILER_TIPO_MONEDA numeric(18,0) NOT NULL,
        ALQUILER_COMISION numeric(18,2) NOT NULL 
	)
	PRINT('Tabla GUISO_DE_LENTEJAS.BI_Hecho_Alquiler creada')
END
GO


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id= OBJECT_ID(N'[GUISO_DE_LENTEJAS].BI_Hecho_Anuncio') AND type = 'U')
BEGIN
	CREATE TABLE GUISO_DE_LENTEJAS.BI_Hecho_Anuncio (
        ANUNCIO_ID numeric(18,0) NOT NULL IDENTITY(1,1),
        ANUNCIO_TIEMPO_INICIO numeric(18,0) NOT NULL,
        ANUNCIO_TIEMPO_FIN numeric(18,0) NOT NULL,
        ANUNCIO_TIPO_INMUEBLE numeric(18,0) NOT NULL,
        ANUNCIO_RANGO_M2 numeric(18,0) NOT NULL,
        ANUNCIO_TIPO_MONEDA numeric(18,0) NOT NULL,
        ANUNCIO_UBICACION numeric(18,0) NOT NULL,
        ANUNCIO_TIPO_OPERACION numeric(18,0) NOT NULL,
        ANUNCIO_AMBIENTES numeric(18,0) NOT NULL,
        ANUNCIO_PRECIO numeric(18,2) NOT NULL
	)
	PRINT('Tabla GUISO_DE_LENTEJAS.BI_Hecho_Anuncio creada')
END
GO


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id= OBJECT_ID(N'[GUISO_DE_LENTEJAS].BI_Hecho_Pago_Alquiler') AND type = 'U')
BEGIN
	CREATE TABLE GUISO_DE_LENTEJAS.BI_Hecho_Pago_Alquiler (
        PAGO_ALQUILER_CODIGO numeric(18,0) NOT NULL IDENTITY(1,1),
        PAGO_FECHA_PAGO numeric(18,0) NOT NULL,
        PAGO_FECHA_VENCIMIENTO numeric(18,0) NOT NULL
	)
	PRINT('Tabla GUISO_DE_LENTEJAS.BI_Hecho_Pago_Alquiler creada')
END
GO

--Creacion tablas dimensiones

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id= OBJECT_ID(N'[GUISO_DE_LENTEJAS].BI_Tiempo') AND type = 'U')
BEGIN
	CREATE TABLE GUISO_DE_LENTEJAS.BI_Tiempo (
        TIEMPO_CODIGO numeric(18,0) NOT NULL IDENTITY(1,1),
        TIEMPO_ANIO numeric(18,0) NOT NULL,
        TIEMPO_CUATRIMESTRE numeric(18,0) NOT NULL,
        TIEMPO_MES numeric(18,0) NOT NULL,
        TIEMPO_DIA numeric(18,0) NOT NULL
	)
	PRINT('Tabla GUISO_DE_LENTEJAS.BI_Tiempo creada')
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id= OBJECT_ID(N'[GUISO_DE_LENTEJAS].BI_Ambiente') AND type = 'U')
BEGIN
	CREATE TABLE GUISO_DE_LENTEJAS.BI_Ambiente (
        AMBIENTE_CODIGO numeric(18,0) NOT NULL IDENTITY(1,1),
        AMBIENTE_DESCRIPCION nvarchar(100) NOT NULL
	)
	PRINT('Tabla GUISO_DE_LENTEJAS.BI_Ambiente creada')
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id= OBJECT_ID(N'[GUISO_DE_LENTEJAS].BI_Ubicacion') AND type = 'U')
BEGIN
	CREATE TABLE GUISO_DE_LENTEJAS.BI_Ubicacion (
        UBICACION_CODIGO numeric(18,0) NOT NULL IDENTITY(1,1),
        UBICACION_PROVINCIA nvarchar(100) NOT NULL,
        UBICACION_LOCALIDAD nvarchar(100) NOT NULL,
        UBICACION_BARRIO nvarchar(100) NOT NULL,
	)
	PRINT('Tabla GUISO_DE_LENTEJAS.BI_Ubicacion creada')
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id= OBJECT_ID(N'[GUISO_DE_LENTEJAS].BI_Rango_Etario_Agente') AND type = 'U')
BEGIN
	CREATE TABLE GUISO_DE_LENTEJAS.BI_Rango_Etario_Agente (
        RANGO_ETARIO_AGENTE_CODIGO numeric(18,0) NOT NULL IDENTITY(1,1),
        RANGO_ETARIO_AGENTE_DESCRIPCION nvarchar(10) NOT NULL
	)
	PRINT('Tabla GUISO_DE_LENTEJAS.BI_Rango_Etario_Agente creada')
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id= OBJECT_ID(N'[GUISO_DE_LENTEJAS].BI_Rango_Etario_Inquilino') AND type = 'U')
BEGIN
	CREATE TABLE GUISO_DE_LENTEJAS.BI_Rango_Etario_Inquilino (
        RANGO_ETARIO_INQUILINO_CODIGO numeric(18,0) NOT NULL IDENTITY(1,1),
        RANGO_ETARIO_INQUILINO_DESCRIPCION nvarchar(10) NOT NULL
	)
	PRINT('Tabla GUISO_DE_LENTEJAS.BI_Rango_Etario_Inquilino creada')
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id= OBJECT_ID(N'[GUISO_DE_LENTEJAS].BI_Sucursal') AND type = 'U')
BEGIN
	CREATE TABLE GUISO_DE_LENTEJAS.BI_Sucursal (
        SUCURSAL_CODIGO numeric(18,0) NOT NULL IDENTITY(1,1),
        SUCURSAL_NOMBRE nvarchar(100) NOT NULL 
	)
	PRINT('Tabla GUISO_DE_LENTEJAS.BI_Sucursal creada')
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id= OBJECT_ID(N'[GUISO_DE_LENTEJAS].BI_Rango_M2') AND type = 'U')
BEGIN
	CREATE TABLE GUISO_DE_LENTEJAS.BI_Rango_M2 (
        RANGO_M2_CODIGO numeric(18,0) NOT NULL IDENTITY(1,1),
        RANGO_M2_DESCRIPCION nvarchar(20) NOT NULL 
	)
	PRINT('Tabla GUISO_DE_LENTEJAS.BI_Rango_M2 creada')
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id= OBJECT_ID(N'[GUISO_DE_LENTEJAS].BI_Tipo_Inmueble') AND type = 'U')
BEGIN
	CREATE TABLE GUISO_DE_LENTEJAS.BI_Tipo_Inmueble (
        TIPO_INMUEBLE_ID numeric(18,0) NOT NULL IDENTITY(1,1),
        TIPO_INMUEBLE_DESCRIPCION nvarchar(100) NOT NULL
	)
	PRINT('Tabla GUISO_DE_LENTEJAS.BI_Tipo_Inmueble creada')
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id= OBJECT_ID(N'[GUISO_DE_LENTEJAS].BI_Tipo_Operacion') AND type = 'U')
BEGIN
	CREATE TABLE GUISO_DE_LENTEJAS.BI_Tipo_Operacion (
        TIPO_OPERACION_ID numeric(18,0) NOT NULL IDENTITY(1,1),
        TIPO_OPERACION_DESCRIPCION nvarchar(100) NOT NULL
	)
	PRINT('Tabla GUISO_DE_LENTEJAS.BI_Tipo_Operacion creada')
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id= OBJECT_ID(N'[GUISO_DE_LENTEJAS].BI_Tipo_Moneda') AND type = 'U')
BEGIN
	CREATE TABLE GUISO_DE_LENTEJAS.BI_Tipo_Moneda (
        TIPO_MONEDA_ID numeric(18,0) NOT NULL IDENTITY(1,1),
        TIPO_MONEDA_DESCRIPCION nvarchar(100) NOT NULL
	)
	PRINT('Tabla GUISO_DE_LENTEJAS.BI_Tipo_Moneda creada')
END
GO
