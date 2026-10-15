# R 4.6.1 + Single-Cell + Bulk RNAseq Stack
#
# Each install step is a named stage, cached separately. To build only up to
# one stage (e.g. to debug the next one interactively):
#   docker build --target bioc -t r461-debug .
#   docker run --rm -it r461-debug bash

FROM rocker/verse:4.6.1 AS base

LABEL maintainer="Charlie" \
      description="Rocker Verse 4.6.1 + single-cell and bulk RNA-seq packages"

ENV DEBIAN_FRONTEND=noninteractive

# Parallel R package installs. Lower if compiles get killed for lack of memory:
#   docker build --build-arg NCPUS=2 .
ARG NCPUS=4
# ARGs don't carry into later stages; ENV does
ENV NCPUS=${NCPUS}

# --- System dependencies for R packages ---
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
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
    libtiff-dev \
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

COPY install_packages.R /opt/r-setup/install_packages.R

# --- CRAN (P3M binaries) ---
FROM base AS cran
COPY packages/cran.txt /opt/r-setup/packages/cran.txt
RUN Rscript /opt/r-setup/install_packages.R cran /opt/r-setup/packages/cran.txt

# --- Bioconductor ---
FROM cran AS bioc
COPY packages/bioc.txt /opt/r-setup/packages/bioc.txt
RUN Rscript /opt/r-setup/install_packages.R bioc /opt/r-setup/packages/bioc.txt

# --- GitHub: SeuratWrappers, DoubletFinder, harmony ---
# pak may run apt-get for system libraries, so clean the apt lists afterwards
FROM bioc AS github
COPY packages/github.txt /opt/r-setup/packages/github.txt
RUN Rscript /opt/r-setup/install_packages.R github /opt/r-setup/packages/github.txt \
    && rm -rf /var/lib/apt/lists/*

# --- BPCells (pre-built binary from r-universe) ---
FROM github AS bpcells
COPY packages/bpcells.txt /opt/r-setup/packages/bpcells.txt
RUN Rscript /opt/r-setup/install_packages.R repo /opt/r-setup/packages/bpcells.txt

# --- GitHub: GseaVis (pinned commit, patched) ---
# GseaVis fetches DOSE's internal get_organism, which moved to GOSemSim in
# DOSE 4.5.1 (DOSE still exports it). Unpatched, the install fails with
# "object 'get_organism' not found" (junjunlab/GseaVis issue). Patch it to call
# the exported DOSE::get_organism, then install from the local copy.
FROM bpcells AS gseavis
ARG GSEAVIS_COMMIT=dbedddc126936cb1f59527dede77a65a29e55e65
COPY packages/gseavis.txt /opt/r-setup/packages/gseavis.txt
RUN git clone https://github.com/junjunlab/GseaVis.git /tmp/GseaVis \
    && git -C /tmp/GseaVis checkout ${GSEAVIS_COMMIT} \
    && sed -i 's/^get_organism <- getFromNamespace("get_organism", *"DOSE")/get_organism <- function(...) DOSE::get_organism(...)/' \
        /tmp/GseaVis/R/funcs-from-others.R \
    && grep -q 'DOSE::get_organism' /tmp/GseaVis/R/funcs-from-others.R \
    && Rscript -e 'pak::pak("local::/tmp/GseaVis", upgrade = FALSE); pak::cache_clean()' \
    && rm -rf /tmp/GseaVis /var/lib/apt/lists/*

# --- Validate every listed package loads ---
FROM gseavis AS final
COPY validate_packages.R /opt/r-setup/validate_packages.R
RUN Rscript /opt/r-setup/validate_packages.R /opt/r-setup/packages

WORKDIR /work
CMD ["bash"]
