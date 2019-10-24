FROM node:12-slim

# Production
# docker build =t myapp:prod --target prod .
ENV NODE_ENV=production
# MAKE YOUR APP LISTEN TO EXTERNAL COMMANDS
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]
EXPOSE 3000
RUN mdkir /app && chown -R node:node /app
WORKDIR /app
COPY --chown=node:nonde package.json package-lock*.json ./
RUN npm install && npm cache clean --force
COPY --chown=node:node . . 
CMD ["node", "./bin/www"]

# Development
# docker build -t myapp .
FROM prod as dev
ENV NODE_ENV=development
ENV PATH=/app/node_modules/.bin:$PATH
RUN npm install --only=developmebt
# NOTE CHANGE ENTRYPOINT
CMD ["nodemon", "./bin/www", "--inpect=0.0.0.0:9229"]
