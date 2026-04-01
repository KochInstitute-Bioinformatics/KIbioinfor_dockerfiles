#!/usr/bin/env Rscript

message('===== VALIDATION: Core packages =====')
packages <- c('Seurat', 'DESeq2', 'edgeR', 'GSVA', 'UCell', 'ComplexHeatmap', 'ggplot2', 'clusterProfiler', 'effectsize', 'BPCells', 'harmony')
for (pkg in packages) {
  if (library(pkg, character.only=TRUE, logical.return=TRUE, quietly=TRUE)) {
    message(paste('  ✓', pkg))
  } else {
    warning(paste('  ✗ Failed to load:', pkg))
  }
}