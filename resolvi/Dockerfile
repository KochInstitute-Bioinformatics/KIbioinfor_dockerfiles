# syntax=docker/dockerfile:1
# resolVI (scvi.external.RESOLVI) from scvi-tools, for spatial transcriptomics.
# GPU use: run with `apptainer exec --nv` or `docker run --gpus all`; the PyPI torch wheels bundle CUDA.
FROM python:3.12-slim-bookworm

ENV PIP_NO_CACHE_DIR=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    procps \
    && rm -rf /var/lib/apt/lists/*

RUN pip install \
    "scvi-tools==1.5.2" \
    scanpy \
    leidenalg \
    jupyterlab

# Fail the build if resolVI is not importable
RUN python -c "from scvi.external import RESOLVI; print('RESOLVI import OK')"

WORKDIR /data
CMD ["python"]
