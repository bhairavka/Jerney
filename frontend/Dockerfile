FROM node:20-alpine as build
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm install && npm cache clean --force
COPY . .
RUN npm run build

#production
FROM nginx:1.25-alpine as production
RUN rm -r /etc/nginx/conf.d/default.conf /usr/share/nginx/html/*
COPY ./nginx.conf /etc/nginx/conf.d/
COPY --from=build /app/dist /usr/share/nginx/html
RUN chown -R nginx:nginx /usr/share/nginx/html && \
     chown -R nginx:nginx /var/cache/nginx && \
     chown -R nginx:nginx /var/logs/nginx && \
     touch /var/run/nginx.pid && \
     chown -R nginx:nginx /var/run/nginx.pid
USER nginx
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]



