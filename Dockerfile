# Use an official Python base image with version 3.11.9
FROM python:3.11.9-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    g++ \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    libx11-xcb1 \
    python3-dev \
    python3-opengl \
    swig \
    xvfb \
    x11-apps \
    libglib2.0-0 \
    libglib2.0-dev \
    && rm -rf /var/lib/apt/lists/* \
    && ldconfig \
    && ls -l /usr/lib/x86_64-linux-gnu/libGL.so* \
    && ls -l /usr/lib/x86_64-linux-gnu/libgthread-2.0.so*

# Install gymnasium and additional dependencies
RUN pip install --upgrade pip
RUN pip install gymnasium[box2d]

# Set the working directory inside the container
WORKDIR /workspace

# Copy your project files into the container (including the src directory)
COPY . /workspace

# Check if requirements.txt exists and install dependencies
RUN if [ -f /workspace/src/requirements.txt ]; then pip install -r /workspace/src/requirements.txt; fi