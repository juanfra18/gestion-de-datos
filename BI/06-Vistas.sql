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
            SUM(DATEDIFF(DAY,DATEFROMPARTS(ti.TIEMPO_ANIO,ti.TIEMPO_MES, ti.TIEMPO_DIA), DATEFROMPARTS(ti2.TIEMPO_ANIO,ti2.TIEMPO_MES,ti2.TIEMPO_DIA))) / COUNT(*) AS 'Duracion Promedio de Publicacion (dias)'
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
		SUM(an.ANUNCIO_PRECIO) / COUNT(*) AS 'Precio Promedio Publicacion'
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
									ORDER BY COUNT(*) DESC
	)
GO

-- Vista 4: Porcentaje de incumplimiento de pagos de alquiler
/*Porcentaje de incumplimiento de pagos de alquileres en término por cada
mes/año. Se calcula en función de las fechas de pago y fecha de vencimiento del
mismo. El porcentaje es en función del total de pagos en dicho periodo.*/

CREATE VIEW GUISO_DE_LENTEJAS.BI_PORCENTAJE_INCUMPLIMIENTO_PAGO_ALQUILER AS
	SELECT tv.TIEMPO_ANIO , tv.TIEMPO_MES ,CONVERT(VARCHAR,(SELECT COUNT(*) FROM GUISO_DE_LENTEJAS.BI_Hecho_Pago_Alquiler bhpa1
						INNER JOIN GUISO_DE_LENTEJAS.BI_Tiempo tp1 ON tp1.TIEMPO_CODIGO = bhpa1.PAGO_FECHA_PAGO
						INNER JOIN GUISO_DE_LENTEJAS.BI_Tiempo tv1 ON tv1.TIEMPO_CODIGO = bhpa1.PAGO_FECHA_VENCIMIENTO
						WHERE DATEFROMPARTS(tv1.TIEMPO_ANIO,tv1.TIEMPO_MES, tv1.TIEMPO_DIA) < DATEFROMPARTS(tp1.TIEMPO_ANIO,tp1.TIEMPO_MES, tp1.TIEMPO_DIA) 
								AND CONCAT(tv1.TIEMPO_ANIO, tv1.TIEMPO_MES) = CONCAT(tv.TIEMPO_ANIO, tv.TIEMPO_MES))*100 / COUNT(*))+'%' AS Porcentaje 
	FROM GUISO_DE_LENTEJAS.BI_Hecho_Pago_Alquiler bhpa
	INNER JOIN GUISO_DE_LENTEJAS.BI_Tiempo tp ON tp.TIEMPO_CODIGO = bhpa.PAGO_FECHA_PAGO
	INNER JOIN GUISO_DE_LENTEJAS.BI_Tiempo tv ON tv.TIEMPO_CODIGO = bhpa.PAGO_FECHA_VENCIMIENTO 
	GROUP BY  tv.TIEMPO_ANIO  , tv.TIEMPO_MES 
GO

