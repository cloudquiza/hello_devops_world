# Use the official Python image from the Docker Hub
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install required Python packages
RUN pip install --no-cache-dir openai==0.27.0 python-dotenv

# Run hello_devops.py when the container launches
CMD ["python", "hello_devops.py"]

# Build stage for the static front end
FROM nginx:latest

# Copy static HTML files into Nginx web root
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
