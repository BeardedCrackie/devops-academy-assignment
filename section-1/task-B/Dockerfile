# Dockerfile for a simple Flask application
# Python 3.13 slim based on Debian Trixie
FROM python:3.13.7-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY app/ .

# Expose the port the app runs on
EXPOSE 5000

# Define the command to run the application
ENTRYPOINT ["python3"]

# Run the application
CMD ["app.py"]