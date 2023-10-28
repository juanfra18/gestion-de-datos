#!/usr/bin/env sh
cd scripts_individuales
cat 0-Limpieza.sql 01-CreacionSchema.sql 02-CreacionTablas.sql 03-CreacionPKs.sql 04-CreacionFKs.sql 05-Migracion.sql > script_creacion_inicial.sql
