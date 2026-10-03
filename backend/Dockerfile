FROM node:20-alpine as build
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm install && npm cache clean --force
#production
FROM node:20-alpine as production
RUN addgroup -S appgroup && adduser -S appuser -G appgroup # creating system user and system group and adding th user to the group.
RUN apk --no-cache add dumb-init  #  node doesnot have a speacial handler to procees PID 1 so dumbinit used. when ever we say docker stop then SIGTERM is sent to dumbinit and it send to node as PID 15. PID 1 doesnot kill the process so quickly beacuse linux kernel  waits for its own handling of PID 1 killing procees
WORKDIR /app
COPY --from=build /app/node_modules ./node_modules
COPY src/ ./src
RUN chown -R appuser:appgroup /app
USER appuser
EXPOSE 5000
ENTRYPOINT ["dumb-init", "--"]
CMD ["node", "src/index.js"]
