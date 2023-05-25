FROM node
WORKDIR /app
COPY ["package.json", "package-lock.json*", "./"]
COPY . .
EXPOSE 7555
CMD ["node", "product-api.js"]