# Usa una imagen base de Java 17 ligera
FROM eclipse-temurin:17-jdk-focal

# Instala Maven, la herramienta para construir el proyecto
RUN apt-get update && apt-get install -y maven coreutils

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos de configuración de Maven (pom.xml) primero para aprovechar el cache de Docker
COPY pom.xml .

# Descarga e instala las dependencias en una carpeta 'lib'
RUN mvn dependency:copy-dependencies -DoutputDirectory=lib

# Copia el código fuente (debe estar en src/main/java/com/fp/ia/Scraper.java)
COPY src/ /app/src/
COPY index.html .

# Copia el script de ejecución y dale permisos de ejecución
COPY run.sh .
RUN chmod +x run.sh

# Ejecutamos la compilación inicial para verificar dependencias
# Esto ya crea la carpeta 'target', aunque el JAR final se creará después.
RUN mvn compile

# Comando de ENTRADA: Mantiene el contenedor vivo
# Utiliza un sleep infinito para que el contenedor no se detenga.
ENTRYPOINT ["tail", "-f", "/dev/null"]