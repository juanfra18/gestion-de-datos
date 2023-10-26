-----------------------------------------------------------------------------------------------------
/*MIGRACION DE TABLAS*/
CREATE PROCEDURE GUISO_DE_LENTEJAS.MIGRAR_ESTADOS_INMUEBLES
AS
    BEGIN
        INSERT INTO GUISO_DE_LENTEJAS.ESTADO_INMUEBLE (ESTADO_INMUEBLE_DESCRIPCION)
        SELECT DISTINCT(INMUEBLE_ESTADO) from GD2C2023.gd_esquema.Maestra WHERE INMUEBLE_ESTADO IS NOT NULL
    END
    PRINT('Stored Procedure GUISO_DE_LENTEJAS.MIGRAR_ESTADOS_INMUEBLES ejecutado')
GO

CREATE PROCEDURE GUISO_DE_LENTEJAS.MIGRAR_ESTADOS_ANUNCIOS
AS
    BEGIN
        INSERT INTO GUISO_DE_LENTEJAS.ESTADO_ANUNCIO (ESTADO_ANUNCIO_DESCRIPCION)
        SELECT DISTINCT(ANUNCIO_ESTADO) from GD2C2023.gd_esquema.Maestra WHERE ANUNCIO_ESTADO IS NOT NULL
    END
    PRINT('Stored Procedure GUISO_DE_LENTEJAS.MIGRAR_ESTADOS_ANUNCIOS ejecutado')
GO

CREATE PROCEDURE GUISO_DE_LENTEJAS.MIGRAR_ESTADOS_ALQUILERES
AS
    BEGIN
        INSERT INTO GUISO_DE_LENTEJAS.ESTADO_ALQUILER (ESTADO_ALQUILER_DESCRIPCION)
        SELECT DISTINCT(ALQUILER_ESTADO) from GD2C2023.gd_esquema.Maestra WHERE ALQUILER_ESTADO IS NOT NULL
    END
    PRINT('Stored Procedure GUISO_DE_LENTEJAS.MIGRAR_ESTADOS_ALQUILERES ejecutado')
GO

CREATE PROCEDURE GUISO_DE_LENTEJAS.MIGRAR_TIPOS_OPERACIONES
AS
    BEGIN
        INSERT INTO GUISO_DE_LENTEJAS.TIPO_OPERACION (TIPO_OPERACION_DESCRIPCION)
        SELECT DISTINCT (ANUNCIO_TIPO_OPERACION) FROM GD2C2023.gd_esquema.Maestra WHERE ANUNCIO_TIPO_OPERACION IS NOT NULL
    END
    PRINT('Stored Procedure GUISO_DE_LENTEJAS.MIGRAR_TIPOS_OPERACIONES ejecutado')
GO

CREATE PROCEDURE GUISO_DE_LENTEJAS.MIGRAR_CARACTERISTICAS
AS
    BEGIN
        INSERT INTO GUISO_DE_LENTEJAS.CARACTERISTICA (CARACTERISTICA_DESCRIPCION)
        VALUES('Cable'),('Calefaccion'),('Wifi'),('Gas')
    END
    PRINT('Stored Procedure GUISO_DE_LENTEJAS.MIGRAR_CARACTERISTICAS ejecutado')
GO

--PROBARLO CUANDO LA TABLA SUCURSAL ESTE MIGRADA
/* 
CREATE PROCEDURE GUISO_DE_LENTEJAS.MIGRAR_AGENTES_INMOBILIARIOS
AS
    BEGIN
        INSERT INTO GUISO_DE_LENTEJAS.AGENTE_INMOBILIARIO (AGENTE_INMOBILIARIO_NOMBRE, 
                                                            AGENTE_INMOBILIARIO_APELLIDO, 
                                                            AGENTE_INMOBILIARIO_DNI, 
                                                            AGENTE_INMOBILIARIO_MAIL,
                                                            AGENTE_INMOBILIARIO_TELEFONO,
                                                            AGENTE_INMOBILIARIO_FECHA_NACIMIENTO,
                                                            AGENTE_INMOBILIARIO_FECHA_REGISTRO,
                                                            AGENTE_INMOBILIARIO_SUCURSAL)
       SELECT  DISTINCT M.AGENTE_NOMBRE, M.AGENTE_APELLIDO, M.AGENTE_DNI,
		                M.AGENTE_MAIL,M.AGENTE_TELEFONO,M.AGENTE_FECHA_NAC,
                        M.AGENTE_FECHA_REGISTRO,
                        (SELECT SUCURSAL_ID FROM GUISO_DE_LENTEJAS.SUCURSAL WHERE M.SUCURSAL_CODIGO = SUCURSAL_ID)
                        FROM GD2C2023.gd_esquema.Maestra M
    END
    PRINT('Stored Procedure GUISO_DE_LENTEJAS.MIGRAR_AGENTES_INMOBILIARIOS ejecutado')
GO
*/
--PROBAR CUANDO LA TABLA ALQUIER ESTE MIGRADA
/*
CREATE PROCEDURE GUISO_DE_LENTEJAS.MIGRAR_DETALLES_IMPORTES_ALQUILERES
AS
    BEGIN
        INSERT INTO GUISO_DE_LENTEJAS.DETALLE_IMPORTE_ALQUILER (DETALLE_IMPORTE_ALQUILER_NRO_PERIODO_INICIO,
                                                                DETALLE_IMPORTE_ALQUILER_NRO_PERIODO_FIN,
                                                                DETALLE_IMPORTE_ALQUILER_PRECIO,
                                                                DETALLE_IMPORTE_ALQUILER_ALQUILER)
        SELECT DISTINCT 
               DETALLE_ALQ_NRO_PERIODO_FIN, 
               DETALLE_ALQ_NRO_PERIODO_FIN, 
               DETALLE_ALQ_PRECIO, 
               ALQUILER_CODIGO 
			   FROM GD2C2023.gd_esquema.Maestra
			   WHERE DETALLE_ALQ_NRO_PERIODO_INI IS NOT NULL AND DETALLE_ALQ_NRO_PERIODO_FIN IS NOT NULL

    END
    PRINT('Stored Procedure GUISO_DE_LENTEJAS.MIGRAR_DETALLES_IMPORTES_ALQUILERES ejecutado')
GO
*/
--PROBARLO CUANDO ESTEN MIGRADAS LAS TABLAS MONEDA, TIPO_PERIODO, AGENTE_INMOBILIARIO Y INMUEBLE
/*
CREATE PROCEDURE GUISO_DE_LENTEJAS.MIGRAR_ANUNCIOS
AS
    BEGIN
        INSERT INTO GUISO_DE_LENTEJAS.MIGRAR_ANUNCIOS  (ANUNCIO_FECHA_PUBLICACION,
                                                        ANUNCIO_PRECIO_PUBLICADO,
                                                        ANUNCIO_ESTADO,
                                                        ANUNCIO_FECHA_FINALIZACION,
                                                        ANUNCIO_COSTO_PUBLICACION,
                                                        ANUNCIO_AGENTE_INMOBILIARIO,
                                                        ANUNCIO_TIPO_OPERACION,
                                                        ANUNCIO_INMUEBLE,
                                                        ANUNCIO_MONEDA,
                                                        ANUNCIO_TIPO_PERIODO)
        SELECT DISTINCT 
                M.ANUNCIO_FECHA_PUBLICACION, 
                M.ANUNCIO_PRECIO_PUBLICADO, 
                (SELECT ESTADO_ANUNCIO_ID FROM GUISO_DE_LENTEJAS.ESTADO_ANUNCIO WHERE ESTADO_ANUNCIO_DESCRIPCION = M.ANUNCIO_ESTADO) AS ESTADO_ANUNCIO_ID, 
                M.ANUNCIO_FECHA_FINALIZACION,
                M.ANUNCIO_COSTO_ANUNCIO, 
                (SELECT AGENTE_INMOBILIARIO_ID FROM GUISO_DE_LENTEJAS.AGENTE_INMOBILIARIO WHERE M.AGENTE_NOMBRE = AGENTE_INMOBILIARIO_NOMBRE AND M.AGENTE_APELLIDO = AGENTE_INMOBILIARIO_APELLIDO AND M.AGENTE_DNI = AGENTE_INMOBILIARIO_DNI) AS AGENTE_INMOBILIARIO_ID,
                (SELECT TIPO_OPERACION_ID FROM GUISO_DE_LENTEJAS.TIPO_OPERACION WHERE M.ANUNCIO_TIPO_OPERACION = TIPO_OPERACION_DESCRIPCION) AS TIPO_OPERACION_ID, 
                M.INMUEBLE_CODIGO,
                (SELECT MONEDA_CODIGO FROM GUISO_DE_LENTEJAS.MONEDA WHERE M.ANUNCIO_MONEDA = MONEDA_CODIGO) AS MONEDA_ID,
                (SELECT TIPO_PERIODO_ID FROM GUISO_DE_LENTEJAS.TIPO_PERIODO WHERE M.ANUNCIO_TIPO_PERIODO = TIPO_PERIODO_DESCRIPCION) AS TIPO_PERIODO_ID
                FROM GD2C2023.gd_esquema.Maestra M
                WHERE M.INMUEBLE_CODIGO IS NOT NULL
    END
    PRINT('Stored Procedure GUISO_DE_LENTEJAS.MIGRAR_ANUNCIOS ejecutado')
GO
*/

--PROBAR CUANDO ESTÉ MIGRADA LA TABLA ALQUILER
/*
CREATE PROCEDURE GUISO_DE_LENTEJAS.MIGRAR_PAGOS_ALQUILER
AS
    BEGIN
        INSERT INTO GUISO_DE_LENTEJAS.PAGO_ALQUILER (PAGO_ALQUILER_ID,  
                                                    PAGO_ALQUILER_FECHA_INICIO,
                                                    PAGO_ALQUILER_FECHA_VENCIMIENTO,
                                                    PAGO_ALQUILER_FECHA_PAGO,
                                                    PAGO_ALQUILER_NRO_PERIODO,
                                                    PAGO_ALQUILER_DESC_PERIODO,
                                                    PAGO_ALQUILER_FECHA_FIN,
                                                    PAGO_ALQUILER_IMPORTE,
                                                    PAGO_ALQUILER_MEDIO_PAGO,
                                                    PAGO_ALQUILER_ALQUILER)
        SELECT DISTINCT(M.PAGO_ALQUILER_CODIGO),
        M.PAGO_ALQUILER_FEC_INI,
        M.PAGO_ALQUILER_FECHA_VENCIMIENTO,
        M.PAGO_ALQUILER_FECHA,
        M.PAGO_ALQUILER_NRO_PERIODO,
        M.PAGO_ALQUILER_DESC,
        M.PAGO_ALQUILER_FEC_FIN,
        M.PAGO_ALQUILER_IMPORTE,
        (SELECT MEDIO_DE_PAGO_ID FROM GUISO_DE_LENTEJAS.MEDIO_DE_PAGO WHERE M.PAGO_ALQUILER_MEDIO_PAGO = MEDIO_DE_PAGO_DESCRIPCION) AS MEDIO_DE_PAGO_ID,
        (SELECT ALQUILER_ID FROM GUISO_DE_LENTEJAS.ALQUILER WHERE M.ALQUILER_CODIGO = ALQUILER_ID) AS ALQUILER_ID
        from GD2C2023.gd_esquema.Maestra M WHERE PAGO_ALQUILER_CODIGO IS NOT NULL
    END
    PRINT('Stored Procedure GUISO_DE_LENTEJAS.MIGRAR_PAGOS_ALQUILER ejecutado')
GO
*/

CREATE PROCEDURE GUISO_DE_LENTEJAS.MIGRAR_INQUILINOS
AS
    BEGIN
        INSERT INTO GUISO_DE_LENTEJAS.INQUILINO (INQUILINO_NOMBRE, 
                                                INQUILINO_APELLIDO, 
                                                INQUILINO_DNI, 
                                                INQUILINO_FECHA_REGISTRO,
                                                INQUILINO_TELEFONO,
                                                INQUILINO_MAIL,
                                                INQUILINO_FECHA_NAC)
       SELECT  DISTINCT M.INQUILINO_NOMBRE, M.INQUILINO_APELLIDO, M.INQUILINO_DNI,
		                M.INQUILINO_FECHA_REGISTRO,M.INQUILINO_TELEFONO,M.INQUILINO_MAIL,
                        M.INQUILINO_FECHA_NAC
        FROM GD2C2023.gd_esquema.Maestra M WHERE INQUILINO_NOMBRE IS NOT NULL
    END
    PRINT('Stored Procedure GUISO_DE_LENTEJAS.MIGRAR_INQUILINOS ejecutado')
GO

--PROBAR CUANDO ESTÉN MIGRADAS LAS TABLAS LOCALIDAD Y PROVINCIA
/*
CREATE PROCEDURE GUISO_DE_LENTEJAS.MIGRAR_SUCURSALES
AS
    BEGIN
        INSERT INTO GUISO_DE_LENTEJAS.SUCURSAL (SUCURSAL_ID, 
                                                SUCURSAL_NOMBRE,
                                                SUCURSAL_DIRECCION,
                                                SUCURSAL_TELEFONO,
                                                SUCURSAL_LOCALIDAD)
       SELECT  DISTINCT M.SUCURSAL_CODIGO, M.SUCURSAL_NOMBRE, M.SUCURSAL_DIRECCION,
		                M.SUCURSAL_TELEFONO,
                        (SELECT LOCALIDAD_ID FROM GUISO_DE_LENTEJAS.LOCALIDAD
                        WHERE M.SUCURSAL_LOCALIDAD = LOCALIDAD_NOMBRE AND M.SUCURSAL_PROVINCIA = LOCALIDAD_PROVINCIA) AS LOCALIDAD_ID
        FROM GD2C2023.gd_esquema.Maestra M
    END
    PRINT('Stored Procedure GUISO_DE_LENTEJAS.MIGRAR_SUCURSALES ejecutado')
GO
*/

CREATE PROCEDURE GUISO_DE_LENTEJAS.MIGRAR_PROPIETARIOS
AS
    BEGIN
        INSERT INTO GUISO_DE_LENTEJAS.PROPIETARIO (PROPIETARIO_NOMBRE,
                                                   PROPIETARIO_APELLIDO,
                                                   PROPIETARIO_DNI,
                                                   PROPIETARIO_FECHA_REGISTRO,
                                                   PROPIETARIO_TELEFONO,
                                                   PROPIETARIO_MAIL,
                                                   PROPIETARIO_FECHA_NAC)
       SELECT DISTINCT M.PROPIETARIO_NOMBRE, M.PROPIETARIO_APELLIDO, M.PROPIETARIO_DNI,
		                M.PROPIETARIO_FECHA_REGISTRO,M.PROPIETARIO_TELEFONO,M.PROPIETARIO_MAIL,
                        M.PROPIETARIO_FECHA_NAC
        FROM GD2C2023.gd_esquema.Maestra M WHERE PROPIETARIO_NOMBRE IS NOT NULL
    END
    PRINT('Stored Procedure GUISO_DE_LENTEJAS.MIGRAR_PROPIETARIOS ejecutado')
GO

CREATE PROCEDURE GUISO_DE_LENTEJAS.MIGRAR_AMBIENTES
AS
    BEGIN
        INSERT INTO GUISO_DE_LENTEJAS.AMBIENTE (AMBIENTE_DESCRIPCION)
        SELECT DISTINCT(INMUEBLE_CANT_AMBIENTES) from GD2C2023.gd_esquema.Maestra WHERE INMUEBLE_CANT_AMBIENTES IS NOT NULL
    END
    PRINT('Stored Procedure GUISO_DE_LENTEJAS.MIGRAR_AMBIENTES ejecutado')
GO

CREATE PROCEDURE GUISO_DE_LENTEJAS.MIGRAR_MEDIOS_DE_PAGO
AS
    BEGIN
        INSERT INTO GUISO_DE_LENTEJAS.MEDIO_DE_PAGO (MEDIO_DE_PAGO_DESCRIPCION)
        SELECT DISTINCT PAGO_ALQUILER_MEDIO_PAGO FROM GD2C2023.gd_esquema.Maestra WHERE PAGO_ALQUILER_MEDIO_PAGO IS NOT NULL
        UNION
        SELECT DISTINCT PAGO_VENTA_MEDIO_PAGO FROM GD2C2023.gd_esquema.Maestra WHERE PAGO_VENTA_MEDIO_PAGO IS NOT NULL
    END
    PRINT('Stored Procedure GUISO_DE_LENTEJAS.MIGRAR_MEDIOS_DE_PAGO ejecutado')
GO

CREATE PROCEDURE GUISO_DE_LENTEJAS.MIGRAR_MONEDAS
AS
    BEGIN
        INSERT INTO GUISO_DE_LENTEJAS.MONEDA (MONEDA_DESCRIPCION)
        SELECT DISTINCT ANUNCIO_MONEDA FROM GD2C2023.gd_esquema.Maestra WHERE ANUNCIO_MONEDA IS NOT NULL
        UNION
        SELECT DISTINCT PAGO_VENTA_MONEDA FROM GD2C2023.gd_esquema.Maestra WHERE PAGO_VENTA_MONEDA IS NOT NULL
        UNION
        SELECT DISTINCT VENTA_MONEDA FROM GD2C2023.gd_esquema.Maestra WHERE VENTA_MONEDA IS NOT NULL
    END
    PRINT('Stored Procedure GUISO_DE_LENTEJAS.MIGRAR_MONEDAS ejecutado')
GO

CREATE PROCEDURE GUISO_DE_LENTEJAS.MIGRAR_TIPOS_INMUEBLES
AS
    BEGIN
        INSERT INTO GUISO_DE_LENTEJAS.TIPO_INMUEBLE (TIPO_INMUEBLE_DESCRIPCION)
        SELECT DISTINCT INMUEBLE_TIPO_INMUEBLE FROM GD2C2023.gd_esquema.Maestra WHERE INMUEBLE_TIPO_INMUEBLE IS NOT NULL
    END
    PRINT('Stored Procedure GUISO_DE_LENTEJAS.MIGRAR_TIPOS_INMUEBLES ejecutado')
GO

CREATE PROCEDURE GUISO_DE_LENTEJAS.MIGRAR_PROVINCIAS
AS
    BEGIN
        INSERT INTO GUISO_DE_LENTEJAS.PROVINCIA (PROVINCIA_NOMBRE)
        SELECT DISTINCT INMUEBLE_PROVINCIA FROM GD2C2023.gd_esquema.Maestra WHERE INMUEBLE_PROVINCIA IS NOT NULL
        UNION
        SELECT DISTINCT SUCURSAL_PROVINCIA FROM GD2C2023.gd_esquema.Maestra WHERE SUCURSAL_PROVINCIA IS NOT NULL
    END
    PRINT('Stored Procedure GUISO_DE_LENTEJAS.MIGRAR_PROVINCIAS ejecutado')
GO

CREATE PROCEDURE GUISO_DE_LENTEJAS.MIGRAR_DISPOSICIONES
AS
    BEGIN
        INSERT INTO GUISO_DE_LENTEJAS.DISPOSICION (DISPOSICION_DESCRIPCION)
        SELECT DISTINCT INMUEBLE_DISPOSICION FROM GD2C2023.gd_esquema.Maestra WHERE INMUEBLE_DISPOSICION IS NOT NULL
    END
    PRINT('Stored Procedure GUISO_DE_LENTEJAS.MIGRAR_DISPOSICIONES ejecutado')
GO

CREATE PROCEDURE GUISO_DE_LENTEJAS.MIGRAR_ORIENTACIONES
AS
    BEGIN
        INSERT INTO GUISO_DE_LENTEJAS.ORIENTACION (ORIENTACION_DESCRIPCION)
        SELECT DISTINCT INMUEBLE_ORIENTACION FROM GD2C2023.gd_esquema.Maestra WHERE INMUEBLE_ORIENTACION IS NOT NULL
    END
    PRINT('Stored Procedure GUISO_DE_LENTEJAS.MIGRAR_ORIENTACIONES ejecutado')
GO
-----------------------------------------------------------------------------------------------------
/*EJECUCION DE PROCEDURES*/
EXECUTE GUISO_DE_LENTEJAS.MIGRAR_ESTADOS_INMUEBLES

EXECUTE GUISO_DE_LENTEJAS.MIGRAR_ESTADOS_ANUNCIOS

EXECUTE GUISO_DE_LENTEJAS.MIGRAR_ESTADOS_ALQUILERES

EXECUTE GUISO_DE_LENTEJAS.MIGRAR_TIPOS_OPERACIONES

EXECUTE GUISO_DE_LENTEJAS.MIGRAR_CARACTERISTICAS

EXECUTE GUISO_DE_LENTEJAS.MIGRAR_MEDIOS_DE_PAGO

EXECUTE GUISO_DE_LENTEJAS.MIGRAR_AMBIENTES

EXECUTE GUISO_DE_LENTEJAS.MIGRAR_PROPIETARIOS

EXECUTE GUISO_DE_LENTEJAS.MIGRAR_INQUILINOS

--EXECUTE GUISO_DE_LENTEJAS.MIGRAR_SUCURSALES

--EXECUTE GUISO_DE_LENTEJAS.MIGRAR_PAGOS_ALQUILER

--EXECUTE GUISO_DE_LENTEJAS.MIGRAR_AGENTES_INMOBILIARIOS

--EXECUTE GUISO_DE_LENTEJAS.MIGRAR_DETALLES_IMPORTES_ALQUILERES

--EXECUTE GUISO_DE_LENTEJAS.MIGRAR_ANUNCIOS

EXECUTE GUISO_DE_LENTEJAS.MIGRAR_MONEDAS

EXECUTE GUISO_DE_LENTEJAS.MIGRAR_TIPOS_INMUEBLES

EXECUTE GUISO_DE_LENTEJAS.MIGRAR_PROVINCIAS

EXECUTE GUISO_DE_LENTEJAS.MIGRAR_DISPOSICIONES

EXECUTE GUISO_DE_LENTEJAS.MIGRAR_ORIENTACIONES












