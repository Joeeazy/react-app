# Use official Node.js image as the base image
FROM node:18

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json first (to leverage Docker cache for better performance)
COPY package.json ./

# Install backend dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Command to run the app
RUN npm run build

# server with nginx
FROM nginx:1-23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build /app/build .
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "deamon off;"]
