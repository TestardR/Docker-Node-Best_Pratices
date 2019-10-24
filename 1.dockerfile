FROM node:12-slim

EXPOSE 3000

RUN mdkir /app && chown -R node:node /app

WORKDIR /app

COPY --chown=node:nonde package.json package-lock*.json ./

RUN npm install && npm cache clean --force

COPY --chown=node:node . . 

CMD ["npm", "start"]