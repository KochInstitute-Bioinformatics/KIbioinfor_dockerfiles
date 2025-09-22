FROM condaforge/mambaforge:latest

# Set working directory
WORKDIR /data

# Install chopper via conda
RUN mamba install -c conda-forge -c bioconda \
    chopper=0.10.0 \
    python=3.11 \
    && mamba clean -a

# Install NanoPlot and dependencies via pip
RUN pip install NanoPlot

# Test chopper
RUN chopper --version

# Default command
CMD ["bash"]