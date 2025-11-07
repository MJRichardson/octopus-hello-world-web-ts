# Build stage
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./
COPY tsconfig.json ./

# Install all dependencies (including dev dependencies for building)
RUN npm ci

# Copy source code
COPY src/ ./src/

# Build the TypeScript application
RUN npm run build

# Production stage
FROM node:20-alpine AS production

WORKDIR /app

# Create non-root user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S appuser -u 1001

# Copy package files
COPY package*.json ./

# Install only production dependencies
RUN npm ci --only=production && npm cache clean --force

# Copy built application from build stage
COPY --from=builder /app/dist ./dist

# Copy static files 
COPY src/views/ ./dist/views
COPY public public 

# Change ownership to non-root user
RUN chown -R appuser:nodejs /app
USER appuser

# Expose the port your Express app runs on
EXPOSE 3000

# Start the application
CMD ["node", "dist/app.js"]