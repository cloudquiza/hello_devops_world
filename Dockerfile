# Use the official Python image from the Docker Hub
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the Python script into the container
COPY hello_devops.py /app

# Specify the command to run the script
CMD ["python", "hello_devops.py"]
