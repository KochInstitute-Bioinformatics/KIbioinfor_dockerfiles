# R 4.5.3 + single-cell stack (Seurat, Signac, Azimuth, UCell, velocyto.R, etc.) + CellBender
FROM rocker/verse:4.5.3

LABEL maintainer="Charlie" \
      description="Rocker Verse 4.5.3 + Seurat (visium-hd), Signac, Azimuth, UCell, velocyto.R, etc. + CellBender"

ENV DEBIAN_FRONTEND=noninteractive \
    RENV_CONFIG_REPOS_OVERRIDE=https://cloud.r-project.org \
    R_REMOTES_NO_ERRORS_FROM_WARNINGS=true

# --- System dependencies for R packages and velocyto.R ---
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
    libfftw3-dev \
    libsodium-dev \
    libv8-dev \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    libglpk40 \
    libglpk-dev \
    libarmadillo-dev \
    libboost-all-dev \
    && rm -rf /var/lib/apt/lists/*

# --- Create R installation script to avoid complex quoting in RUN ---
COPY install_r_packages.R /tmp/install_r_packages.R
RUN Rscript /tmp/install_r_packages.R && rm /tmp/install_r_packages.R

# --- Specialized packages: Seurat visium-hd, velocyto, SeuratDisk, Azimuth ---
COPY install_specialized.R /tmp/install_specialized.R
RUN Rscript /tmp/install_specialized.R && rm /tmp/install_specialized.R

# --- Python + CellBender (PEP 668-safe via venv) ---
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-venv \
    python3-dev \
    python3-pip \
    && python3 -m venv /opt/py/cellbender \
    && /opt/py/cellbender/bin/pip install --upgrade --no-cache-dir pip setuptools wheel \
    && /opt/py/cellbender/bin/pip install --no-cache-dir --index-url https://download.pytorch.org/whl/cpu torch \
    && /opt/py/cellbender/bin/pip install --no-cache-dir cellbender \
    && ln -s /opt/py/cellbender/bin/cellbender /usr/local/bin/cellbender \
    && rm -rf /var/lib/apt/lists/*

# --- Validation: Test that core packages load successfully ---
COPY validate_stack.R /tmp/validate_stack.R
RUN Rscript /tmp/validate_stack.R && rm /tmp/validate_stack.R

WORKDIR /work
CMD ["bash"]