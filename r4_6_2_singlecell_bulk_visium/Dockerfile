# R 4.6.2 + Single-Cell + Spatial (Visium) + Bulk RNAseq Stack
#
# Merge of:
#   - r4_6_1_singlecell_bulk_rnaseq (staged build from package lists, bumped to R 4.6.2)
#   - r4_5_1_python3_singlecell_visium (Signac/Azimuth/monocle3/... package set; Python tools dropped)
#
# Each install step is a named stage, cached separately. To build only up to
# one stage (e.g. to debug the next one interactively):
#   docker build --target bioc -t r462-debug .
#   docker run --rm -it r462-debug bash
#
# NOTE: rocker/verse:4.6.2 sets CRAN to p3m.dev/.../resolute/latest (a moving
# target, not a dated snapshot), and the base OS is Ubuntu resolute.
# CRAN versions (Seurat included) can change between rebuilds; pin if needed.

FROM rocker/verse:4.6.2 AS base

LABEL maintainer="yann" \
      description="Rocker Verse 4.6.2 + single-cell, spatial and bulk RNA-seq packages"

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
    libfreetype-dev \
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
    libfftw3-dev \
    libsodium-dev \
    libglpk-dev \
    libarmadillo-dev \
    libboost-all-dev \
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

# --- GitHub: SeuratWrappers, DoubletFinder, harmony, Azimuth, monocle3, ... ---
# Many GitHub refs are resolved here; pass a token to avoid the unauthenticated
# 60 req/hr API rate limit:
#   docker build --build-arg GITHUB_PAT=<token> .
# (ARG, not ENV: not persisted into the final image's runtime environment.)
# pak may run apt-get for system libraries, so clean the apt lists afterwards
FROM bioc AS github
ARG GITHUB_PAT
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

# --- GitHub: velocyto.R (pinned commit, patched) ---
# src/routines.cpp passes a non-literal string to Rf_warning(), which GCC 15
# with -Werror=format-security (the default R build flags here) rejects:
#   routines.cpp:48: error: format not a string literal and no format arguments
# Patch it to use an explicit "%s" format.
# Its src/Makevars also links -lboost_system. Boost.System has been header-only
# since Boost 1.69 and Ubuntu's Boost 1.90 ships no libboost_system, so the link
# fails with "cannot find -lboost_system". Drop that flag (boost_filesystem stays).
# Then install from the local copy.
FROM gseavis AS velocyto
ARG VELOCYTO_COMMIT=83e6ed92c2d9c9640122dcebf8ebbb5788165a21
COPY packages/velocyto.txt /opt/r-setup/packages/velocyto.txt
RUN git clone https://github.com/velocyto-team/velocyto.R.git /tmp/velocyto.R \
    && git -C /tmp/velocyto.R checkout ${VELOCYTO_COMMIT} \
    && sed -i 's/Rf_warning(es\.str()\.c_str());/Rf_warning("%s", es.str().c_str());/' \
        /tmp/velocyto.R/src/routines.cpp \
    && grep -q 'Rf_warning("%s", es.str().c_str())' /tmp/velocyto.R/src/routines.cpp \
    && sed -i 's/ -lboost_system//' /tmp/velocyto.R/src/Makevars \
    && ! grep -q boost_system /tmp/velocyto.R/src/Makevars \
    && Rscript -e 'pak::pak("local::/tmp/velocyto.R", upgrade = FALSE); pak::cache_clean()' \
    && rm -rf /tmp/velocyto.R /var/lib/apt/lists/*

# --- Validate every listed R package loads ---
FROM velocyto AS final
COPY validate_packages.R /opt/r-setup/validate_packages.R
RUN Rscript /opt/r-setup/validate_packages.R /opt/r-setup/packages

WORKDIR /work
CMD ["bash"]
