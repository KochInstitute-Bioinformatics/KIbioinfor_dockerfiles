#!/usr/bin/env Rscript

options(Ncpus = max(1, parallel::detectCores() - 1))
repos <- c(CRAN = 'https://cloud.r-project.org')
options(repos = repos)

# Install package managers
if (!requireNamespace('BiocManager', quietly=TRUE)) install.packages('BiocManager')
if (!requireNamespace('remotes', quietly=TRUE)) install.packages('remotes')

# ===== CRAN PACKAGES =====
message('Installing CRAN packages...')
cran_pkgs <- unique(c(
  # Core single-cell (remove Seurat/Signac - installed from GitHub)
  'Matrix',
  # Data manipulation
  'dplyr', 'data.table', 'matrixStats',
  # Visualization
  'ggplot2', 'ggrepel', 'cowplot', 'patchwork', 'ggpubr', 'ggrastr', 'hexbin',
  # Clustering & QC
  'clustree', 'SoupX', 'rliger',
  # Enrichment & functional analysis
  'gprofiler2', 'VAM',
  # Spatial
  'terra',
  # Effect size / statistics
  'effectsize',
  # Utilities
  'openxlsx', 'kableExtra', 'remotes',
  # Upset plots
  'ComplexUpset', 'ggseqlogo'
))
to_install <- setdiff(cran_pkgs, rownames(installed.packages()))
if (length(to_install) > 0) install.packages(to_install)

# ===== BIOCONDUCTOR PACKAGES =====
message('Installing Bioconductor packages...')
bioc_pkgs <- unique(c(
  # Single-cell core
  'SingleCellExperiment', 'SummarizedExperiment', 'BiocGenerics', 'DelayedArray', 'HDF5Array',
  # Cell type annotation
  'SingleR',
  # Trajectory inference
  'slingshot',
  # DE analysis
  'DESeq2', 'edgeR', 'apeglm',
  # Quantification
  'tximport', 'pcaMethods',
  # Enrichment & functional analysis
  'clusterProfiler', 'GSEABase', 'GSVA', 'UCell',
  # Regulatory analysis
  'chromVAR', 'TFBSTools', 'motifmatchr',
  # Visualization
  'ComplexHeatmap', 'dittoSeq', 'scDataviz',
  # Batch correction
  'batchelor',
  # Reference data
  'scRNAseq',
  # Genomes & annotations
  'BSgenome.Mmusculus.UCSC.mm10', 'EnsDb.Mmusculus.v79', 'JASPAR2024',
  # Omnipath
  'OmnipathR'
))
to_install <- setdiff(bioc_pkgs, rownames(installed.packages()))
if (length(to_install) > 0) BiocManager::install(to_install, update=TRUE, ask=FALSE)

# ===== OPTIONAL GITHUB PACKAGES (non-Seurat ecosystem) =====
message('Installing optional GitHub packages...')
optional_gh <- c(
  'hypercompetent/colorway',
  'powellgenomicslab/DropletQC',
  'samuel-marsh/scCustomize',
  'kharchenkolab/pagoda2',
  'saezlab/liana'
)
for (pkg in optional_gh) {
  message(paste('Attempting', pkg))
  try(remotes::install_github(pkg, upgrade='never'), silent=TRUE)
}

message('Core R packages installation complete!')