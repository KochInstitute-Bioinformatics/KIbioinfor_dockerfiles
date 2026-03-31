#!/usr/bin/env Rscript

options(Ncpus = max(1, parallel::detectCores() - 1))

if (!requireNamespace('remotes', quietly=TRUE)) install.packages('remotes')

message('Installing Seurat from visium-hd branch...')
remotes::install_github('satijalab/seurat', ref='visium-hd', upgrade='never')

message('Installing velocyto.R...')
remotes::install_github('velocyto-team/velocyto.R', upgrade='never')

message('Installing velocyto.R with rf warning comment patch...')
try(remotes::install_github('YannVRB/velocyto.R@comment_rf_warning', upgrade='never'), silent=TRUE)

message('Installing SeuratDisk...')
remotes::install_github('mojaveazure/seurat-disk', upgrade='never')

message('Installing Azimuth...')
remotes::install_github('satijalab/azimuth', ref='master', upgrade='never')

message('Installing BPCells...')
remotes::install_github('bnprks/BPCells/r', ref='master', upgrade='never')

message('Specialized packages installation complete!')