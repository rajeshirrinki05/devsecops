#Docker file
#Build stage
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

## production stage
FROM ngnix:alpine
COPY --from=build /app/dist /usr/share/ngnix/html
EXPOSE 80
CMD ["ngnix", "-g", "daemon off;"]

	
