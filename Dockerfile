# frontend buildstage

FROM node:18 AS frontend-build
WORKDIR /app/client
COPY client/package*.json ./
RUN npm install
COPY client/ ./
RUN npm run build

# backend buildstage / server build stage

FROM node:18 AS backend
WORKDIR /app
COPY server/package*.json ./
RUN cd server && npm install
COPY server/ ./server/
COPY  --from=frontend-build /app/client/build ./server/public
EXPOSE 5000
CMD [ "node", "server/index.js" ]