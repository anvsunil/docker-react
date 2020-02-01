FROM node:alpine as builder
#Everything below this statement is referred as build phase
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#/app/build <-- will have all the stuff we need for production

FROM nginx
#We do not have to use "as" like previous block because FROM indicates
#termination of previous block
COPY --from=builder /app/build  /usr/share/nginx/html
#If you want to host simple static content as per nginx documentation
#use the folder /usr/share/nginx/html
#We do not need to use CMD command for start nginx by default it will be started 
