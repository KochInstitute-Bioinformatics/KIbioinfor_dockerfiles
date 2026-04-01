# R 4.5.3 + Single-Cell + Bulk RNAseq Stack
FROM rocker/verse:4.5.3

LABEL maintainer="Charlie" \
      description="Rocker Verse 4.5.3 + Seurat, DESeq2, edgeR, GSVA, ComplexHeatmap, BPCells for single-cell and bulk RNAseq"

ENV DEBIAN_FRONTEND=noninteractive \
    RENV_CONFIG_REPOS_OVERRIDE=https://cloud.r-project.org \
    R_REMOTES_NO_ERRORS_FROM_WARNINGS=true

# --- System dependencies (minimal set) ---
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    pkg-config \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libgit2-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libcairo2-dev \
    libxt-dev \
    zlib1g-dev \
    libomp-dev \
    libgsl-dev \
    libhdf5-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    libudunits2-dev \
    && rm -rf /var/lib/apt/lists/*

# --- R Package Installation ---
COPY install_packages.R /tmp/install_packages.R
RUN Rscript /tmp/install_packages.R && rm /tmp/install_packages.R

# --- Validation ---
COPY validate_packages.R /tmp/validate_packages.R
RUN Rscript /tmp/validate_packages.R && rm /tmp/validate_packages.R

WORKDIR /work
CMD ["bash"]