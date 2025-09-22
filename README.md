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
