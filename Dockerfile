# Build
FROM node:13-alpine as build

WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH

COPY package.json /app/package.json

RUN npm install

RUN npm install react-scripts@3.0.1 -g

COPY . /app

RUN npm run build

# Final
FROM nginx:1.17.0-alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]