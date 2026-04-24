# -------- Stage 1: Install dependencies --------
FROM node:18-alpine AS deps

WORKDIR /app

COPY package*.json ./

# Install only production dependencies
RUN npm install --omit=dev


# -------- Stage 2: Runtime --------
FROM node:18-alpine

WORKDIR /app

# Copy only node_modules from deps stage
COPY --from=deps /app/node_modules ./node_modules

# Copy application source
COPY . .

EXPOSE 3000

ENV NODE_ENV=production
ENV HOST=0.0.0.0

CMD ["npm", "start"]