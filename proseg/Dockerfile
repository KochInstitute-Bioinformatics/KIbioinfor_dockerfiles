# syntax=docker/dockerfile:1
# Proseg (https://github.com/dcjones/proseg) built from a pinned release tag.
ARG PROSEG_VERSION=v3.2.0

FROM rust:1.88 AS builder
ARG PROSEG_VERSION
RUN git clone --depth 1 --branch ${PROSEG_VERSION} https://github.com/dcjones/proseg.git /app
WORKDIR /app
RUN cargo install --path . \
  && mkdir /proseg_bins \
  && cp /usr/local/cargo/bin/proseg* /proseg_bins/

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates procps && rm -rf /var/lib/apt/lists/*
COPY --from=builder /proseg_bins/ /usr/local/bin/
CMD ["proseg"]
