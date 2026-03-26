FROM node:18-slim

ENV PUPPETEER_SKIP_DOWNLOAD=true

#############################################
# Use Debian-based image for Puppeteer/Chromium stability
RUN apt-get update && \
    apt-get install -y --no-install-recommends chromium && \
    rm -rf /var/lib/apt/lists/*

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# # Puppeteer v13.5.0 works with Chromium 100.
# RUN yarn add puppeteer@13.5.0

#############################################

WORKDIR /app

# Copy package metadata FIRST
COPY package.json package-lock.json ./

# Install dependencies
RUN npm ci --omit=dev

# Copy project files AFTER installing dependencies
COPY . .

CMD ["node", "./app.js"]
