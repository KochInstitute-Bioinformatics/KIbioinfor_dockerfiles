#!/usr/bin/env Rscript

options(Ncpus = max(1, parallel::detectCores() - 1))
repos <- c(CRAN = 'https://cloud.r-project.org')
options(repos = repos)

if (!requireNamespace('BiocManager', quietly=TRUE)) install.packages('BiocManager')
if (!requireNamespace('remotes', quietly=TRUE)) install.packages('remotes')

# ===== CRAN PACKAGES =====
message('Installing CRAN packages...')
cran_pkgs <- c(
  'Seurat', 'Matrix',
  'dplyr', 'data.table', 'matrixStats',
  'ggplot2', 'ggrepel', 'cowplot', 'patchwork', 'ggpubr',
  'clustree', 'SoupX',
  'gprofiler2', 'openxlsx', 'kableExtra',
  'effectsize'
)
install.packages(setdiff(cran_pkgs, rownames(installed.packages())))

# ===== BIOCONDUCTOR PACKAGES =====
message('Installing Bioconductor packages...')
bioc_pkgs <- c(
  'SingleCellExperiment', 'SummarizedExperiment', 'BiocGenerics', 'DelayedArray', 'HDF5Array',
  'SingleR', 'slingshot',
  'DESeq2', 'edgeR', 'apeglm', 'tximport', 'pcaMethods',
  'clusterProfiler', 'GSEABase', 'GSVA', 'UCell',
  'ComplexHeatmap', 'dittoSeq', 'scDataviz',
  'batchelor', 'scRNAseq',
  'BSgenome.Mmusculus.UCSC.mm10', 'EnsDb.Mmusculus.v79', 'OmnipathR'
)
BiocManager::install(setdiff(bioc_pkgs, rownames(installed.packages())), update=TRUE, ask=FALSE)

# ===== GITHUB PACKAGES =====
message('Installing GitHub packages...')
gh_packages <- c(
  'satijalab/seurat-wrappers',
  'chris-mcginnis-ucsf/DoubletFinder',
  'immunogenomics/harmony',
  'bnprks/BPCells/r'
)
for (pkg in gh_packages) {
  message(paste('  Installing', pkg))
  try(remotes::install_github(pkg, upgrade='never'), silent=TRUE)
}

message('R package installation complete!')