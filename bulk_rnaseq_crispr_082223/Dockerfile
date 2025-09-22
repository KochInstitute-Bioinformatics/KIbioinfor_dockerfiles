FROM rocker/tidyverse:4.3.1
LABEL description="Docker Rstudio image KI IGB bulk rnaseq and crispr - August 2023"

RUN apt-get update && apt-get install -y libhdf5-dev build-essential libxt6 libxml2-dev libssl-dev libv8-dev libsodium-dev libglpk40 libgdal-dev libboost-dev libomp-dev libbamtools-dev libboost-iostreams-dev libboost-log-dev libbz2-dev libboost-system-dev libboost-test-dev libcurl4-openssl-dev libz-dev libarmadillo-dev libhdf5-cpp-103

RUN R -e "install.packages(c('cowplot','knitr','msigdbr','remotes','metap','devtools','R.utils','ggalt','BiocManager','openxlsx','XML','gprofiler2','cluster'),repos='http://cran.rstudio.com/')"

RUN R -e "install.packages(c('gplots','MetaCycle','ashr'),repos='http://cran.rstudio.com/')"

RUN R -e "BiocManager::install(c('DESeq2','tximport','Rsamtools','Rhtslib','GenomicAlignments','ComplexHeatmap','rtracklayer','fgsea','apeglm','edgeR','org.Mm.eg.db','MAGeCKFlute'))"

RUN R -e "install.packages(c('ggpubr'),repos='http://cran.rstudio.com/')"

RUN R -e "install.packages(c('markdown'),repos='http://cran.rstudio.com/')"