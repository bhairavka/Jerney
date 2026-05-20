FROM node:20-alpine as build
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci && npm cache clean --force
// production
FROM node:20-alpine as production
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN apk --no-cache add dumb-init
WORKDIR /app
COPY --from=build /app/node_modules ./node_modules
COPY src/ ./src
RUN chown -R appuser:appgroup /app
USER appuser
EXPOSE 5000
ENTRYPOINT ["dumb-init", "--"]
CMD ["npm", "src/index.js"]