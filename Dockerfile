# Base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /stable-fast-3d

# Copy project files
COPY ./stable-fast-3d /stable-fast-3d

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    build-essential \
    cmake \
    g++ \
    ninja-build && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Environment variables
ENV CXX=g++ CC=gcc

# Upgrade pip and setuptools
RUN python -m pip install --upgrade pip setuptools wheel

# Install PyTorch (adjust CPU/CUDA version as needed)
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# Install Python dependencies
COPY stable-fast-3d/requirements.txt /stable-fast-3d/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Set the entrypoint
CMD ["python", "run.py"]
