--Borrados de FKs




--Borrado de tablas de hechos

IF OBJECT_ID('GUISO_DE_LENTEJAS.BI_Hecho_Operacion', 'U') IS NOT NULL
BEGIN
	DROP TABLE GUISO_DE_LENTEJAS.BI_Hecho_Operacion
	PRINT('Tabla GUISO_DE_LENTEJAS.BI_Hecho_Operacion eliminada')
END

IF OBJECT_ID('GUISO_DE_LENTEJAS.BI_Hecho_Anuncio', 'U') IS NOT NULL
BEGIN
	DROP TABLE GUISO_DE_LENTEJAS.BI_Hecho_Anuncio
	PRINT('Tabla GUISO_DE_LENTEJAS.BI_Hecho_Anuncio eliminada')
END

