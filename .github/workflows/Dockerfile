# Use an official Node.js runtime as a parent image
FROM node:20-alpine AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY To_do_app/package.json To_do_app/package-lock.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the application
COPY To_do_app ./

# Build the React app
RUN npm run build

# Use Nginx to serve the built files
FROM nginx:alpine

# Set working directory
WORKDIR /usr/share/nginx/html

# Remove default Nginx static files
RUN rm -rf ./*

# Copy the built files from the previous stage
COPY --from=build /app/dist ./

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
