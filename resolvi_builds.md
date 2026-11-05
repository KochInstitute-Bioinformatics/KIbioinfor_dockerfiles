# resolVI image builds

There are two resolVI images in this repo. They differ in which scvi-tools they install and in what else they include.

| | `resolvi` | `resolvi_paperVariant` |
|---|---|---|
| **Purpose** | Run resolVI on your own data with a current, installable release | Match the software the resolVI manuscript was written with |
| **scvi-tools source** | PyPI, `scvi-tools==1.5.2` (latest release) | `scvi-tools-resolvi_fix.tar.gz` from Zenodo (10.5281/zenodo.19811112) |
| **scvi-tools version** | 1.5.2 | 1.4.1 base with the paper's resolVI fixes (the CHANGELOG has unreleased 1.4.2 entries, such as size-factor support and an importance-sampling flag for differential expression) |
| **Reproducibility code** | Not included | Included at `/opt/resolvi-reproducibility`; `run_model.py` and `_utils.py` are copied into `scripts/` |
| **Extra packages** | scanpy, leidenalg, jupyterlab | click, seaborn, pomegranate (1.x), harmony-pytorch, leidenalg, jupyterlab |
| **Downloads at build** | PyPI only | PyPI plus both Zenodo archives, each checked against its MD5 sum |
| **Base image** | `python:3.12-slim-bookworm` | `python:3.12-slim-bookworm` |
| **Docker Hub name** | `bumproo/resolvi:<date>` | `bumproo/resolvi_papervariant:<date>` (Docker requires lowercase) |

## Which one to use

- **`resolvi`**: for analyzing your own spatial data. It is the simpler image and gets a normal PyPI release. Note that the scvi-tools docs say resolVI moved to scVIVA-Tools from v1.5 and is no longer maintained in scvi-tools. 1.5.2 still ships `scvi.external.RESOLVI`, but later releases may not.
- **`resolvi_paperVariant`**: for rerunning the paper's training scripts, or for checking results against the manuscript. Use this when you need the patched resolVI code and not the PyPI release.

## What "paper variant" does and does not guarantee

- **The scvi-tools code matches the paper.** It is the exact archive the authors deposited, and the build checks its MD5 sum.
- **The environment is not an exact match.** The archive has no lockfile, so torch, pyro, scanpy, pomegranate and the other dependencies resolve to whatever is current on the build day.
- **The notebooks are missing.** The figure notebooks in the Zenodo archive are Git LFS pointer files (about 130 bytes), not real notebooks. Only the scripts, marker JSON files and `_utils.py` are usable.
- **The shell scripts need path edits.** The scripts in `training_scripts/` use the authors' data paths and refer to marker files such as `xenium_brain/celltype_markers.json`. The archive's marker files are in `figure2/` and `training_scripts/`.
- **`run_model.py` has one hardcoded path.** Its `sys.path.insert` points to the authors' home directory. It does nothing in the container, and the patched install is used.

## Shared notes

- Both images can run on CPU, but resolVI is slow without a GPU. On the clusters, run with `apptainer exec --nv`, or with `docker run --gpus all` under Docker. The PyPI torch wheels bundle CUDA, so neither image needs a CUDA base.
- Neither image installs `rapids-singlecell`. It is optional, and resolVI falls back to a CPU neighbor graph without it.
- Both builds end with an import check, so a broken install fails the build.
- Tag each build with its build date only, for example `bumproo/resolvi:2026-11-04`.
