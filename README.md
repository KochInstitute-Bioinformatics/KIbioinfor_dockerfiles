# Dockerfile Collection

This repository contains a curated collection of Dockerfiles for various bioinformatics and data science workflows. Each subdirectory represents a distinct environment or project setup, typically including a `Dockerfile` and related configuration files.

## Project Directories

Each entry lists the base image, the main software installed, and **Potential Issues** found on review. The issues are notes for anyone rebuilding an image. The images that have already been built and pushed are not affected.

Notes that apply to many of the R images:

- **Unpinned CRAN repo.** Most R images pass `repos='http://cran.rstudio.com/'` or `https://cloud.r-project.org`. That overrides the date-pinned CRAN snapshot that rocker images ship with, so a rebuild installs whatever is on CRAN that day. Older R versions (3.6.x, 4.0.x, 4.2.x) are the most likely to fail.
- **GitHub installs from HEAD.** Packages installed with `install_github()` without a `ref` get the latest commit, which may no longer support the image's R version.
- **Silent failures.** `install.packages()` and `BiocManager::install()` only warn when a package fails to install, so a build can succeed with packages missing unless a validation step checks for them.

---

### R: Bulk RNA-seq / CRISPR

### `bulk_rnaseq_052323`

- **Author**: Charlie Whittaker
- **Purpose**: RStudio image for KI IGB bulk RNA-seq analysis (May 2023)
- **Base Image**: rocker/tidyverse:4.3
- **Key Packages**: DESeq2, edgeR, apeglm, ashr, tximport, fgsea, msigdbr, gprofiler2, ComplexHeatmap, rtracklayer, Rsamtools, GenomicAlignments, MetaCycle, ggpubr, gplots, cowplot, openxlsx
- **Usage Notes**: Serves RStudio Server (rocker default).
- **Potential Issues**:
  - `rocker/tidyverse:4.3` is a moving tag (it currently resolves to the latest 4.3.x), so rebuilds may get a different base.
  - `libhdf5-cpp-103` is tied to a specific Ubuntu release and may not exist in newer bases.

### `bulk_rnaseq_crispr_061924`

- **Author**: Charlie Whittaker
- **Purpose**: Intended as a June 2024 bulk RNA-seq / CRISPR update
- **Base Image**: rocker/tidyverse:4.3
- **Key Packages**: Same as `bulk_rnaseq_052323`
- **Usage Notes**: Serves RStudio Server.
- **Potential Issues**:
  - The Dockerfile has exactly the same content as `bulk_rnaseq_052323`, including the "May 2023" label. No CRISPR packages (e.g. MAGeCKFlute) are installed. The June 2024 image appears to be `bulk_r441`.
  - The same moving-tag issue as `bulk_rnaseq_052323`.

### `bulk_rnaseq_crispr_082223`

- **Author**: Charlie Whittaker
- **Purpose**: RStudio image for bulk RNA-seq and CRISPR screen analysis (August 2023)
- **Base Image**: rocker/tidyverse:4.3.1
- **Key Packages**: Bulk RNA-seq set as above, plus MAGeCKFlute, org.Mm.eg.db, markdown
- **Usage Notes**: Serves RStudio Server.
- **Potential Issues**:
  - Unpinned CRAN repo (see the notes at the top).
  - `libhdf5-cpp-103` is tied to a specific Ubuntu release.

### `bulk_r441`

- **Author**: Charlie Whittaker
- **Purpose**: RStudio image for KI IGB bulk RNA-seq and CRISPR (June 2024)
- **Base Image**: rocker/verse:4.4.1
- **Key Packages**: DESeq2, edgeR, apeglm, ashr, tximport, fgsea, MAGeCKFlute, org.Hs.eg.db, org.Mm.eg.db, ComplexHeatmap, colorRamp2, MetaCycle, effectsize, GGally, VennDiagram, ggVennDiagram, UpSetR, esquisse, rebus, ggpubr
- **Usage Notes**: Serves RStudio Server.
- **Potential Issues**:
  - Unpinned CRAN repo.
  - It uses about 20 separate `RUN` layers, which makes the image larger and the build slower than one combined install.
  - `libhdf5-cpp-103` may not exist on newer Ubuntu releases.

### `bulk_r443`

- **Author**: Charlie Whittaker
- **Purpose**: RStudio image for KI IGB bulk RNA-seq and CRISPR (March 2025)
- **Base Image**: rocker/verse:4.4.3
- **Key Packages**: Everything in `bulk_r441`, plus ShortRead, pheatmap, MULTI-seq (deMULTIplex), nichenetr, dryR
- **Usage Notes**: Serves RStudio Server.
- **Potential Issues**:
  - It installs both the OpenMPI and MPICH HDF5 C++ variants (`libhdf5-openmpi-hl-cpp-100t64`, `libhdf5-mpich-hl-cpp-100t64`), which pulls in two MPI stacks that are probably not needed.
  - MULTI-seq, nichenetr and dryR are installed from GitHub HEAD with no version pin.
  - Unpinned CRAN repo, and it has many separate `RUN` layers.

### `bulk_r451`

- **Author**: Charlie Whittaker
- **Purpose**: RStudio image for KI IGB bulk RNA-seq and CRISPR (September 2025)
- **Base Image**: rocker/verse:4.5.1
- **Key Packages**: DESeq2, edgeR, apeglm, tximport, fgsea, MAGeCKFlute, clusterProfiler, DOSE, GO.db, org.Hs.eg.db, org.Mm.eg.db, ComplexHeatmap, ComplexUpset, GseaVis, effectsize, plus the plotting set from `bulk_r443`. Also a Python venv at `/opt/venv` with numpy and pandas.
- **Usage Notes**: Serves RStudio Server. `python` and `pip` on the PATH point to the venv.
- **Potential Issues**:
  - `python3.12-venv` ties the image to Ubuntu 24.04 (noble).
  - GseaVis is installed from GitHub HEAD.
  - Unpinned CRAN repo.
  - The install failure of an individual package will not fail the build.
  - It drops several packages that `bulk_r443` had (ShortRead, pheatmap, MULTI-seq, nichenetr, dryR). Check whether that was intended.

### `RNAseqClass_Image`

- **Author**: Charlie Whittaker
- **Purpose**: Teaching RStudio image
- **Base Image**: rocker/tidyverse:4.3
- **Key Packages**: DESeq2, edgeR, apeglm, tximport, fgsea, msigdbr, gprofiler2, ComplexHeatmap, ggpubr, gplots
- **Usage Notes**: Serves RStudio Server.
- **Potential Issues**:
  - `rocker/tidyverse:4.3` is a moving tag.
  - Unpinned CRAN repo, and `libhdf5-cpp-103` is tied to a specific Ubuntu release.

---

### R: Single-cell (Seurat 3 / 4 / 5)

### `abrfseurat`

- **Author**: Charlie Whittaker/Alex Lemenze
- **Purpose**: Seurat 4 single-cell environment (ABRF)
- **Base Image**: rocker/verse:4.2.2
- **Key Packages**: Seurat, SingleR, celldex, slingshot, monocle3, velocyto.R, DoubletFinder, SeuratWrappers, scater, batchelor, DESeq2, edgeR, clusterProfiler, EnhancedVolcano, PCAtools, scCustomize, DropletQC, UCell, SoupX, clustree, scSorter, Matrix.utils 0.9.8 (from a local tarball)
- **Usage Notes**: Serves RStudio Server.
- **Potential Issues**:
  - **It won't build as it is.** The file is named `Dockerfile.txt`, so `docker build .` won't find it without `-f Dockerfile.txt`.
  - **It won't build as it is.** `COPY ./Matrix.utils_0.9.8.tar.gz` expects a tarball that is only in `vb_R4.2.0/`.
  - The GitHub packages (monocle3, velocyto.R, scCustomize, …) come from HEAD and may no longer support R 4.2.

### `scRNAseq_Seurat3_R3.6.3`

- **Author**: Charlie Whittaker
- **Purpose**: Trying to re-create old PC environment
- **Base Image**: rocker/r-ver:3.6.3
- **Key Packages**: Seurat 3.2.3 (from a GitHub tag), devtools
- **Usage Notes**: R only, with no RStudio Server. The extra packages are commented out.
- **Potential Issues**:
  - `devtools` is installed from current CRAN, which no longer supports R 3.6, so the build is likely to fail.

### `scRNAseq_Seurat3_R4.0.3`

- **Author**: Charlie Whittaker
- **Purpose**: Trying to re-create old PC environment
- **Base Image**: rocker/verse:4.0.3
- **Key Packages**: Seurat 3.2.3, GSVA, escape, scater, ComplexHeatmap, dittoSeq, DESeq2, edgeR, umap, ggpubr
- **Usage Notes**: Serves RStudio Server.
- **Potential Issues**:
  - Current CRAN `devtools` is unlikely to install on R 4.0.3.
  - Bioconductor is not pinned to a version here, unlike the `seurat3.2.3_r4.0.3_*` images, which pin 3.12.

### `scRNAseq_Seurat5`

- **Author**: Charlie Whittaker
- **Purpose**: Seurat 5 single-cell environment
- **Base Image**: rocker/verse:4.3.2
- **Key Packages**: Same set as `abrfseurat` (Seurat, SingleR, monocle3, velocyto.R, DoubletFinder, scCustomize, …), without Matrix.utils
- **Usage Notes**: Serves RStudio Server.
- **Potential Issues**:
  - The image label says "Seurat5", but `Seurat` comes from unpinned CRAN, so the Seurat version depends on the build date.
  - The GitHub packages come from HEAD.

### `seurat3.2.3_r3.6.3`

- **Author**: Charlie Whittaker
- **Purpose**: Trying to re-create old PC environment
- **Base Image**: rocker/verse:3.6.3
- **Key Packages**: Seurat 3.2.3, escape, scater, ComplexHeatmap, dittoSeq, DESeq2, umap, kableExtra, openxlsx, ggpubr
- **Usage Notes**: Serves RStudio Server.
- **Potential Issues**:
  - Current CRAN `devtools` won't install on R 3.6, so the build is likely to fail.
  - escape needs a newer Bioconductor than R 3.6 supports, so it may fail to install.

### `seurat3.2.3_r4.0.3_escape1.0.0`

- **Author**: Charlie Whittaker
- **Purpose**: Trying to re-create old PC environment
- **Base Image**: rocker/verse:4.0.3
- **Key Packages**: Seurat 3.2.3, escape (Bioconductor 3.12), scater, ComplexHeatmap, dittoSeq, DESeq2, edgeR, umap, ggpubr
- **Usage Notes**: Serves RStudio Server.
- **Potential Issues**:
  - In `RUN R -e "BiocManager::install(version = "3.12")"`, the inner quotes end the shell string early. It currently works because R receives the number `3.12`. Using single quotes (`'3.12'`) would be safer.
  - The directory name says escape 1.0.0, but nothing pins that version. Bioconductor 3.12 just installs whatever escape version that release has.
  - Current CRAN `devtools` is unlikely to install on R 4.0.3.

### `seurat3.2.3_r4.0.3_escape1.0.1`

- **Author**: Charlie Whittaker
- **Purpose**: Trying to re-create old PC environment
- **Base Image**: rocker/verse:4.0.3
- **Key Packages**: Same as `seurat3.2.3_r4.0.3_escape1.0.0`, plus GSVA and rmarkdown
- **Usage Notes**: Serves RStudio Server.
- **Potential Issues**:
  - The same quoting, escape-version and `devtools` issues as `seurat3.2.3_r4.0.3_escape1.0.0`.
  - The escape 1.0.0 and 1.0.1 images differ only by GSVA and rmarkdown, so the escape version itself is not what distinguishes them.

### `vb_R4.2.0`

- **Author**: Charlie Whittaker
- **Purpose**: Dockerfile to duplicate R 4.2.0 seurat 4 environment on luria
- **Base Image**: rocker/verse:4.2.0
- **Key Packages**: seurat4, destiny, deseq2, plus the same single-cell set as `abrfseurat` and Matrix.utils 0.9.8 (bundled tarball, which has been archived on CRAN)
- **Usage Notes**: Build from inside this directory so the `COPY` of `Matrix.utils_0.9.8.tar.gz` finds the tarball.
- **Potential Issues**:
  - The GitHub packages come from HEAD.
  - Unpinned CRAN repo on an older R (4.2.0).

---

### R: Combined single-cell + bulk

### `r4_5_1_python3_singlecell_visium`

- **Author**: Yann Vanrobaeys
- **Purpose**: Dockerfile R bulk single-cell visium analysis and python env
- **Base Image**: rocker/verse:4.5.1
- **Key Packages**: Seurat (`visium-hd` branch), Signac, SeuratDisk, Azimuth, rliger, UCell, SingleR, slingshot, monocle3, DoubletFinder, pagoda2, velocyto.R (YannVRB fork), liana, OmnipathR, chromVAR, motifmatchr, TFBSTools, JASPAR2024, BSgenome.Mmusculus.UCSC.mm10, EnsDb.Mmusculus.v79, DESeq2, edgeR, GSVA, clusterProfiler, scCustomize, DropletQC, colorway. Also a Python venv with CellBender (CPU-only PyTorch), linked as `cellbender` on the PATH.
- **Usage Notes**: Starts in `bash` with working directory `/work`.
- **Potential Issues**:
  - GitHub installs are wrapped in `try(..., silent=TRUE)`, so failures are hidden and the build still succeeds.
  - The image label says "load tests baked in", but the Dockerfile has no validation step.
  - Several packages are installed twice: Seurat (CRAN, then the `visium-hd` branch), velocyto.R (upstream, then a fork), and Signac, rliger and UCell.
  - The `visium-hd` branch of Seurat is a development branch, so it may be stale or deleted.

### `r4_5_3_singlecell_bulk_rnaseq`

- **Author**: Charlie Whittaker
- **Purpose**: Combined single-cell and bulk RNA-seq environment
- **Base Image**: rocker/verse:4.5.3
- **Key Packages**: Seurat, SingleR, slingshot, DoubletFinder, harmony, BPCells, SeuratWrappers, batchelor, DESeq2, edgeR, apeglm, tximport, clusterProfiler, GSVA, GSEABase, UCell, ComplexHeatmap, dittoSeq, scDataviz, SoupX, clustree, effectsize, OmnipathR
- **Usage Notes**: The packages are listed in `install_packages.R`, and `validate_packages.R` checks them during the build. Starts in `bash` with working directory `/work`.
- **Potential Issues**:
  - GitHub installs use `try(..., silent=TRUE)`, and `validate_packages.R` only warns, so a build with missing packages still succeeds.
  - Validation checks only 11 of about 45 packages.
  - The CRAN repo is `cloud.r-project.org`, not a date-pinned snapshot.

### `r4_6_1_singlecell_bulk_rnaseq`

- **Author**: Charlie Whittaker
- **Purpose**: Combined single-cell and bulk RNA-seq environment (successor to `r4_5_3`)
- **Base Image**: rocker/verse:4.6.1
- **Key Packages**: Everything in `r4_5_3`, plus enrichplot, ggtree, GseaVis, enrichit, msigdbr, yulab.utils, multcomp, sandwich, TH.data
- **Usage Notes**: The packages are listed in `install_packages.R`. `validate_packages.R` stops the build if a listed package fails to load. Starts in `bash` with working directory `/work`.
- **Potential Issues**:
  - Validation covers 20 of about 50 installed packages. A CRAN or Bioconductor package that fails to install only produces a warning, so any package missing from the validation list can go missing without failing the build.
  - The CRAN repo is `cloud.r-project.org`, not a date-pinned snapshot. GitHub packages are installed from HEAD.

---

### Command-line tools (Nextflow)

### `chopper`

- **Author**: Charlie Whittaker
- **Purpose**: Chopper, for quality and length filtering of ONT reads
- **Base Image**: quay.io/biocontainers/chopper:0.10.0--hcdda2d0_0
- **Key Packages**: chopper 0.10.0
- **Usage Notes**: The entrypoint is `chopper`, and the working directory is `/data`.
- **Potential Issues**:
  - `ENTRYPOINT ["chopper"]` can conflict with Nextflow, which starts each task with `/bin/bash -c ...`. The plain biocontainer has no entrypoint and may be the better choice for pipelines.

### `demultiplex`

- **Author**: Charlie Whittaker
- **Purpose**: Demultiplex tool for sequence demultiplexing - Nextflow compatible
- **Base Image**: quay.io/biocontainers/demultiplex:1.2.2--pyhdfd78af_1
- **Key Packages**: demultiplex 1.2.2
- **Usage Notes**: It only adds labels and a check that the tool runs, on top of the biocontainer.
- **Potential Issues**:
  - The check `demultiplex --help || --version || which` passes as long as the binary exists, so it won't catch a broken install.

### `dREG`

- **Author**: Allen Soberanes
- **Purpose**: An image with a GPU-compatible version of dREG installed, for use in "detection of regulatory DNA using PRO-seq and GRO-seq data".
- **Base Image**: rocker/cuda:4.0.5
- **Key Packages**: [dREG](https://github.com/Danko-Lab/dREG), [Rgtsvm](https://github.com/Danko-Lab/Rgtsvm), htslib, samtools, bcftools, bedGraphToBigWig
- **Usage Notes**: You can specify the CUDA architecture to build Rgtsvm with by passing the argument during the Docker build step (e.g. `docker build --build-arg CUDA_ARCH=sm_90 -f Dockerfile`). Defaults to the Ada architecture (sm_89), for compatibility with MIT's Engaging cluster.
- **Potential Issues**:
  - `ENV PATH dREG/:...` uses a relative path, so `run_dREG.bsh` is only found when the working directory is `/`. It should be `/dREG`.
  - `cuda-toolkit` is installed without a version pin, but `--with-cuda-home=/usr/local/cuda-13.1` is hardcoded. The build breaks once NVIDIA ships a different CUDA version.
  - The NVIDIA **ubuntu2204** apt repo is added to `rocker/cuda:4.0.5`, which is based on Ubuntu 20.04. Packages from that repo may not install or run correctly there.
  - `ENV PATH value` uses the legacy syntax without `=`, which Docker warns about.

### `flair`

- **Author**: Charlie Whittaker
- **Purpose**: FLAIR long-read isoform analysis, plus intron-prospector
- **Base Image**: brookslab/flair:3.0.0
- **Key Packages**: FLAIR 3.0.0, htslib (built from source), intron-prospector, Java (default-jre/jdk)
- **Usage Notes**: The Dockerfile is named `dockerfile` (lowercase).
- **Potential Issues**:
  - htslib and intron-prospector are cloned from their default branches without a pin, so the image is not reproducible.
  - The lowercase file name differs from the rest of the repo. Docker accepts it, but other tooling may not.

### `flye`

- **Author**: Charlie Whittaker
- **Purpose**: Flye long-read assembler
- **Base Image**: quay.io/biocontainers/flye:2.9.6--py310h275bdba_0
- **Key Packages**: flye 2.9.6
- **Usage Notes**: The entrypoint is `flye`, and the working directory is `/data`.
- **Potential Issues**:
  - `ENTRYPOINT ["flye"]` can conflict with Nextflow (see `chopper`).

### `foldx5`

- **Author**: Charlie Whittaker
- **Purpose**: software for FoldX_CRISPER_destabilization workflow
- **Base Image**: ubuntu:20.04
- **Key Packages**: FoldX 5.1 (with the YASARA plugin)
- **Usage Notes**: FoldX is licensed and is not in this repo. Put `foldx5_1Linux64_ver102725.zip` in this directory before building.
- **Potential Issues**:
  - The binary is `foldx_20251231`. FoldX binaries stop working on the date in their name, so this one likely expired on 2025-12-31. A fresh download will need the file names in the Dockerfile updated.
  - Ubuntu 20.04 reached the end of standard support in 2025.

### `general_genomics`

- **Author**: Charlie Whittaker
- **Purpose**: General-purpose Python and genomics command-line tools for Nextflow workflows
- **Base Image**: python:3.11-slim
- **Key Packages**: numpy, pandas, biopython, pyyaml, samtools, bedtools, bedops (apt), minimap2 (built from source)
- **Usage Notes**: The default command is `python`, and the working directory is `/app`.
- **Potential Issues**:
  - minimap2 is built from the default branch without a pin. The Python packages are also unpinned.
  - The samtools, bedtools and bedops versions come from Debian's apt repo and change whenever the base image changes.
  - It is a superset of the `python` image.

### `mageck`

- **Author**: Charlie Whittaker
- **Purpose**: MAGeCK, samtools, and bowtie2 for CRISPR screen analysis
- **Base Image**: continuumio/miniconda3:23.10.0-1
- **Key Packages**: mageck, bowtie2, samtools (conda-forge/bioconda)
- **Usage Notes**: It checks that all three tools run at the end of the build.
- **Potential Issues**:
  - `conda install` has no `-y`, so a non-interactive build is likely to stop at the confirmation prompt.
  - The conda package versions are not pinned.
  - The image uses the Anaconda `defaults` channel, which has licensing terms for some organizations.

### `nanoplotchopper`

- **Author**: Charlie Whittaker
- **Purpose**: software for ont flye nextflow
- **Base Image**: condaforge/mambaforge:latest
- **Key Packages**: chopper 0.10.0, NanoPlot, Python 3.11
- **Usage Notes**: The default command is `bash`, and the working directory is `/data`.
- **Potential Issues**:
  - `condaforge/mambaforge` is deprecated (Miniforge replaced it), and the `:latest` tag is not pinned.
  - NanoPlot is installed with pip without a version pin.

### `python`

- **Author**: Charlie Whittaker
- **Purpose**: basic python environment for nextflow workflows
- **Base Image**: python:3.11-slim
- **Key Packages**: numpy, pandas, biopython, pyyaml, plus compilers (gcc, g++, gfortran)
- **Usage Notes**: The default command is `python`, and the working directory is `/app`.
- **Potential Issues**:
  - The Python packages are not pinned.
  - It overlaps with `general_genomics`.

### `umitools`

- **Author**: Charlie Whittaker
- **Purpose**: umitools for sequence processing - Nextflow compatible
- **Base Image**: getwilds/umitools:1.1.6
- **Key Packages**: UMI-tools 1.1.6
- **Usage Notes**: It only adds labels and a check that the tool runs, on top of the base image.
- **Potential Issues**:
  - The comment in the Dockerfile says "official biocontainer", but the base image is `getwilds/umitools` (Fred Hutch WILDS), not a biocontainer.
  - The check `umi_tools --help || ...` passes as long as the binary exists, so it won't catch a broken install.

## Usage

To build a Docker image from any of these directories:

```bash
cd <project_directory>
docker build -t <your_image_name> .
```

## Contribution

Feel free to fork this repository and submit pull requests with improvements or new Dockerfiles.

## License

This repository is open-source and available under the MIT License.
