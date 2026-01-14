FROM rocker/cuda:4.0.5
LABEL description="Docker image for dREG"

ARG CUDA_ARCH="sm_89"

USER root

RUN apt-get update -qqq \
    && apt-get install -y \
    apt-utils bedops libboost-all-dev wget \
    curl git libssl-dev libcurl4-openssl-dev \
    gcc pkg-config bzip2 tar build-essential \
    libc6-dev libpcre3 libpcre3-dev make \
    libbz2-dev zlib1g-dev libncurses5-dev \
    libncursesw5-dev liblzma-dev

RUN R -e 'install.packages("devtools")'

RUN git clone https://github.com/Danko-Lab/dREG \
    && cd dREG \
    && make R_dependencies \
    && R -e 'devtools::install_version("randomForest", version="4.6-14", repos="https://mirrors.dotsrc.org/cran/")' \
    && R -e 'devtools::install_github("CshlSiepelLab/RPHAST")' \
    && make dreg \
    && chmod +x run_dREG.bsh

RUN R -e 'install.packages(c("bit64", "snow", "SparseM", "Matrix"))'

RUN cd /tmp \
    && wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb \
    && dpkg -i cuda-keyring_1.1-1_all.deb \
    && apt-get update -qqq \
    && apt-get install -y cuda-toolkit \
    && cd -

RUN mkdir -p third-party \
    && cd third-party \
    && git clone https://github.com/Danko-Lab/Rgtsvm \
    && cd Rgtsvm \
    && R CMD INSTALL --configure-args="--with-cuda-arch=${CUDA_ARCH} --with-cuda-home=/usr/local/cuda-13.1 --with-boost-home=/usr/" Rgtsvm

RUN cd /usr/bin \
    && wget https://github.com/samtools/htslib/releases/download/1.23/htslib-1.23.tar.bz2 \
    && tar -vxjf htslib-1.23.tar.bz2 \
    && cd htslib-1.23 \
    && make

RUN cd /usr/bin \
    && wget https://github.com/samtools/samtools/releases/download/1.23/samtools-1.23.tar.bz2 \
    && tar -vxjf samtools-1.23.tar.bz2 \
    && cd samtools-1.23 \
    && make

RUN cd /usr/bin \
    && wget https://github.com/samtools/bcftools/releases/download/1.23/bcftools-1.23.tar.bz2 \
    && tar -vxjf bcftools-1.23.tar.bz2 \
    && cd bcftools-1.23 \
    && make
    
RUN cd /usr/local/bin \
    && wget https://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64.v479/bedGraphToBigWig \
    && chmod +x bedGraphToBigWig

ENV PATH dREG/:/usr/bin/htslib-1.23:/usr/bin/samtools-1.23:/usr/bin/bcftools-1.23:$PATH:/usr/local/bin
