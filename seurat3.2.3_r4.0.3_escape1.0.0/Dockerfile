FROM rocker/verse:4.0.3
LABEL authors="Charlie Whittaker" \
      description="Docker image for Seurat3."

RUN apt-get update && apt-get install -y \ 
    libhdf5-dev build-essential libxml2-dev libssl-dev libv8-dev libsodium-dev libglpk40 libgdal-dev \
    libboost-dev libomp-dev libbamtools-dev libboost-iostreams-dev libboost-log-dev libboost-system-dev libboost-test-dev libcurl4-openssl-dev \
    libz-dev libarmadillo-dev libhdf5-cpp-103

# Install R packages
RUN R -e "install.packages('devtools', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('remotes', repos='http://cran.rstudio.com/')"
RUN R -e "devtools::install_github('satijalab/seurat', ref = 'v3.2.3')"
RUN R -e "BiocManager::install(version = "3.12")"
RUN R -e "BiocManager::install(c('escape'))"
#RUN R -e "BiocManager::install(c('GSVA'))"
RUN R -e "install.packages(c('kableExtra', 'openxlsx', 'umap','ggpubr'))"
RUN R -e "BiocManager::install(c('ComplexHeatmap','scater'))"
RUN R -e "BiocManager::install(c('dittoSeq','DESeq2','edgeR'))"

