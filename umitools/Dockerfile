# Use the official biocontainer for umitools as a base
FROM getwilds/umitools:1.1.6

# Add metadata labels for better documentation
LABEL maintainer="charliew@mit.edu"
LABEL description="umitools for sequence processing - Nextflow compatible"
LABEL version="1.1.6"
LABEL base_image="getwilds/umitools:1.1.6"

# Verify the tool is installed and accessible
RUN umi_tools --help || umi_tools --version || which umi_tools