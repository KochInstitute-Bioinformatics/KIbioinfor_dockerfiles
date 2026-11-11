#!/usr/bin/env Rscript
#
# Install one stage of R packages.
# Usage: Rscript install_packages.R <cran|bioc|github|repo> <package list file>
#
# List formats: cran/bioc have one package per line; github has
# "<package> <pak ref>"; repo has "<package> <repo URL>" (e.g. an r-universe repo).
#
# Each stage runs in its own Docker layer, so a failure only re-runs that stage.
# Repos are left as configured by rocker/verse (P3M Ubuntu binaries for CRAN).

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 2 || !args[1] %in% c("cran", "bioc", "github", "repo")) {
  stop("Usage: install_packages.R <cran|bioc|github|repo> <package list file>", call. = FALSE)
}
stage <- args[1]
list_file <- args[2]

options(
  # Parallel installs; each source compile can use 1-2 GB of RAM
  Ncpus = as.integer(Sys.getenv("NCPUS", "4")),
  # Default is 60s, too short for large package downloads
  timeout = 3600
)

read_list <- function(path) {
  lines <- trimws(sub("#.*$", "", readLines(path)))
  lines[nzchar(lines)]
}

# install.packages() and BiocManager::install() only warn on failure,
# so check explicitly and fail the stage
check_installed <- function(pkgs) {
  missing <- setdiff(pkgs, rownames(installed.packages()))
  if (length(missing)) {
    stop("Failed to install: ", paste(missing, collapse = ", "), call. = FALSE)
  }
}

entries <- read_list(list_file)
message("R ", getRversion(), "; repos: ", paste(getOption("repos"), collapse = ", "))
message("Stage '", stage, "': ", length(entries), " packages")

if (stage == "cran") {
  pkgs <- entries
  to_install <- setdiff(pkgs, rownames(installed.packages()))
  if (length(to_install)) install.packages(to_install)

} else if (stage == "bioc") {
  if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
  message("Bioconductor version: ", BiocManager::version())
  pkgs <- entries
  to_install <- setdiff(pkgs, rownames(installed.packages()))
  # update = FALSE: don't upgrade packages already in the base image
  if (length(to_install)) BiocManager::install(to_install, update = FALSE, ask = FALSE)

} else if (stage == "github") {
  if (!requireNamespace("pak", quietly = TRUE)) install.packages("pak")
  fields <- strsplit(entries, "[[:space:]]+")
  pkgs <- vapply(fields, `[`, character(1), 1)
  refs <- vapply(fields, `[`, character(1), 2)
  # pak errors on failure, uses P3M binaries for dependencies,
  # and installs any missing system libraries via apt
  pak::pak(refs, upgrade = FALSE)
  pak::cache_clean()

} else if (stage == "repo") {
  fields <- strsplit(entries, "[[:space:]]+")
  pkgs <- vapply(fields, `[`, character(1), 1)
  urls <- unique(vapply(fields, `[`, character(1), 2))
  # Listed repos first, then the base image's repos for dependencies
  install.packages(pkgs, repos = c(urls, getOption("repos")))
}

check_installed(pkgs)
message("Stage '", stage, "' complete")
