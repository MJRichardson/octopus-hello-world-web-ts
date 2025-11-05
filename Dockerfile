# Build stage
FROM node:24-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force
COPY . .

# Runtime stage
FROM node:24-alpine AS runtime
WORKDIR /app

# Create a non-root user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S appuser -u 1001

# Copy dependencies and application from build stage
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./
COPY --from=builder /app .

# Change ownership to non-root user
RUN chown -R appuser:nodejs /app
USER appuser

EXPOSE 3000

CMD ["npm", "start"]