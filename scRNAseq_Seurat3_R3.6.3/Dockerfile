# Use a base image with R 3.6.3 installed
FROM rocker/r-ver:3.6.3

LABEL authors="Charlie Whittaker" \
      description="Docker image for Seurat3."

# Install system dependencies for devtools and its dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libgit2-dev \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install devtools R package
RUN R -e "install.packages('devtools', repos='http://cran.rstudio.com/')"

# Install Seurat 3.2.3 using devtools
RUN R -e "devtools::install_github('satijalab/seurat', ref = 'v3.2.3')"
#RUN R -e "BiocManager::install(c('escape'))"
#RUN R -e "install.packages(c('kableExtra','openxlsx', 'umap')"
#RUN R -e "BiocManager::install(c('DESeq2','ComplexHeatmap','dittoSeq'))"