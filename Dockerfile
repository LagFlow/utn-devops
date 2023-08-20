# Se va a usar node 18
FROM node:18-alpine

# Creamos la carpeta para la aplicación
WORKDIR /app

# Copiamos el código de la aplicación
COPY ./nextjs-app .

# Instalamos las dependencias
RUN npm install

# Hacemos el build de producción
RUN npm run build

# Exponemos el puerto 3000 que usa la aplicación
EXPOSE 3000

# Se ejecuta la aplicación en modo producción
CMD npm run start
