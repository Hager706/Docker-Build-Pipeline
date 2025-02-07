FROM node:14-slim

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

ENV NAME World

CMD ["node", "app.js"]