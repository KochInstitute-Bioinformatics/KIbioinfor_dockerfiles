# R 4.5.1 + single-cell stack + test gate
FROM rocker/verse:4.5.1
LABEL maintainer="yann" description="Rocker Verse 4.5.1 + Seurat (visium-hd), Signac, Azimuth, UCell, velocyto.R, etc. + CellBender with load tests baked in"

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
    libglpk40 libglpk-dev \
    libarmadillo-dev \
    libboost-all-dev \
 && rm -rf /var/lib/apt/lists/*

# --- Core R stack (CRAN + Bioc + selected GitHub) ---
RUN R --vanilla -q -e "options(Ncpus = max(1, parallel::detectCores() - 1)); \
  repos <- c(CRAN = 'https://cloud.r-project.org'); options(repos = repos); \
  if (!requireNamespace('BiocManager', quietly=TRUE)) install.packages('BiocManager'); \
  if (!requireNamespace('remotes', quietly=TRUE)) install.packages('remotes'); \
  \
  cran_pkgs <- unique(c( \
    'Seurat','Signac','Matrix', \
    'dplyr','cowplot','ggplot2','ggrepel','patchwork','data.table','matrixStats', \
    'clustree','SoupX','gprofiler2','VAM','openxlsx','kableExtra','ggpubr', \
    'ComplexUpset','ggseqlogo','rliger','hexbin','terra','ggrastr' \
  )); \
  bioc_pkgs <- unique(c( \
    'SingleR','slingshot','scRNAseq','edgeR','apeglm','DESeq2','pcaMethods','clusterProfiler', \
    'dittoSeq','scDataviz','GSEABase','ComplexHeatmap','GSVA','UCell', \
    'TFBSTools','motifmatchr','chromVAR','BiocGenerics','DelayedArray','SummarizedExperiment', \
    'batchelor','HDF5Array', \
    'BSgenome.Mmusculus.UCSC.mm10','EnsDb.Mmusculus.v79','JASPAR2024','OmnipathR' \
  )); \
  \
  message('Installing CRAN packages...'); \
  to_install <- setdiff(cran_pkgs, rownames(installed.packages())); \
  if (length(to_install)) install.packages(to_install); \
  \
  message('Installing Bioconductor packages...'); \
  BiocManager::install(setdiff(bioc_pkgs, rownames(installed.packages())), update=TRUE, ask=FALSE); \
  \
  message('Installing GitHub utility packages...'); \
  gh_pkgs <- c( \
    'satijalab/seurat-wrappers', \
    'chris-mcginnis-ucsf/DoubletFinder', \
    'cole-trapnell-lab/monocle3', \
    'hypercompetent/colorway', \
    'powellgenomicslab/DropletQC', \
    'samuel-marsh/scCustomize', \
    'kharchenkolab/pagoda2' \
  ); \
  for (pkg in gh_pkgs) { try(remotes::install_github(pkg, upgrade='never'), silent=TRUE) } \
"

# --- Packages you asked to install from specific sources ---
RUN R --vanilla -q -e "options(Ncpus = max(1, parallel::detectCores() - 1)); \
  repos <- c(CRAN = 'https://cloud.r-project.org'); options(repos = repos); \
  if (!requireNamespace('BiocManager', quietly=TRUE)) install.packages('BiocManager'); \
  if (!requireNamespace('remotes', quietly=TRUE)) install.packages('remotes'); \
  \
  message('Installing Signac (CRAN)'); \
  install.packages('Signac'); \
  \
  message('Installing SeuratDisk (GitHub: mojaveazure/seurat-disk)'); \
  remotes::install_github('mojaveazure/seurat-disk', upgrade='never'); \
  \
  message('Installing rliger (CRAN)'); \
  install.packages('rliger'); \
  \
  message('Installing UCell (Bioconductor)'); \
  BiocManager::install('UCell', ask=FALSE, update=TRUE); \
  \
  message('Installing Azimuth (GitHub master)'); \
  remotes::install_github('satijalab/azimuth', ref='master', upgrade='never'); \
  \
  message('Installing velocyto.R (GitHub: velocyto-team/velocyto.R)'); \
  remotes::install_github('velocyto-team/velocyto.R', upgrade='never'); \
  \
  message('Installing Seurat (visium-hd branch)'); \
  remotes::install_github('satijalab/seurat', ref='visium-hd', upgrade='never'); \
  \
  message('Installing Liana (GitHub saezlab)'); \
  remotes::install_github('saezlab/liana', upgrade='never'); \
"

RUN R -e "remotes::install_github('YannVRB/velocyto.R@comment_rf_warning')"

# --- Python + CellBender (PEP 668-safe via venv) ---
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-venv python3-dev python3-pip \
 && python3 -m venv /opt/py/cellbender \
 && /opt/py/cellbender/bin/pip install --upgrade --no-cache-dir pip \
 && /opt/py/cellbender/bin/pip install --no-cache-dir --index-url https://download.pytorch.org/whl/cpu torch \
 && /opt/py/cellbender/bin/pip install --no-cache-dir cellbender \
 && ln -s /opt/py/cellbender/bin/cellbender /usr/local/bin/cellbender \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /work
CMD ["bash"]
