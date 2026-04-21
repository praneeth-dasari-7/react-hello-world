FROM node:18

WORKDIR /app

COPY package.json ./
RUN npm install

COPY . .

EXPOSE 3000

# Important for Docker
ENV HOST=0.0.0.0

CMD ["npm", "start"]