#!/bin/bash
# Script para compilar y ejecutar la aplicación Scraper

echo "--- 1. Compilando el código modificado (mvn compile) ---"
mvn compile

if [ $? -eq 0 ]; then
    echo "--- 2. Ejecutando la aplicación Java ---"
    # Ejecutamos la clase principal, incluyendo las dependencias en el classpath
    mvn exec:java -Dexec.mainClass="com.digi.Scraper"
else
    echo "!!! ERROR: Falló la compilación. Revisa tu código Java."
fi