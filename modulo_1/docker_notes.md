11:19 AM

Resumen
Comando	Uso Principal
docker run	Crear y ejecutar contenedores
docker ps	Listar contenedores activos
docker stop/start	Detener/iniciar contenedores
docker exec	Ejecutar comandos dentro de contenedores
docker logs	Ver registros del contenedor
docker images	Ver imágenes locales
docker build	Construir imágenes desde un Dockerfile
docker pull/push	Descargar/subir imágenes de/para Docker Hub
docker rm/rmi	Eliminar contenedores e imágenes
docker volume	Manejar almacenamiento persistente
docker-compose up/down	Gestionar múltiples contenedores con Docker Compose
docker network	Crear y gestionar redes de contenedores

docker images // muestras las imagines
docker run <image:version> // corre la imagen con la version correspondiente



docker run <image_name> // corre una imagen que esté en docker con ese nombre
docker run -it <image_name> bash // corre una imagen en modo iteractivo y utiliza el bash, la consola para interactuar. Es decir, te levanta la consola
docker run -it python:3.9 // corre una imagen en modo iteractivo y utiliza el bash, la consola para interactuar. Es decir, te levanta la consola
docker run -it --entrypoint=bash python:3.11 // corre la imagen python version 3.11, en modo interactivo y utlizando bash. Es decir, levanta el contenedor entorno ubuntu donde está python. Por defecto el modo interactivo de pyton es la consola de python para ejecutar scripts.
docker build -t test:pandas . // construye una imagen nueva a partir de una existente esta se va a llamar test:pandas (-t). El "." indica que el docker file esta en la dirección donde está parado el bash




1. docker run
Ejecuta un contenedor a partir de una imagen.

docker run -d -p 8080:80 --name mi_nginx nginx
	• -d: Ejecuta el contenedor en segundo plano (modo detached).
	• -p 8080:80: Redirige el puerto 8080 del host al puerto 80 del contenedor.
	• --name mi_nginx: Nombra el contenedor como mi_nginx.
	• nginx: Imagen que se usará (si no está localmente, la descarga de Docker Hub).
📌 Resultado: Accedes a Nginx desde http://localhost:8080.

2. docker ps
Lista los contenedores en ejecución.

docker ps
	• Muestra ID, nombre, puertos y estado de los contenedores activos.
🔍 Ver todos los contenedores (incluidos los detenidos):

docker ps -a

3. docker stop
Detiene un contenedor en ejecución.

docker stop mi_nginx
	• Detiene el contenedor llamado mi_nginx.
🛑 Para detener varios contenedores:

bash
Copy code
docker stop contenedor1 contenedor2

4. docker start / docker restart
Inicia o reinicia un contenedor detenido.

docker start mi_nginx
docker restart mi_nginx
	• start: Solo inicia el contenedor.
	• restart: Detiene e inicia nuevamente.

5. docker exec
Ejecuta comandos dentro de un contenedor en ejecución.

docker exec-it mi_nginx bash
	• -it: Permite interacción con el contenedor (modo interactivo).
	• bash: Abre una terminal dentro del contenedor.
💡 Ejemplo rápido: Ver archivos dentro del contenedor:

bash
Copy code
docker execmi_nginx ls/usr/share/nginx/html

6. docker logs
Consulta los logs de un contenedor.

docker logs mi_nginx
	• Muestra los registros de salida estándar (stdout) del contenedor.
📊 Ver logs en tiempo real:

docker logs -f mi_nginx

7. docker images
Muestra todas las imágenes disponibles localmente.

docker images

📦 Eliminar imágenes no utilizadas:

docker image prune

8. docker build
Construye una imagen personalizada desde un Dockerfile.

docker build -t mi_app:1.0 .
	• -t mi_app:1.0: Asigna nombre y versión a la imagen.
	• .: Indica que el Dockerfile está en el directorio actual.
📌 Usado para crear entornos personalizados.

9. docker pull
Descarga una imagen desde Docker Hub u otro repositorio.

docker pull mysql:8.0
	• Descarga la imagen de MySQL versión 8.0.
📦 Imagen más reciente (latest):

docker pull ubuntu

10. docker push
Sube una imagen al registro (Docker Hub u otro).

docker tag mi_app usuario/mi_app:1.0
docker push usuario/mi_app:1.0
	• tag: Asocia la imagen a tu cuenta de Docker Hub.
	• push: Sube la imagen.

11. docker rm y docker rmi
Elimina contenedores e imágenes.

docker rmmi_nginx
🗑️ Eliminar una imagen:

docker rmi nginx
🛠️ Eliminar todo lo que no está en uso:

docker system prune -a

12. docker volume
Gestiona volúmenes para almacenamiento persistente.
📦 Crear volumen:

docker volume create mi_volumen
📦 Montar volumen en un contenedor:

docker run -d -v mi_volumen:/datos --name contenedor_con_datos ubuntu
	• -v mi_volumen:/datos: Monta el volumen en /datos.

13. docker-compose up y down
Levanta y baja múltiples contenedores definidos en docker-compose.yml.

docker-compose up -d
docker-compose down
💡 Ideal para levantar entornos complejos (BD + app + frontend).

14. docker network
Gestiona redes entre contenedores.
🔗 Crear red:

docker network create mi_red
🔗 Conectar contenedor a una red:

docker run -d --network mi_red --name contenedor1 nginx
