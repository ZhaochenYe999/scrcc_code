#!/bin/bash

### Running CellRanger per sample ###
# Time: 2026-08-03
# Input: sample id
# Output: folder named sample id

job_id=$1
sample_id="${job_id}_HHT"
echo "Running cellranger count for sample ${job_id}"

module load CellRanger/9.0.1
transcriptome_path="/gpfs/gibbs/pi/ycga/pacbio/gw92/10x/reference/refdata-gex-GRCh38-2024-A"
fastq_path="/vast/palmer/scratch/braun/zy325/gex_fastq"
output_path="/gpfs/gibbs/pi/braun/zy325/gex_cellranger/${job_id}"

cellranger count --id=${job_id} \
	--transcriptome=${transcriptome_path} \
	--fastqs=${fastq_path} \
	--create-bam=false \
	--sample=${sample_id} \
	--output-dir=${output_path}\
	--localcores=8 \
	--localmem=64
