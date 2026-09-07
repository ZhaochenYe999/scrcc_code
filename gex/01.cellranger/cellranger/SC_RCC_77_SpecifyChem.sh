#!/bin/bash
#SBATCH --job-name=scrcc_77
#SBATCH --out="/dev/null"
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --mail-type=ALL
#SBATCH --partition=day

### Rerun SC_RCC_77 cellranger count with explicit chemistry ###
# Previous run failed at DETECT_COUNT_CHEMISTRY: too few confidently
# mapped reads to auto-distinguish SC5P-R2 vs SC3Pv2. Other RCC samples
# confirmed sc5p-r2 in their count_success telemetry, so pinning it here.

exec > "logs/SC_RCC_77.log" 2>&1

module load CellRanger/9.0.1
transcriptome_path="/gpfs/gibbs/pi/ycga/pacbio/gw92/10x/reference/refdata-gex-GRCh38-2024-A"
fastq_path="/vast/palmer/scratch/braun/zy325/gex_fastq"
output_path="/gpfs/gibbs/pi/braun/zy325/gex_cellranger/SC_RCC_77"

cellranger count --id=SC_RCC_77 \
	--transcriptome=${transcriptome_path} \
	--fastqs=${fastq_path} \
	--create-bam=false \
	--sample=SC_RCC_77_HHT \
	--chemistry=SC5P-R2 \
	--output-dir=${output_path} \
	--localcores=8 \
	--localmem=64
