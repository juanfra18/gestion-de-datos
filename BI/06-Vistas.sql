--Vista 1: Duracion promedio en dias de publicacion de anuncios
/* Duración promedio (en días) que se encuentran publicados los anuncios
según el tipo de operación (alquiler, venta, etc), barrio y ambientes para cada
cuatrimestre de cada año. Se consideran todos los anuncios que se dieron de alta
en ese cuatrimestre. La duración se calcula teniendo en cuenta la fecha de alta y
la fecha de finalización.*/
CREATE VIEW GUISO_DE_LENTEJAS.BI_DURACION_PROMEDIO_PUBLICACION_ANUNCIO AS
    SELECT  tiop.TIPO_OPERACION_DESCRIPCION, 
            ub.UBICACION_BARRIO, 
            am.AMBIENTE_DESCRIPCION, 
            ti.TIEMPO_ANIO,
            ti.TIEMPO_CUATRIMESTRE, 
            CAST(SUM(DATEDIFF(DAY,DATEFROMPARTS(ti.TIEMPO_ANIO,ti.TIEMPO_MES, ti.TIEMPO_DIA), DATEFROMPARTS(ti2.TIEMPO_ANIO,ti2.TIEMPO_MES,ti2.TIEMPO_DIA))) / SUM(an.ANUNCIO_CANT_ANUNCIOS_AGRUPADOS) AS int) AS 'Duracion Promedio de Publicacion (dias)'
			FROM GUISO_DE_LENTEJAS.BI_Hecho_Anuncio an
            JOIN GUISO_DE_LENTEJAS.BI_Tipo_Operacion tiop ON (tiop.TIPO_OPERACION_ID = an.ANUNCIO_TIPO_OPERACION)
            JOIN GUISO_DE_LENTEJAS.BI_Ambiente am ON (am.AMBIENTE_CODIGO = an.ANUNCIO_AMBIENTES)
            JOIN GUISO_DE_LENTEJAS.BI_Ubicacion ub ON (ub.UBICACION_CODIGO = an.ANUNCIO_UBICACION)
            JOIN GUISO_DE_LENTEJAS.BI_Tiempo ti ON (ti.TIEMPO_CODIGO = an.ANUNCIO_TIEMPO_INICIO)
            JOIN GUISO_DE_LENTEJAS.BI_Tiempo ti2 ON (ti2.TIEMPO_CODIGO = an.ANUNCIO_TIEMPO_FIN)
            GROUP BY tiop.TIPO_OPERACION_DESCRIPCION ,ub.UBICACION_BARRIO, am.AMBIENTE_DESCRIPCION,ti.TIEMPO_ANIO, ti.TIEMPO_CUATRIMESTRE
GO


--Vista 2: Precio Promedio Publicacion
/* Precio promedio de los anuncios de inmuebles según el tipo de operación
(alquiler, venta, etc), tipo de inmueble y rango m2 para cada cuatrimestre/año.
Se consideran todos los anuncios que se dieron de alta en ese cuatrimestre. El
precio se debe expresar en el tipo de moneda que corresponda, identificando de
cuál se trata.*/
CREATE VIEW GUISO_DE_LENTEJAS.BI_PRECIO_PROMEDIO_PUBLICACION_ANUNCIO AS
    SELECT  tiop.TIPO_OPERACION_DESCRIPCION, 
		tiim.TIPO_INMUEBLE_DESCRIPCION, 
		rm2.RANGO_M2_DESCRIPCION, 
		ti.TIEMPO_ANIO, 
		ti.TIEMPO_CUATRIMESTRE, 
		timo.TIPO_MONEDA_DESCRIPCION,
		CAST(SUM(an.ANUNCIO_PRECIO) / SUM(an.ANUNCIO_CANT_ANUNCIOS_AGRUPADOS) AS numeric(18,2)) AS 'Precio Promedio Publicacion'
		FROM GUISO_DE_LENTEJAS.BI_Hecho_Anuncio an
		JOIN GUISO_DE_LENTEJAS.BI_Tipo_Operacion tiop ON (tiop.TIPO_OPERACION_ID = an.ANUNCIO_TIPO_OPERACION)
		JOIN GUISO_DE_LENTEJAS.BI_Tipo_Inmueble tiim ON (tiim.TIPO_INMUEBLE_ID = an.ANUNCIO_TIPO_INMUEBLE)
		JOIN GUISO_DE_LENTEJAS.BI_Rango_M2 rm2 ON (rm2.RANGO_M2_CODIGO = an.ANUNCIO_RANGO_M2)
        JOIN GUISO_DE_LENTEJAS.BI_Tiempo ti ON (ti.TIEMPO_CODIGO = an.ANUNCIO_TIEMPO_INICIO)
        JOIN GUISO_DE_LENTEJAS.BI_Tipo_Moneda timo ON (timo.TIPO_MONEDA_ID = an.ANUNCIO_TIPO_MONEDA)
		GROUP BY tiop.TIPO_OPERACION_DESCRIPCION, tiim.TIPO_INMUEBLE_DESCRIPCION, rm2.RANGO_M2_DESCRIPCION, ti.TIEMPO_ANIO, ti.TIEMPO_CUATRIMESTRE, timo.TIPO_MONEDA_DESCRIPCION
GO

--Vista 3: 5 barrios más elegidos
/* Los 5 barrios más elegidos para alquilar en función del rango etario de los
inquilinos para cada cuatrimestre/año. Se calcula en función de los alquileres
dados de alta en dicho periodo.*/

CREATE VIEW GUISO_DE_LENTEJAS.BI_CINCO_BARRIOS_MAS_ELEGIDOS_ALQUILER_POR_CUATRIMESTRE AS
	SELECT bt.TIEMPO_ANIO , bt.TIEMPO_CUATRIMESTRE , brei.RANGO_ETARIO_INQUILINO_DESCRIPCION , bu.UBICACION_BARRIO
	FROM GUISO_DE_LENTEJAS.BI_Hecho_Alquiler bha 
	INNER JOIN GUISO_DE_LENTEJAS.BI_Rango_Etario_Inquilino brei ON brei.RANGO_ETARIO_INQUILINO_CODIGO = bha.ALQUILER_RANGO_ETARIO_INQUILINO
	INNER JOIN GUISO_DE_LENTEJAS.BI_Tiempo bt ON bt.TIEMPO_CODIGO = bha.ALQUILER_TIEMPO
	INNER JOIN GUISO_DE_LENTEJAS.BI_Ubicacion bu ON bu.UBICACION_CODIGO = bha.ALQUILER_UBICACION 
	GROUP BY bt.TIEMPO_ANIO , bt.TIEMPO_CUATRIMESTRE , brei.RANGO_ETARIO_INQUILINO_CODIGO , brei.RANGO_ETARIO_INQUILINO_DESCRIPCION, bu.UBICACION_CODIGO  , bu.UBICACION_BARRIO 
	HAVING bu.UBICACION_CODIGO  IN (SELECT TOP 5 ha.ALQUILER_UBICACION FROM GUISO_DE_LENTEJAS.BI_Hecho_Alquiler ha
									INNER JOIN GUISO_DE_LENTEJAS.BI_Tiempo t ON t.TIEMPO_CODIGO = ha.ALQUILER_TIEMPO  
									GROUP BY ha.ALQUILER_UBICACION, ha.ALQUILER_RANGO_ETARIO_INQUILINO , t.TIEMPO_ANIO , t.TIEMPO_CUATRIMESTRE 
									HAVING ha.ALQUILER_RANGO_ETARIO_INQUILINO = brei.RANGO_ETARIO_INQUILINO_CODIGO AND t.TIEMPO_ANIO = bt.TIEMPO_ANIO AND t.TIEMPO_CUATRIMESTRE = bt.TIEMPO_CUATRIMESTRE
									ORDER BY SUM(ha.ALQUILER_CANT_ALQUILERES_AGRUPADOS) DESC
	)
GO

-- Vista 4: Porcentaje de incumplimiento de pagos de alquiler
/*Porcentaje de incumplimiento de pagos de alquileres en término por cada
mes/año. Se calcula en función de las fechas de pago y fecha de vencimiento del
mismo. El porcentaje es en función del total de pagos en dicho periodo.*/

CREATE VIEW GUISO_DE_LENTEJAS.BI_PORCENTAJE_INCUMPLIMIENTO_PAGO_ALQUILER AS
	SELECT tv.TIEMPO_ANIO , tv.TIEMPO_MES ,CONVERT(VARCHAR,(SELECT ISNULL(SUM(bhpa1.PAGO_CANT_PAGOS_AGRUPADOS),0) FROM GUISO_DE_LENTEJAS.BI_Hecho_Pago_Alquiler bhpa1
						INNER JOIN GUISO_DE_LENTEJAS.BI_Tiempo tp1 ON tp1.TIEMPO_CODIGO = bhpa1.PAGO_FECHA_PAGO
						INNER JOIN GUISO_DE_LENTEJAS.BI_Tiempo tv1 ON tv1.TIEMPO_CODIGO = bhpa1.PAGO_FECHA_VENCIMIENTO
						WHERE DATEFROMPARTS(tv1.TIEMPO_ANIO,tv1.TIEMPO_MES, tv1.TIEMPO_DIA) < DATEFROMPARTS(tp1.TIEMPO_ANIO,tp1.TIEMPO_MES, tp1.TIEMPO_DIA) 
								AND CONCAT(tv1.TIEMPO_ANIO, tv1.TIEMPO_MES) = CONCAT(tv.TIEMPO_ANIO, tv.TIEMPO_MES))*100 / COUNT(*))+'%' AS Porcentaje 
	FROM GUISO_DE_LENTEJAS.BI_Hecho_Pago_Alquiler bhpa
	INNER JOIN GUISO_DE_LENTEJAS.BI_Tiempo tp ON tp.TIEMPO_CODIGO = bhpa.PAGO_FECHA_PAGO
	INNER JOIN GUISO_DE_LENTEJAS.BI_Tiempo tv ON tv.TIEMPO_CODIGO = bhpa.PAGO_FECHA_VENCIMIENTO 
	GROUP BY  tv.TIEMPO_ANIO  , tv.TIEMPO_MES 
GO

--Vista 5: Porcentaje promedio de incremento del valor de los alquileres
/*Porcentaje promedio de incremento del valor de los alquileres para los
contratos en curso por mes/año. Se calcula tomando en cuenta el último pago
con respecto al del mes en curso, únicamente de aquellos alquileres que hayan
tenido aumento y están activos.*/
CREATE VIEW GUISO_DE_LENTEJAS.BI_PORCENTAJE_INCREMENTO_ALQUILERES AS
	SELECT t.TIEMPO_ANIO, t.TIEMPO_MES  , ISNULL(CAST(((SUM(pa.PAGO_AUMENTO) / SUM(pa.PAGO_CANT_PAGOS_AGRUPADOS))*100 / (SELECT SUM(pa.PAGO_CANT_PAGOS_AGRUPADOS) FROM GUISO_DE_LENTEJAS.BI_Hecho_Pago_Alquiler pa2
																		INNER JOIN GUISO_DE_LENTEJAS.BI_Tiempo t2 ON t2.TIEMPO_CODIGO = pa2.PAGO_FECHA_PAGO
																		GROUP BY t2.TIEMPO_ANIO, t2.TIEMPO_MES
																		HAVING DATEDIFF(MONTH,DATEFROMPARTS(t2.TIEMPO_ANIO, t2.TIEMPO_MES, 1),DATEFROMPARTS(t.TIEMPO_ANIO,t.TIEMPO_MES,1)) = 1)) AS numeric(18,2)),0) AS Porcentaje FROM GUISO_DE_LENTEJAS.BI_Hecho_Pago_Alquiler pa
	INNER JOIN GUISO_DE_LENTEJAS.BI_Tiempo t ON t.TIEMPO_CODIGO = pa.PAGO_FECHA_PAGO
	GROUP BY t.TIEMPO_ANIO, t.TIEMPO_MES  
GO

--Vista 6: Precio promedio de m2
/*Precio promedio de m2 de la venta de inmuebles según el tipo de inmueble y
la localidad para cada cuatrimestre/año. Se calcula en función de las ventas
concretadas.*/

CREATE FUNCTION GUISO_DE_LENTEJAS.rangoM2_aNumero_fx(@rango nvarchar(15))
RETURNS numeric(18,2)
AS
BEGIN
    DECLARE @sup numeric(18,2)

    SELECT @sup = CASE 
        WHEN @rango = '<35' THEN 35
        WHEN @rango = '35-55' THEN 45
        WHEN @rango = '55-75' THEN 65
        WHEN @rango = '75-100' THEN 87.5
        ELSE 100
    END

    RETURN @sup
END
GO

CREATE VIEW GUISO_DE_LENTEJAS.BI_PROMEDIO_M2_VENTA AS
	SELECT bt.TIEMPO_ANIO, 
			bt.TIEMPO_CUATRIMESTRE, 
			bti.TIPO_INMUEBLE_DESCRIPCION, 
			bu.UBICACION_LOCALIDAD, 
			CAST(SUM(bhv.VENTA_PRECIO)/SUM(GUISO_DE_LENTEJAS.rangoM2_aNumero_fx(brm.RANGO_M2_DESCRIPCION) * bhv.VENTA_CANT_VENTAS_AGRUPADAS) AS numeric(18,2)) AS 'Precio Promedio M2'
	FROM GUISO_DE_LENTEJAS.BI_Hecho_Venta bhv 
	INNER JOIN GUISO_DE_LENTEJAS.BI_Tipo_Inmueble bti ON bti.TIPO_INMUEBLE_ID = bhv.VENTA_TIPO_INMUEBLE
	INNER JOIN GUISO_DE_LENTEJAS.BI_Ubicacion bu ON bu.UBICACION_CODIGO = bhv.VENTA_UBICACION
	INNER JOIN GUISO_DE_LENTEJAS.BI_Tiempo bt ON bt.TIEMPO_CODIGO = bhv.VENTA_TIEMPO 
	INNER JOIN GUISO_DE_LENTEJAS.BI_Rango_M2 brm ON brm.RANGO_M2_CODIGO = bhv.VENTA_RANGO_M2
	GROUP BY bt.TIEMPO_ANIO, bt.TIEMPO_CUATRIMESTRE, bti.TIPO_INMUEBLE_ID, bti.TIPO_INMUEBLE_DESCRIPCION, bu.UBICACION_LOCALIDAD
GO

--Vista 7:
/*Valor promedio de la comisión según el tipo de operación (alquiler, venta, etc)
y sucursal para cada cuatrimestre/año. Se calcula en función de los alquileres y
ventas concretadas dentro del periodo.*/
CREATE VIEW GUISO_DE_LENTEJAS.BI_PROMEDIO_COMISION_OPERACION_CUATRIMESTRE AS
	SELECT bt.TIEMPO_ANIO, 
			bt.TIEMPO_CUATRIMESTRE, 
			bs.SUCURSAL_NOMBRE, 
			CAST(SUM(bha.ALQUILER_COMISION) / SUM(bha.ALQUILER_CANT_ALQUILERES_AGRUPADOS) AS numeric(18,2)) AS 'Promedio Comision', 
			'Alquiler' AS TipoOperacion
	FROM GUISO_DE_LENTEJAS.BI_Hecho_Alquiler bha
	INNER JOIN GUISO_DE_LENTEJAS.BI_Tiempo bt ON bt.TIEMPO_CODIGO = bha.ALQUILER_TIEMPO
	INNER JOIN GUISO_DE_LENTEJAS.BI_Sucursal bs ON bs.SUCURSAL_CODIGO = bha.ALQUILER_SUCURSAL
	GROUP BY bt.TIEMPO_ANIO , bt.TIEMPO_CUATRIMESTRE , bs.SUCURSAL_CODIGO , bs.SUCURSAL_NOMBRE 
	UNION ALL
	SELECT bt.TIEMPO_ANIO, 
			bt.TIEMPO_CUATRIMESTRE, 
			bs.SUCURSAL_NOMBRE, 
			CAST(SUM(bhv.VENTA_COMISION) / SUM(bhv.VENTA_CANT_VENTAS_AGRUPADAS) AS numeric(18,2)) AS 'Promedio Comision', 
			'Venta' AS TipoOperacion
	FROM GUISO_DE_LENTEJAS.BI_Hecho_Venta bhv
	INNER JOIN GUISO_DE_LENTEJAS.BI_Tiempo bt ON bt.TIEMPO_CODIGO = bhv.VENTA_TIEMPO 
	INNER JOIN GUISO_DE_LENTEJAS.BI_Sucursal bs ON bs.SUCURSAL_CODIGO = bhv.VENTA_SUCURSAL
	GROUP BY bt.TIEMPO_ANIO , bt.TIEMPO_CUATRIMESTRE , bs.SUCURSAL_CODIGO , bs.SUCURSAL_NOMBRE 
GO

--Vista 8:
/*Porcentaje de operaciones concretadas (tanto de alquileres como ventas) por
cada sucursal, según el rango etario de los empleados por año en función de la
cantidad de anuncios publicados en ese mismo año.*/

CREATE VIEW GUISO_DE_LENTEJAS.BI_PORCENTAJE_DE_OPERACIONES_CONCRETADAS AS
	SELECT Resultado.TIEMPO_ANIO, Resultado.SUCURSAL_NOMBRE, Resultado.RANGO_ETARIO_AGENTE_DESCRIPCION, CAST(SUM(Resultado.Cantidad)*100/(SELECT SUM(an.ANUNCIO_CANT_ANUNCIOS_AGRUPADOS)
																																								FROM GUISO_DE_LENTEJAS.BI_Hecho_Anuncio an
																																								JOIN GUISO_DE_LENTEJAS.BI_Tiempo ti2 ON (ti2.TIEMPO_CODIGO = an.ANUNCIO_TIEMPO_INICIO)
																																								WHERE ti2.TIEMPO_ANIO = Resultado.TIEMPO_ANIO
																																								GROUP BY ti2.TIEMPO_ANIO) AS numeric(6,2)) AS PorcentajeConcretadas
	FROM (SELECT  ti.TIEMPO_ANIO, 
			su.SUCURSAL_NOMBRE, 
			ret.RANGO_ETARIO_AGENTE_DESCRIPCION, 
			SUM(ven.VENTA_CANT_VENTAS_AGRUPADAS) AS Cantidad
			FROM GUISO_DE_LENTEJAS.BI_Hecho_Venta ven
			JOIN GUISO_DE_LENTEJAS.BI_Tiempo ti ON (ti.TIEMPO_CODIGO = ven.VENTA_TIEMPO)
			JOIN GUISO_DE_LENTEJAS.BI_Sucursal su ON (su.SUCURSAL_CODIGO = ven.VENTA_SUCURSAL)
			JOIN GUISO_DE_LENTEJAS.BI_Rango_Etario_Agente ret ON (ret.RANGO_ETARIO_AGENTE_CODIGO = ven.VENTA_RANGO_ETARIO_AGENTE)
			GROUP BY ti.TIEMPO_ANIO, su.SUCURSAL_CODIGO, su.SUCURSAL_NOMBRE, ret.RANGO_ETARIO_AGENTE_DESCRIPCION
	UNION
	SELECT  ti.TIEMPO_ANIO, 
			su.SUCURSAL_NOMBRE, 
			ret.RANGO_ETARIO_AGENTE_DESCRIPCION, 
			SUM(al.ALQUILER_CANT_ALQUILERES_AGRUPADOS) AS Cantidad
			FROM GUISO_DE_LENTEJAS.BI_Hecho_Alquiler al
			JOIN GUISO_DE_LENTEJAS.BI_Tiempo ti ON (ti.TIEMPO_CODIGO = al.ALQUILER_TIEMPO)
			JOIN GUISO_DE_LENTEJAS.BI_Sucursal su ON (su.SUCURSAL_CODIGO = al.ALQUILER_SUCURSAL)
			JOIN GUISO_DE_LENTEJAS.BI_Rango_Etario_Agente ret ON (ret.RANGO_ETARIO_AGENTE_CODIGO = al.ALQUILER_RANGO_ETARIO_AGENTE)
			GROUP BY ti.TIEMPO_ANIO, su.SUCURSAL_CODIGO, su.SUCURSAL_NOMBRE, ret.RANGO_ETARIO_AGENTE_DESCRIPCION
	) AS Resultado GROUP BY Resultado.TIEMPO_ANIO, Resultado.SUCURSAL_NOMBRE, Resultado.RANGO_ETARIO_AGENTE_DESCRIPCION
GO

--Vista 9: Monto cierre de contratos por tipo de operación
/*Monto total de cierre de contratos por tipo de operación (tanto de alquileres
como ventas) por cada cuatrimestre y sucursal, diferenciando el tipo de moneda.*/

CREATE VIEW GUISO_DE_LENTEJAS.BI_TOTAL_CIERRE_CONTRATOS_OPERACION_CUATRIMESTRE AS
    SELECT bt.TIEMPO_CUATRIMESTRE , bs.SUCURSAL_NOMBRE, timo.TIPO_MONEDA_DESCRIPCION, SUM(bha.ALQUILER_DEPOSITO) AS TotalCierre, 'Alquiler' AS [Tipo Operación]
	    FROM GUISO_DE_LENTEJAS.BI_Hecho_Alquiler bha
	    INNER JOIN GUISO_DE_LENTEJAS.BI_Tiempo bt ON bt.TIEMPO_CODIGO = bha.ALQUILER_TIEMPO
	    INNER JOIN GUISO_DE_LENTEJAS.BI_Sucursal bs ON bs.SUCURSAL_CODIGO = bha.ALQUILER_SUCURSAL
	    JOIN GUISO_DE_LENTEJAS.BI_Tipo_Moneda timo ON timo.TIPO_MONEDA_ID = bha.ALQUILER_TIPO_MONEDA
	    GROUP BY bt.TIEMPO_CUATRIMESTRE , bs.SUCURSAL_CODIGO , bs.SUCURSAL_NOMBRE , timo.TIPO_MONEDA_DESCRIPCION
    UNION ALL
    SELECT bt.TIEMPO_CUATRIMESTRE , bs.SUCURSAL_NOMBRE, timo.TIPO_MONEDA_DESCRIPCION, SUM(bhv.VENTA_PRECIO) AS TotalCierre, 'Venta' AS [Tipo Operación]
	    FROM GUISO_DE_LENTEJAS.BI_Hecho_Venta bhv
	    INNER JOIN GUISO_DE_LENTEJAS.BI_Tiempo bt ON bt.TIEMPO_CODIGO = bhv.VENTA_TIEMPO 
	    INNER JOIN GUISO_DE_LENTEJAS.BI_Sucursal bs ON bs.SUCURSAL_CODIGO = bhv.VENTA_SUCURSAL
	    JOIN GUISO_DE_LENTEJAS.BI_Tipo_Moneda timo ON timo.TIPO_MONEDA_ID = bhv.VENTA_TIPO_MONEDA
	    GROUP BY  bt.TIEMPO_CUATRIMESTRE , bs.SUCURSAL_CODIGO , bs.SUCURSAL_NOMBRE, timo.TIPO_MONEDA_DESCRIPCION
GO 

