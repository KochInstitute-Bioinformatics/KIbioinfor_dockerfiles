FROM rocker/verse:4.4.1
LABEL description="Docker Rstudio image KI IGB bulk rnaseq and crispr - June 2024"

RUN apt-get update && apt-get install -y libhdf5-dev build-essential libxt6 libxml2-dev libssl-dev \
libv8-dev libsodium-dev libglpk40 libgdal-dev libboost-dev libomp-dev libbamtools-dev \
libboost-iostreams-dev libboost-log-dev libbz2-dev libboost-system-dev libboost-test-dev \
libcurl4-openssl-dev libz-dev libarmadillo-dev libhdf5-cpp-103

RUN R -e "install.packages(c('cowplot','knitr','msigdbr','remotes','metap','devtools','R.utils','ggalt','BiocManager','openxlsx','XML','gprofiler2','cluster'),repos='http://cran.rstudio.com/')"
RUN R -e "install.packages(c('gplots','MetaCycle','ashr'),repos='http://cran.rstudio.com/')"

RUN R -e "install.packages(c('markdown'),repos='http://cran.rstudio.com/')"
RUN R -e "install.packages(c('ggpubr'),repos='http://cran.rstudio.com/')"
RUN R -e "install.packages(c('effectsize'),repos='http://cran.rstudio.com/')"

RUN R -e "BiocManager::install(c('DESeq2','tximport','Rsamtools','Rhtslib','GenomicAlignments','ComplexHeatmap','rtracklayer','fgsea','apeglm','edgeR'))"
RUN R -e "BiocManager::install(c('MAGeCKFlute'))"
RUN R -e "BiocManager::install(c('org.Hs.eg.db','org.Mm.eg.db'))"

RUN R -e "install.packages(c('rebus'),repos='http://cran.rstudio.com/')"

RUN R -e "install.packages(c('GGally'),repos='http://cran.rstudio.com/')"

RUN R -e "install.packages(c('VennDiagram'),repos='http://cran.rstudio.com/')"

RUN R -e "install.packages(c('ggVennDiagram'),repos='http://cran.rstudio.com/')"

RUN R -e "install.packages(c('UpSetR'),repos='http://cran.rstudio.com/')"

RUN R -e "install.packages(c('colorRamp2'),repos='http://cran.rstudio.com/')"

RUN R -e "install.packages(c('esquisse'),repos='http://cran.rstudio.com/')"
