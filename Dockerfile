# Use official Node.js image as the base image
FROM node:20 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json first
COPY package.json package-lock.json ./

# Set environment to production for optimized builds
ENV NODE_ENV=production

# Install backend dependencies
RUN npm ci

# Copy the rest of the application code
COPY . .

# Build the app
RUN npm run build

# Use Nginx to serve the built files
FROM nginx:1.23-alpine

# Remove the default Nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy the build output from the previous stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
ENTRYPOINT ["nginx", "-g", "daemon off;"]

