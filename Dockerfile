# Stage 1: Build the React App
FROM node:20-alpine AS build

WORKDIR /app

# Copy package.json and package-lock.json first (Docker caching)
COPY To_do_app/package.json package-lock.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the application
COPY To_do_app/ ./

# Build the React application
RUN npm run build

# Stage 2: Serve the React App with Nginx
FROM nginx:alpine

WORKDIR /usr/share/nginx/html

# Remove default Nginx static files
RUN rm -rf ./*

# Copy the built files from the build stage
COPY --from=build /app/dist ./

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
