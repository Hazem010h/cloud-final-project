FROM node
WORKDIR /app
COPY ["package.json", "package-lock.json*", "./"]
COPY . .
CMD ["node", "users-api.js"]