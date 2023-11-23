#!/usr/bin/env sh
cat 0-Limpieza.sql 01-CreacionSchema.sql 02-CreacionTablas.sql 03-CreacionPKs.sql 04-CreacionFKs.sql 05-Migracion.sql 06-Vistas.sql > script_creacion_BI.sql
