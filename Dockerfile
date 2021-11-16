# Imagen de Node minificada para "servir" el código optimizado
FROM node:14-slim as prd

# Define el entorno de Node (development o production)
# Por defecto es production
ARG NODE_ENV=production
ENV NODE_ENV $NODE_ENV

# La aplicación por defecto se expone en el puerto 8000
ARG PORT=8000
ENV PORT $PORT
EXPOSE $PORT
EXPOSE 8765

# Añade un manejador de señales para aplicaciones Node
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# Instala dependencias en una carpeta distinta para el montaje de la aplicación en desarrollo local
# Configura carpeta de la aplicación con los permisos correctos
RUN mkdir /opt/app && chown node:node /opt/app
WORKDIR /opt/app

# Cambia a usuario no-root
USER node

# Copia archivos de definición de dependencias
COPY --chown=node:node package.json yarn.lock ./

# Instalar dependencias de producción
RUN rm -rf node_modules \
  && yarn install --frozen-lockfile \
  && yarn cache clean --all

# Copia los archivos de código
COPY --chown=node:node . .

CMD [ "node", "src/index.js" ]