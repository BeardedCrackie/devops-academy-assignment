# Minimal Flask Application

This project is a minimal web application built with [Flask](https://flask.palletsprojects.com/), a lightweight Python web framework.  
It demonstrates basic usage of Flask and can be run either with Docker Compose or directly using Python virtual environments.

based on [Flask - A Minimal Application](https://flask.palletsprojects.com/en/stable/quickstart/#a-minimal-application)

> **Note:**  
> An example log output after running the app with Docker Compose can be found in the `cli.log` file.

# Running with Docker Compose

**Requirements:**  
- [Docker Engine installed](https://docs.docker.com/engine/install/)
- Docker Compose (included with recent Docker versions)

You can run the application using Docker Compose, which will handle building the Docker image and starting the container for you.

## Build and Run

To build the Docker image and start the application, run:

```bash
docker compose up --build
```

This command will:
- Build the Docker image as defined in the `Dockerfile`.
- Start the container as defined in `docker-compose.yml`.
- The app will be available at `http://127.0.0.1:5000/`.

## Stopping the Containers

To stop the running containers, press `Ctrl+C` in the terminal where Docker Compose is running, or run:

```bash
docker compose down
```

This will stop and remove the containers created by Docker Compose.

# Running using python venv

## Python Installation

**Requirements:**  
- Python 3  
- pip  
- venv module

Make sure Python 3 is installed on your system. You can check your Python version with:

```bash
python3 --version
```

If Python is not installed, you can install it on Ubuntu/Debian with:

```bash
sudo apt update
sudo apt install python3 python3-venv python3-pip
```

## Python Virtual Environment Setup

To create and activate a Python virtual environment and install dependencies from `requirements.txt`, use the following commands:

```bash
# Create a virtual environment named 'venv'
python3 -m venv venv

# Activate the virtual environment
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

## Starting the Flask App via venv

After setting up the virtual environment and installing dependencies, you can start the Flask application with:

```bash
# Activate the virtual environment
source venv/bin/activate

# Run the Flask app
flask run
```

By default, the app will be available at `http://127.0.0.1:5000/`. You can access it from your web browser.
