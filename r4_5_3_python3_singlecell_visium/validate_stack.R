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

message('===== COMPATIBILITY CHECK =====')

# Check Seurat/SeuratObject compatibility
seurat_version <- as.character(packageVersion('Seurat'))
seurat_obj_version <- as.character(packageVersion('SeuratObject'))

message(paste('Seurat version:', seurat_version))
message(paste('SeuratObject version:', seurat_obj_version))

# Try to create and manipulate a test Seurat object
tryCatch({
  test_data <- matrix(rnorm(1000), nrow=100, ncol=10)
  rownames(test_data) <- paste0('Gene_', 1:100)
  colnames(test_data) <- paste0('Cell_', 1:10)
  
  test_obj <- Seurat::CreateSeuratObject(counts = test_data)
  message('✓ Successfully created test Seurat object')
  
  # Test VlnPlot (the function that was failing)
  test_obj$test_group <- rep(c('A', 'B'), 5)
  p <- Seurat::VlnPlot(test_obj, features='nFeature_RNA', group.by='test_group', pt.size=0)
  message('✓ VlnPlot function works correctly')
  
}, error = function(e) {
  stop(paste('Compatibility check failed:', e$message))
})

message('===== Stack validation complete =====')