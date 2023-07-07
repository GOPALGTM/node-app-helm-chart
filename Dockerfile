# Use the official Node.js image as the base image
FROM node:12

# Set the working directory inside the container
WORKDIR /app

# Copy the application code to the container
COPY . /app/

# Expose the port on which the application will run
EXPOSE 3000

# Set the command to run the application
CMD [ "npm", "start" ]
