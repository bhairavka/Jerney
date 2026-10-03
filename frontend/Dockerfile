FROM node:20-alpine as build
WORKDIR /app
COPY package.json package-lock.json* ./  
RUN npm install && npm cache clean --force  #install depndencies and cleams the chache to make image samll
COPY . .
RUN npm run build   # build the application

#production
FROM nginx:1.25-alpine as production
RUN rm -r /etc/nginx/conf.d/default.conf /usr/share/nginx/html/*   #deletes the default conf files and html pages
COPY ./nginx.conf /etc/nginx/conf.d/                              #copies the custom config files
COPY --from=build /app/dist /usr/share/nginx/html
RUN mkdir -p /var/cache/nginx  /var/logs/nginx  /var/run && \           # nginx normally needs root ,creating own chache, log directories as we want them to run as non root user - nginx and giving permsiion 
     chown -R nginx:nginx /usr/share/nginx/html && \
     chown -R nginx:nginx /var/cache/nginx && \
     chown -R nginx:nginx /var/logs/nginx && \
     touch /var/run/nginx.pid && \
     chown -R nginx:nginx /var/run/nginx.pid
USER nginx
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]  # demon off makes nginx keep running without going to sleep



