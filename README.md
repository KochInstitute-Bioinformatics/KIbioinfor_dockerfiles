# Dockerfile Collection

This repository contains a curated collection of Dockerfiles for various bioinformatics and data science workflows. Each subdirectory represents a distinct environment or project setup, typically including a `Dockerfile` and related configuration files.

## Project Directories

Below is a list of available Docker environments:

- `091922_crispr_gbm`
- `abrfseurat`
- `bulk_r441`
- `bulk_r443`
- `bulk_rnaseq_052323`
- `bulk_rnaseq_crispr_061924`
- `bulk_rnaseq_crispr_082223`
- `chopper`
- `flye`
- `foldx5`
- `nanoplotchopper`
- `python`
- `RNAseqClass_Image`
- `scRNAseq_Seurat3_R3.6.3`
- `scRNAseq_Seurat3_R4.0.3`
- `scRNAseq_Seurat5`
- `seurat3.2.3_r3.6.3`
- `seurat3.2.3_r4.0.3_escape1.0.0`
- `seurat3.2.3_r4.0.3_escape1.0.1`
- `vb_R4.2.0`

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
