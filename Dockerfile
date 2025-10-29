# Multi-stage build for React frontend
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Set npm configurations
ENV NPM_CONFIG_LOGLEVEL=error
ENV NPM_CONFIG_FETCH_TIMEOUT=60000

# Install dependencies
# Using npm install for better compatibility when package-lock.json might not be present
RUN npm install --prefer-offline --no-audit --legacy-peer-deps; \
    if [ ! -d "node_modules" ]; then \
        echo "First install failed, retrying..."; \
        rm -rf /root/.npm /app/node_modules; \
        npm install --no-audit --legacy-peer-deps; \
    fi

# Copy application source
COPY . .

# Build the application
RUN npm run build

# Production stage with nginx
FROM nginx:alpine AS production

# Install wget for healthchecks
RUN apk add --no-cache wget

# Copy built assets from builder
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
