# base node version
FROM node:22-slim

# Creating the directory where this will will be run
WORKDIR /app

# Copying dependencies
COPY package*.json .
RUN npm install

# Copying the contents of frontend
COPY . .

# Starting the Frontend
CMD ["sh", "-c", "npm run dev -- --host 0.0.0.0"]