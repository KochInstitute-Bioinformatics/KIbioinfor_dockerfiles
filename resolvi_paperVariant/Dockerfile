# syntax=docker/dockerfile:1
# resolVI paper variant: the patched scvi-tools (v1.4.1 + resolVI fixes) and the reproducibility
# code archived on Zenodo with the manuscript, https://doi.org/10.5281/zenodo.19811112
# GPU use: run with `apptainer exec --nv` or `docker run --gpus all`; the PyPI torch wheels bundle CUDA.
FROM python:3.12-slim-bookworm

ENV PIP_NO_CACHE_DIR=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Download both Zenodo archives, verify their checksums, then unpack
RUN mkdir -p /opt/zenodo && cd /opt/zenodo \
    && curl -fsSL -o scvi-tools-resolvi_fix.tar.gz \
        "https://zenodo.org/records/19811112/files/scvi-tools-resolvi_fix.tar.gz?download=1" \
    && curl -fsSL -o resolvi-reproducibility-main.tar.gz \
        "https://zenodo.org/records/19811112/files/resolvi-reproducibility-main.tar.gz?download=1" \
    && echo "e8a7bceb3b69b92024d933d82152e3a6  scvi-tools-resolvi_fix.tar.gz" | md5sum -c - \
    && echo "6fa3b6a81653cf11c007bbfdfb1521d5  resolvi-reproducibility-main.tar.gz" | md5sum -c - \
    && tar xzf scvi-tools-resolvi_fix.tar.gz \
    && tar xzf resolvi-reproducibility-main.tar.gz

# Patched scvi-tools (the paper's version of scvi.external.RESOLVI)
RUN pip install /opt/zenodo/scvi-tools-resolvi_fix

# Dependencies of the reproducibility scripts (_utils.py, run_model.py)
RUN pip install \
    click \
    seaborn \
    "pomegranate>=1.0" \
    harmony-pytorch \
    leidenalg \
    jupyterlab

# Reproducibility code. run_model.py imports _utils from its own directory, so both go in scripts/
RUN mv /opt/zenodo/resolvi-reproducibility-main /opt/resolvi-reproducibility \
    && mkdir /opt/resolvi-reproducibility/scripts \
    && cp /opt/resolvi-reproducibility/training_scripts/run_model.py \
          /opt/resolvi-reproducibility/_utils.py \
          /opt/resolvi-reproducibility/scripts/ \
    && rm -rf /opt/zenodo/*.tar.gz

# Fail the build if the patched resolVI or the script dependencies are not importable
RUN python -c "import scvi; from scvi.external import RESOLVI; print('scvi-tools', scvi.__version__, 'RESOLVI import OK')" \
    && cd /opt/resolvi-reproducibility/scripts && python -c "import _utils; print('_utils import OK')"

WORKDIR /data
CMD ["python"]
