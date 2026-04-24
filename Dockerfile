# -------- Stage 1: Install dependencies --------
FROM node:18-alpine AS deps

WORKDIR /app

COPY package*.json ./

# Install all deps (including dev for safety)
RUN npm install


# -------- Stage 2: Production image --------
FROM node:18-alpine

WORKDIR /app

# Copy only necessary files from deps stage
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Remove dev dependencies to reduce size
RUN npm prune --production

EXPOSE 3000

ENV HOST=0.0.0.0

CMD ["npm", "start"]