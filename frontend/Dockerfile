# Use the official Node.js image for building the app
FROM node:18-alpine as builder

# Set working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the app
COPY . .

# Build the app
RUN npm run build

RUN ls -R /app

# Use an Nginx image to serve the built app
FROM nginx:alpine

# Copy the built app from the builder stage
COPY --from=builder /app/dist  /usr/share/nginx/html

# Expose the port Nginx serves on
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]











