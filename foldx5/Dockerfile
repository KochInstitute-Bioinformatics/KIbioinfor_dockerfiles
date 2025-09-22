
# Use a minimal base image with necessary tools
FROM ubuntu:20.04

LABEL description="Foldx image"

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    unzip \
    libx11-6 \
    libxt6 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /opt/foldx

# Copy the FoldX zip file into the image
COPY foldx5_1Linux64.zip .

# Unzip FoldX and make the main executable runnable
RUN unzip foldx5_1Linux64.zip && \
    chmod +x foldx_20251231 && \
    unzip yasaraPlugin.zip

# Add FoldX to PATH
ENV PATH="/opt/foldx:${PATH}"

# Default command (can be overridden)
CMD ["foldx_20251231"]

