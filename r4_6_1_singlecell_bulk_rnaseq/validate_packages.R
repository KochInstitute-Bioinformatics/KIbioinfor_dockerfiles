#!/usr/bin/env Rscript
#
# Load every package in the *.txt package lists and fail if any don't load.
# Usage: Rscript validate_packages.R <packages directory>

args <- commandArgs(trailingOnly = TRUE)
pkg_dir <- if (length(args)) args[1] else "packages"

read_list <- function(path) {
  lines <- trimws(sub("#.*$", "", readLines(path)))
  lines[nzchar(lines)]
}

# Every *.txt list in the directory; the first column of each line is the
# package name (GitHub lists also have a ref)
packages <- unlist(lapply(
  list.files(pkg_dir, pattern = "\\.txt$", full.names = TRUE),
  function(f) vapply(strsplit(read_list(f), "[[:space:]]+"), `[`, character(1), 1)
))

message("===== VALIDATION: ", length(packages), " R package namespaces =====")

failed <- character()

for (pkg in packages) {
  ok <- tryCatch(
    {
      loadNamespace(pkg)
      TRUE
    },
    error = function(e) {
      message("  ✗ ", pkg, ": ", conditionMessage(e))
      FALSE
    }
  )

  if (ok) {
    message("  ✓ ", pkg, " ", as.character(packageVersion(pkg)))
  } else {
    failed <- c(failed, pkg)
  }
}

if (length(failed)) {
  stop(
    "Validation failed for: ",
    paste(failed, collapse = ", "),
    call. = FALSE
  )
}

message("All requested package namespaces loaded successfully.")
