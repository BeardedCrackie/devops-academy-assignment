FROM ubuntu:20.04
RUN apt-get update && apt-get install -y nodejs npm
COPY . /app
WORKDIR /app
RUN npm install
CMD ["node", "index.js"]