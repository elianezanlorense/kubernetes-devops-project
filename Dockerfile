# Use a slim base image to reduce the image size
FROM python:3.11-slim-buster

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file to the container
COPY requirements.txt .

# Install system dependencies required to build Python packages with C extensions
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        python3-dev \
        libpq-dev \
        libffi-dev

# Upgrade pip to a version known to work well
RUN python -m pip install --upgrade "pip<24.1"

# Install Python dependencies from the requirements file, without caching
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code to the container
COPY . .

# Command to run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]