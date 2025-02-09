FROM node:14-slim

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the application port
EXPOSE 3000

# Set environment variables
ENV NAME World

# Run the application
CMD ["node", "app.js"]