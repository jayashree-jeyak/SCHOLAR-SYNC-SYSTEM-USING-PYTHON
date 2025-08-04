# Use official Node.js image
FROM node:18-slim  

# Set the working directory in the container
WORKDIR /app  

# Install Cloudflare Tunnel (cloudflared)
RUN apt-get update && apt-get install -y curl && \
    curl -fsSL https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared  

# Copy package.json and install dependencies
COPY package.json package-lock.json ./  
RUN npm install  

# Copy all application files
COPY . .  

# Expose the port your Node.js app runs on
EXPOSE 8000  

# Run both the Node.js app and Cloudflare Tunnel
CMD ["sh", "-c", "npm start & cloudflared tunnel --url http://localhost:8000"]
