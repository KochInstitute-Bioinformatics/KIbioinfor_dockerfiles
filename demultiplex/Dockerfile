# Use the official biocontainer for demultiplex as base
FROM quay.io/biocontainers/demultiplex:1.2.2--pyhdfd78af_1

# Add metadata labels for better documentation
LABEL maintainer="charliew@mit.edu"
LABEL description="Demultiplex tool for sequence demultiplexing - Nextflow compatible"
LABEL version="1.2.2"
LABEL base_image="quay.io/biocontainers/demultiplex:1.2.2--pyhdfd78af_1"

# Verify the tool is installed and accessible
RUN demultiplex --help || demultiplex --version || which demultiplex
