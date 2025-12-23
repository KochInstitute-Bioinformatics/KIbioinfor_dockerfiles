FROM continuumio/miniconda3:23.10.0-1

LABEL maintainer="charliew@mit.edu"
LABEL description="MAGeCK, samtools, and bowtie2 for CRISPR screen analysis"
LABEL version="1.0"

# Install tools via conda-forge and bioconda
RUN conda install -c conda-forge -c bioconda \
        mageck \
        bowtie2 \
        samtools \
        && conda clean -a

# Verify installations
RUN mageck --version && \
    samtools --version && \
    bowtie2 --version