# Use official Python image (Debian-based)
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    gfortran \
    procps \
    git \
    wget \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --no-cache-dir \
    numpy \
    pandas \
    biopython \
    pyyaml

# Install samtools
RUN apt-get update && apt-get install -y samtools && rm -rf /var/lib/apt/lists/*

# Install bedtools
RUN apt-get update && apt-get install -y bedtools && rm -rf /var/lib/apt/lists/*

# Install minimap2 from source (latest version)
RUN cd /tmp && \
    git clone https://github.com/lh3/minimap2.git && \
    cd minimap2 && \
    make && \
    cp minimap2 /usr/local/bin/ && \
    cd .. && rm -rf minimap2

# Set the default command
CMD ["python"]