#!/usr/bin/env Rscript

message('===== VALIDATION: Loading core packages =====')

packages_to_test <- c(
  'Seurat', 'Signac', 'DESeq2', 'GSVA', 'UCell',
  'ComplexHeatmap', 'ggplot2', 'dplyr', 'clusterProfiler',
  'SingleCellExperiment', 'slingshot', 'harmony', 'velocyto.R'
)

failed <- character()
for (pkg in packages_to_test) {
  if (library(pkg, character.only=TRUE, logical.return=TRUE, quietly=TRUE)) {
    message(paste('  ✓', pkg))
  } else {
    message(paste('  ✗', pkg))
    failed <- c(failed, pkg)
  }
}

if (length(failed) > 0) {
  stop(paste('Failed to load:', paste(failed, collapse=', ')))
}

message('===== Stack validation complete =====')