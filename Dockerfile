# Use official Node.js image as the base image
FROM node:20 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json first (to leverage Docker cache for better performance)
COPY package.json package-lock.json ./

# Install backend dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the app
RUN npm run build

# Use Nginx to serve the built files
FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html

# Remove the default Nginx static files
RUN rm -rf ./*

# Copy the build output from the previous stage
COPY --from=build /app/dist ./

# Expose port 80
EXPOSE 80

# Start Nginx server
ENTRYPOINT ["nginx", "-g", "daemon off;"]

