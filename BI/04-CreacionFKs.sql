
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_PAGO_ALQUILER_MEDIO_PAGO')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.PAGO_ALQUILER
	ADD CONSTRAINT FK_PAGO_ALQUILER_MEDIO_PAGO FOREIGN KEY (PAGO_ALQUILER_MEDIO_PAGO) REFERENCES GUISO_DE_LENTEJAS.MEDIO_DE_PAGO(MEDIO_DE_PAGO_ID)
	PRINT('Foreign key de MEDIO PAGO de la tabla GUISO_DE_LENTEJAS.PAGO_ALQUILER agregada')
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_PAGO_ALQUILER_ALQUILER')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.PAGO_ALQUILER
	ADD CONSTRAINT FK_PAGO_ALQUILER_ALQUILER FOREIGN KEY (PAGO_ALQUILER_ALQUILER) REFERENCES GUISO_DE_LENTEJAS.ALQUILER(ALQUILER_ID)
	PRINT('Foreign key de MEDIO PAGO de la tabla GUISO_DE_LENTEJAS.PAGO_ALQUILER agregada')
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_SUCURSAL_LOCALIDAD')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.SUCURSAL
	ADD CONSTRAINT FK_SUCURSAL_LOCALIDAD FOREIGN KEY (SUCURSAL_LOCALIDAD) REFERENCES GUISO_DE_LENTEJAS.LOCALIDAD(LOCALIDAD_ID)
	PRINT('Foreign key de LOCALIDAD de la tabla GUISO_DE_LENTEJAS.SUCURSAL agregada')
END
GO

/*AGREGANDO CONSTRAINS FK A LA TABLA VENTA*/
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_VENTA_COMPRADOR')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.VENTA
	ADD CONSTRAINT FK_VENTA_COMPRADOR FOREIGN KEY (VENTA_COMPRADOR) REFERENCES GUISO_DE_LENTEJAS.COMPRADOR(COMPRADOR_ID)
	PRINT('Foreign key de COMPRADOR de la tabla GUISO_DE_LENTEJAS.VENTA agregada')
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_VENTA_MONEDA')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.VENTA
	ADD CONSTRAINT FK_VENTA_MONEDA FOREIGN KEY (VENTA_MONEDA) REFERENCES GUISO_DE_LENTEJAS.MONEDA(MONEDA_ID)
	PRINT('Foreign key de MONEDA de la tabla GUISO_DE_LENTEJAS.VENTA agregada')
END
GO


IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_VENTA_ANUNCIO')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.VENTA
	ADD CONSTRAINT FK_VENTA_ANUNCIO FOREIGN KEY (VENTA_ANUNCIO) REFERENCES GUISO_DE_LENTEJAS.ANUNCIO(ANUNCIO_ID)
	PRINT('Foreign key de ANUNCIO de la tabla GUISO_DE_LENTEJAS.VENTA agregada')
END
GO


/*AGREGANDO CONSTRAINS FK A LA TABLA LOCALIDAD*/
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_LOCALIDAD_PROVINCIA')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.LOCALIDAD
	ADD CONSTRAINT FK_LOCALIDAD_PROVINCIA FOREIGN KEY (LOCALIDAD_PROVINCIA) REFERENCES GUISO_DE_LENTEJAS.PROVINCIA(PROVINCIA_ID)
	PRINT('Foreign key de PROVINCIA de la tabla GUISO_DE_LENTEJAS.LOCALIDAD agregada')
END
GO

/*AGREGANDO CONSTRAINS FK A LA TABLA PAGO_VENTA*/
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_PAGO_VENTA_VENTA')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.PAGO_VENTA
	ADD CONSTRAINT FK_PAGO_VENTA_VENTA FOREIGN KEY (PAGO_VENTA_VENTA) REFERENCES GUISO_DE_LENTEJAS.VENTA(VENTA_CODIGO)
	PRINT('Foreign key de VENTA de la tabla GUISO_DE_LENTEJAS.PAGO_VENTA agregada')
END
GO


IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_PAGO_VENTA_MONEDA')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.PAGO_VENTA
	ADD CONSTRAINT FK_PAGO_VENTA_MONEDA FOREIGN KEY (PAGO_VENTA_MONEDA) REFERENCES GUISO_DE_LENTEJAS.MONEDA(MONEDA_ID)
	PRINT('Foreign key de MONEDA de la tabla GUISO_DE_LENTEJAS.PAGO_VENTA agregada')
END
GO


/*descomentar cuando este creado la tabla MEDIOPAGO con pk*/

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_PAGO_VENTA_MEDIOPAGO')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.PAGO_VENTA
	ADD CONSTRAINT FK_PAGO_VENTA_MEDIOPAGO FOREIGN KEY (PAGO_VENTA_MEDIOPAGO) REFERENCES GUISO_DE_LENTEJAS.MEDIO_DE_PAGO(MEDIO_DE_PAGO_ID)
	PRINT('Foreign key de MEDIO_DE_PAGO de la tabla GUISO_DE_LENTEJAS.PAGO_VENTA agregada')
END
GO


/* FKs TABLA ANUNCIO*/
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_ANUNCIO_ESTADO_ANUNCIO')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.ANUNCIO
	ADD CONSTRAINT FK_ANUNCIO_ESTADO_ANUNCIO FOREIGN KEY (ANUNCIO_ESTADO) REFERENCES GUISO_DE_LENTEJAS.ESTADO_ANUNCIO(ESTADO_ANUNCIO_ID)
	PRINT('Foreign key de ESTADO de la tabla GUISO_DE_LENTEJAS.ANUNCIO agregada')
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_ANUNCIO_AGENTE_INMOBILIARIO')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.ANUNCIO
	ADD CONSTRAINT FK_ANUNCIO_AGENTE_INMOBILIARIO FOREIGN KEY (ANUNCIO_AGENTE_INMOBILIARIO) REFERENCES GUISO_DE_LENTEJAS.AGENTE_INMOBILIARIO(AGENTE_INMOBILIARIO_ID)
	PRINT('Foreign key de AGENTE INMOBILIARIO de la tabla GUISO_DE_LENTEJAS.ANUNCIO agregada')
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_ANUNCIO_TIPO_OPERACION')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.ANUNCIO
	ADD CONSTRAINT FK_ANUNCIO_TIPO_OPERACION FOREIGN KEY (ANUNCIO_TIPO_OPERACION) REFERENCES GUISO_DE_LENTEJAS.TIPO_OPERACION(TIPO_OPERACION_ID)
	PRINT('Foreign key de TIPO OPERACION de la tabla GUISO_DE_LENTEJAS.ANUNCIO agregada')
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_ANUNCIO_INMUEBLE')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.ANUNCIO
	ADD CONSTRAINT FK_ANUNCIO_INMUEBLE FOREIGN KEY (ANUNCIO_INMUEBLE) REFERENCES GUISO_DE_LENTEJAS.INMUEBLE(INMUEBLE_NUMERO)
	PRINT('Foreign key de INMUEBLE de la tabla GUISO_DE_LENTEJAS.ANUNCIO agregada')
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_ANUNCIO_MONEDA')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.ANUNCIO
	ADD CONSTRAINT FK_ANUNCIO_MONEDA FOREIGN KEY (ANUNCIO_MONEDA) REFERENCES GUISO_DE_LENTEJAS.MONEDA(MONEDA_ID)
	PRINT('Foreign key de MONEDA de la tabla GUISO_DE_LENTEJAS.ANUNCIO agregada')
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_ANUNCIO_TIPO_PERIODO')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.ANUNCIO
	ADD CONSTRAINT FK_ANUNCIO_TIPO_PERIODO FOREIGN KEY (ANUNCIO_TIPO_PERIODO) REFERENCES GUISO_DE_LENTEJAS.TIPO_PERIODO(TIPO_PERIODO_ID)
	PRINT('Foreign key de TIPO PERIODO de la tabla GUISO_DE_LENTEJAS.ANUNCIO agregada')
END
GO

/*FKs TABLA AGENTE INMOBILIARIO*/
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_AGENTE_INMOBILIARIO_SUCURSAL')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.AGENTE_INMOBILIARIO
	ADD CONSTRAINT FK_AGENTE_INMOBILIARIO_SUCURSAL FOREIGN KEY (AGENTE_INMOBILIARIO_SUCURSAL) REFERENCES GUISO_DE_LENTEJAS.SUCURSAL(SUCURSAL_ID)
	PRINT('Foreign key de SUCURSAL de la tabla GUISO_DE_LENTEJAS.AGENTE_INMOBILIARIO agregada')
END
GO

/*FKs TABLA DETALLE IMPORTE ALQUILER*/
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_DETALLE_IMPORTE_ALQUILER_ALQUILER')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.DETALLE_IMPORTE_ALQUILER
	ADD CONSTRAINT FK_DETALLE_IMPORTE_ALQUILER_ALQUILER FOREIGN KEY (DETALLE_IMPORTE_ALQUILER_ALQUILER) REFERENCES GUISO_DE_LENTEJAS.ALQUILER(ALQUILER_ID)
	PRINT('Foreign key de ALQUILER de la tabla GUISO_DE_LENTEJAS.DETALLE_IMPORTE_ALQUILER agregada')
END
GO

/*FKs TABLA BARRIO*/
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_BARRIO_LOCALIDAD')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.BARRIO
	ADD CONSTRAINT FK_BARRIO_LOCALIDAD FOREIGN KEY (BARRIO_LOCALIDAD) REFERENCES GUISO_DE_LENTEJAS.LOCALIDAD(LOCALIDAD_ID)
	PRINT('Foreign key de LOCALIDAD de la tabla GUISO_DE_LENTEJAS.BARRIO agregada')
END
GO

/*FKs TABLA INMUEBLE_CARACTERISTICA*/
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_INMUEBLE_CARACTERISTICA_INMUEBLE')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.INMUEBLE_CARACTERISTICA
	ADD CONSTRAINT FK_INMUEBLE_CARACTERISTICA_INMUEBLE FOREIGN KEY (INMUEBLE_ID) REFERENCES GUISO_DE_LENTEJAS.INMUEBLE(INMUEBLE_NUMERO)
	PRINT('Foreign key de INMUEBLE de la tabla GUISO_DE_LENTEJAS.INMUEBLE_CARACTERISTICA agregada')
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_INMUEBLE_CARACTERISTICA_CARACTERISTICA')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.INMUEBLE_CARACTERISTICA
	ADD CONSTRAINT FK_INMUEBLE_CARACTERISTICA_CARACTERISTICA FOREIGN KEY (CARACTERISTICA_ID) REFERENCES GUISO_DE_LENTEJAS.CARACTERISTICA(CARACTERISTICA_ID)
	PRINT('Foreign key de CARACTERISTICA de la tabla GUISO_DE_LENTEJAS.INMUEBLE_CARACTERISTICA agregada')
END
GO

/*FKs TABLA INMUEBLE*/
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_INMUEBLE_AMBIENTE')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.INMUEBLE
	ADD CONSTRAINT FK_INMUEBLE_AMBIENTE FOREIGN KEY (INMUEBLE_AMBIENTE) REFERENCES GUISO_DE_LENTEJAS.AMBIENTE(AMBIENTE_ID)
	PRINT('Foreign key de AMBIENTE de la tabla GUISO_DE_LENTEJAS.INMUEBLE agregada')
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_INMUEBLE_ESTADO')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.INMUEBLE
	ADD CONSTRAINT FK_INMUEBLE_ESTADO FOREIGN KEY (INMUEBLE_ESTADO) REFERENCES GUISO_DE_LENTEJAS.ESTADO_INMUEBLE(ESTADO_INMUEBLE_ID)
	PRINT('Foreign key de ESTADO de la tabla GUISO_DE_LENTEJAS.INMUEBLE agregada')
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_INMUEBLE_TIPOINMUEBLE')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.INMUEBLE
	ADD CONSTRAINT FK_INMUEBLE_TIPOINMUEBLE FOREIGN KEY (INMUEBLE_TIPOINMUEBLE) REFERENCES GUISO_DE_LENTEJAS.TIPO_INMUEBLE(TIPO_INMUEBLE_ID)
	PRINT('Foreign key de TIPOINMUEBLE de la tabla GUISO_DE_LENTEJAS.INMUEBLE agregada')
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_INMUEBLE_PROPIETARIO')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.INMUEBLE
	ADD CONSTRAINT FK_INMUEBLE_PROPIETARIO FOREIGN KEY (INMUEBLE_PROPIETARIO) REFERENCES GUISO_DE_LENTEJAS.PROPIETARIO(PROPIETARIO_ID)
	PRINT('Foreign key de PROPIETARIO de la tabla GUISO_DE_LENTEJAS.INMUEBLE agregada')
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_INMUEBLE_DISPOSICION')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.INMUEBLE
	ADD CONSTRAINT FK_INMUEBLE_DISPOSICION FOREIGN KEY (INMUEBLE_DISPOSICION) REFERENCES GUISO_DE_LENTEJAS.DISPOSICION(DISPOSICION_ID)
	PRINT('Foreign key de DISPOSICION de la tabla GUISO_DE_LENTEJAS.INMUEBLE agregada')
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_INMUEBLE_ORIENTACION')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.INMUEBLE
	ADD CONSTRAINT FK_INMUEBLE_ORIENTACION FOREIGN KEY (INMUEBLE_ORIENTACION) REFERENCES GUISO_DE_LENTEJAS.ORIENTACION(ORIENTACION_ID)
	PRINT('Foreign key de ORIENTACION de la tabla GUISO_DE_LENTEJAS.INMUEBLE agregada')
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_INMUEBLE_BARRIO')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.INMUEBLE
	ADD CONSTRAINT FK_INMUEBLE_BARRIO FOREIGN KEY (INMUEBLE_BARRIO) REFERENCES GUISO_DE_LENTEJAS.BARRIO(BARRIO_ID)
	PRINT('Foreign key de BARRIO de la tabla GUISO_DE_LENTEJAS.INMUEBLE agregada')
END
GO

/*FKs TABLA ALQUILER*/
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_ALQUILER_ESTADO')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.ALQUILER
	ADD CONSTRAINT FK_ALQUILER_ESTADO FOREIGN KEY (ALQUILER_ESTADO) REFERENCES GUISO_DE_LENTEJAS.ESTADO_ALQUILER(ESTADO_ALQUILER_ID)
	PRINT('Foreign key de ESTADO de la tabla GUISO_DE_LENTEJAS.ALQUILER agregada')
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_ALQUILER_ANUNCIO')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.ALQUILER
	ADD CONSTRAINT FK_ALQUILER_ANUNCIO FOREIGN KEY (ALQUILER_ANUNCIO) REFERENCES GUISO_DE_LENTEJAS.ANUNCIO(ANUNCIO_ID)
	PRINT('Foreign key de ANUNCIO de la tabla GUISO_DE_LENTEJAS.ALQUILER agregada')
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE CONSTRAINT_NAME ='FK_ALQUILER_INQUILINO')
BEGIN
	ALTER TABLE GUISO_DE_LENTEJAS.ALQUILER
	ADD CONSTRAINT FK_ALQUILER_INQUILINO FOREIGN KEY (ALQUILER_INQUILINO) REFERENCES GUISO_DE_LENTEJAS.INQUILINO(INQUILINO_ID)
	PRINT('Foreign key de INQUILINO de la tabla GUISO_DE_LENTEJAS.ALQUILER agregada')
END
GO
