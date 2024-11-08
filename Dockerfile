FROM node:16.10 AS build
WORKDIR /build
COPY package*.json ./
RUN yarn install
COPY . .
ARG SERVER_URL=http://127.0.0.1:8000/
RUN echo "export const SERVER_URL = '${SERVER_URL}';" > src/constants.js
RUN yarn build

FROM nginx:alpine
WORKDIR /app
COPY --from=build /build/build .
COPY nginx.conf /etc/nginx/nginx.conf
