#!/usr/bin/env Rscript

options(Ncpus = max(1, parallel::detectCores() - 1))

if (!requireNamespace('remotes', quietly=TRUE)) install.packages('remotes')

message('===== Installing compatible Seurat + SeuratObject stack =====')

# Install SeuratObject FIRST from development branch (tested with latest Seurat)
message('Installing SeuratObject from develop branch...')
remotes::install_github('satijalab/seurat-object', ref='develop', upgrade='never')

# Then install Seurat from develop branch (compatible with new SeuratObject)
message('Installing Seurat from develop branch...')
remotes::install_github('satijalab/seurat', ref='develop', upgrade='never')

# Verify versions
message('Checking installed versions:')
message(paste('  Seurat version:', packageVersion('Seurat')))
message(paste('  SeuratObject version:', packageVersion('SeuratObject')))

message('Installing velocyto.R...')
remotes::install_github('velocyto-team/velocyto.R', upgrade='never')

message('Installing velocyto.R with rf warning comment patch...')
try(remotes::install_github('YannVRB/velocyto.R@comment_rf_warning', upgrade='never'), silent=TRUE)

message('Installing SeuratDisk...')
remotes::install_github('mojaveazure/seurat-disk', upgrade='never')

message('Installing Azimuth...')
remotes::install_github('satijalab/azimuth', ref='master', upgrade='never')

message('Specialized packages installation complete!')