# Dockerfile Collection

This repository contains a curated collection of Dockerfiles for various bioinformatics and data science workflows. Each subdirectory represents a distinct environment or project setup, typically including a `Dockerfile` and related configuration files.

## Project Directories

Below is an outline of available Docker environments with placeholders for metadata:

### `abrfseurat`

- **Author**: Charlie Whittaker/Alex Lemenze
- **Purpose**: _Brief description of the environment or workflow_
- **Base Image**: _e.g., rocker/verse:4.2.0_
- **Key Packages**: _List of major R or Python packages installed_
- **Usage Notes**: _Any special instructions for building or running_

### `bulk_r441`

- **Author**: Charlie Whittaker
- **Purpose**: _Brief description of the environment or workflow_
- **Base Image**: _e.g., rocker/verse:4.2.0_
- **Key Packages**: _List of major R or Python packages installed_
- **Usage Notes**: _Any special instructions for building or running_

### `bulk_r443`

- **Author**: Charlie Whittaker
- **Purpose**: _Brief description of the environment or workflow_
- **Base Image**: _e.g., rocker/verse:4.2.0_
- **Key Packages**: _List of major R or Python packages installed_
- **Usage Notes**: _Any special instructions for building or running_

### `bulk_rnaseq_052323`

- **Author**: Charlie Whittaker
- **Purpose**: _Brief description of the environment or workflow_
- **Base Image**: _e.g., rocker/verse:4.2.0_
- **Key Packages**: _List of major R or Python packages installed_
- **Usage Notes**: _Any special instructions for building or running_

### `bulk_rnaseq_crispr_061924`

- **Author**: Charlie Whittaker
- **Purpose**: _Brief description of the environment or workflow_
- **Base Image**: _e.g., rocker/verse:4.2.0_
- **Key Packages**: _List of major R or Python packages installed_
- **Usage Notes**: _Any special instructions for building or running_

### `bulk_rnaseq_crispr_082223`

- **Author**: Charlie Whittaker
- **Purpose**: _Brief description of the environment or workflow_
- **Base Image**: _e.g., rocker/verse:4.2.0_
- **Key Packages**: _List of major R or Python packages installed_
- **Usage Notes**: _Any special instructions for building or running_

### `chopper`

- **Author**: Charlie Whittaker
- **Purpose**: _Brief description of the environment or workflow_
- **Base Image**: _e.g., rocker/verse:4.2.0_
- **Key Packages**: _List of major R or Python packages installed_
- **Usage Notes**: _Any special instructions for building or running_

### `flye`

- **Author**: Charlie Whittaker
- **Purpose**: _Brief description of the environment or workflow_
- **Base Image**: _e.g., rocker/verse:4.2.0_
- **Key Packages**: _List of major R or Python packages installed_
- **Usage Notes**: _Any special instructions for building or running_

### `foldx5`

- **Author**: Charlie Whittaker
- **Purpose**: software for FoldX_CRISPER_destabilization workflow
- **Base Image**: _e.g., rocker/verse:4.2.0_
- **Key Packages**: _List of major R or Python packages installed_
- **Usage Notes**: _Any special instructions for building or running_

### `nanoplotchopper`

- **Author**: Charlie Whittaker
- **Purpose**: software for ont flye nextflow
- **Base Image**: _e.g., rocker/verse:4.2.0_
- **Key Packages**: _List of major R or Python packages installed_
- **Usage Notes**: _Any special instructions for building or running_

### `python`

- **Author**: Charlie Whittaker
- **Purpose**: basic python environment for nextflow workflows
- **Base Image**: _e.g., rocker/verse:4.2.0_
- **Key Packages**: _List of major R or Python packages installed_
- **Usage Notes**: _Any special instructions for building or running_

### `RNAseqClass_Image`

- **Author**: Charlie Whittaker
- **Purpose**: Teaching Rstudio image
- **Base Image**: _e.g., rocker/verse:4.2.0_
- **Key Packages**: _List of major R or Python packages installed_
- **Usage Notes**: _Any special instructions for building or running_

### `scRNAseq_Seurat3_R3.6.3`

- **Author**: Charlie Whittaker
- **Purpose**: Trying to re-create old PC environment
- **Base Image**: _e.g., rocker/verse:4.2.0_
- **Key Packages**: _List of major R or Python packages installed_
- **Usage Notes**: _Any special instructions for building or running_

### `scRNAseq_Seurat3_R4.0.3`

- **Author**: Charlie Whittaker
- **Purpose**: Trying to re-create old PC environment
- **Base Image**: _e.g., rocker/verse:4.2.0_
- **Key Packages**: _List of major R or Python packages installed_
- **Usage Notes**: _Any special instructions for building or running_

### `scRNAseq_Seurat5`

- **Author**: Charlie Whittaker
- **Purpose**: _Brief description of the environment or workflow_
- **Base Image**: _e.g., rocker/verse:4.2.0_
- **Key Packages**: _List of major R or Python packages installed_
- **Usage Notes**: _Any special instructions for building or running_

### `seurat3.2.3_r3.6.3`

- **Author**: Charlie Whittaker
- **Purpose**: Trying to re-create old PC environment
- **Base Image**: _e.g., rocker/verse:4.2.0_
- **Key Packages**: _List of major R or Python packages installed_
- **Usage Notes**: _Any special instructions for building or running_

### `seurat3.2.3_r4.0.3_escape1.0.0`

- **Author**: Charlie Whittaker
- **Purpose**: Trying to re-create old PC environment_
- **Base Image**: _e.g., rocker/verse:4.2.0_
- **Key Packages**: _List of major R or Python packages installed_
- **Usage Notes**: _Any special instructions for building or running_

### `seurat3.2.3_r4.0.3_escape1.0.1`

- **Author**: Charlie Whittaker
- **Purpose**: Trying to re-create old PC environment
- **Base Image**: _e.g., rocker/verse:4.2.0_
- **Key Packages**: _List of major R or Python packages installed_
- **Usage Notes**: _Any special instructions for building or running_

### `vb_R4.2.0`

- **Author**: Charlie Whittaker
- **Purpose**: Dockerfile to duplicate R 4.2.0 seurat 4 environment on luria
- **Base Image**: rocker/verse:4.2.0
- **Key Packages**: seurat4, destiny, deseq2
- **Usage Notes**: _Any special instructions for building or running_

### `r4_5_1_python3_singlecell_visium`

- **Author**: Yann Vanrobaeys
- **Purpose**: Dockerfile R bulk single-cell visium analysis and python env
- **Base Image**: rocker/verse:4.5.1
- **Key Packages**:
Loading: Seurat ... OK
Loading: Signac ... OK
Loading: Matrix ... OK
Loading: dplyr ... OK
Loading: cowplot ... OK
Loading: ggplot2 ... OK
Loading: ggrepel ... OK
Loading: patchwork ... OK
Loading: data.table ... OK
Loading: matrixStats ... OK
Loading: clustree ... OK
Loading: SoupX ... OK
Loading: gprofiler2 ... OK
Loading: VAM ... OK
Loading: openxlsx ... OK
Loading: kableExtra ... OK
Loading: ggpubr ... OK
Loading: ComplexUpset ... OK
Loading: ggseqlogo ... OK
Loading: SeuratDisk ... OK
Loading: rliger ... OK
Loading: hexbin ... OK
Loading: UCell ... OK
Loading: terra ... OK
Loading: ggrastr ... OK
Loading: Azimuth ... OK
Loading: SingleR ... OK
Loading: slingshot ... OK
Loading: scRNAseq ... OK
Loading: edgeR ... OK
Loading: apeglm ... OK
Loading: DESeq2 ... OK
Loading: pcaMethods ... OK
Loading: clusterProfiler ... OK
Loading: dittoSeq ... OK
Loading: scDataviz ... OK
Loading: GSEABase ... OK
Loading: ComplexHeatmap ... OK
Loading: GSVA ... OK
Loading: TFBSTools ... OK
Loading: motifmatchr ... OK
Loading: chromVAR ... OK
Loading: BiocGenerics ... OK
Loading: DelayedArray ... OK
Loading: SummarizedExperiment ... OK
Loading: batchelor ... OK
Loading: HDF5Array ... OK
Loading: BSgenome.Mmusculus.UCSC.mm10 ... OK
Loading: EnsDb.Mmusculus.v79 ... OK
Loading: JASPAR2024 ... OK
Loading: SeuratWrappers ... OK
Loading: DoubletFinder ... OK
Loading: monocle3 ... OK
Loading: colorway ... OK
Loading: DropletQC ... OK
Loading: scCustomize ... OK
Loading: pagoda2 ... OK
Loading: velocyto.R ... OK
Loading: liana ... OK

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
