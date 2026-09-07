#!/bin/bash

### Rename fastq files ###
# fastq files should be put under
# the same path as this script

for f in *_R2_*.fastq*; do
    mv "$f" "${f/_R2_/_TMP_}"
done

for f in *_R3_*.fastq*; do
    mv "$f" "${f/_R3_/_R2_}"
done

for f in *_TMP_*.fastq*; do
    mv "$f" "${f/_TMP_/_I2_}"
done
