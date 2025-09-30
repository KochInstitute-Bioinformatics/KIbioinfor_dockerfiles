FROM rocker/verse:4.5.1
LABEL description="Docker Rstudio image KI IGB bulk rnaseq and crispr - September 2025"


RUN apt-get update && apt-get install -y \
  libhdf5-dev build-essential libxt6 libxml2-dev libssl-dev \
  libv8-dev libsodium-dev libglpk40 libgdal-dev libboost-dev libomp-dev libbamtools-dev \
  libboost-iostreams-dev libboost-log-dev libbz2-dev libboost-system-dev libboost-test-dev \
  libcurl4-openssl-dev libz-dev libarmadillo-dev libhdf5-hl-cpp-100t64 \
  python3 python3-pip python3.12-venv

RUN python3 -m venv /opt/venv \
    && /opt/venv/bin/pip install numpy pandas \
    && ln -s /opt/venv/bin/pip /usr/local/bin/pip \
    && ln -s /opt/venv/bin/python /usr/local/bin/python

RUN Rscript -e "install.packages('BiocManager', repos='http://cran.rstudio.com/'); \
BiocManager::install(c('DESeq2','tximport','Rsamtools','Rhtslib','GenomicAlignments', \
'ComplexHeatmap','rtracklayer','fgsea','apeglm','edgeR','MAGeCKFlute','org.Hs.eg.db', \
'org.Mm.eg.db','GO.db','DOSE','clusterProfiler','AnnotationDbi')); \
install.packages(c('cowplot','knitr','msigdbr','remotes','metap','devtools','R.utils', \
'ggalt','openxlsx','XML','gprofiler2','cluster','gplots','MetaCycle','ashr','markdown', \
'ggpubr','effectsize','rebus','GGally','VennDiagram','ggVennDiagram','UpSetR', \
'ComplexUpset','colorRamp2','esquisse'), repos='http://cran.rstudio.com/')"

RUN Rscript -e 'remotes::install_github("junjunlab/GseaVis")'

