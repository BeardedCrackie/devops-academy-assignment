DEV workspace setup using python venv

based on https://flask.palletsprojects.com/en/stable/installation/

# Python Installation

Make sure Python 3 is installed on your system. You can check your Python version with:

```bash
python3 --version
```

If Python is not installed, you can install it on Ubuntu/Debian with:

```bash
sudo apt update
sudo apt install python3 python3-venv python3-pip
```

# Python Virtual Environment Setup

To create and activate a Python virtual environment and install dependencies from `requirements.txt`, use the following commands:

```bash
# Create a virtual environment named 'venv'
python3 -m venv venv

# Activate the virtual environment
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```