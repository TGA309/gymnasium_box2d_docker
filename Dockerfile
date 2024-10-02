# Use an official Python base image with version 3.11.9
FROM python:3.11.9-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    g++ \
    python3-dev \
    swig \
    && rm -rf /var/lib/apt/lists/*

# Install gymnasium and additional dependencies
RUN pip install --upgrade pip
RUN pip install gymnasium[box2d]

# Set the working directory inside the container
WORKDIR /workspace

# Copy your project files into the container (including the src directory)
COPY . /workspace

# Check if requirements.txt exists and install dependencies
RUN if [ -f /workspace/src/requirements.txt ]; then pip install -r /workspace/src/requirements.txt; fi