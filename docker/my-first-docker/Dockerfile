FROM node:20.12.1-alpine3.18

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci

COPY index.js ./

ENTRYPOINT ["node", "index.js"]
