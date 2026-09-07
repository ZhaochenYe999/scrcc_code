#!/bin/bash
#SBATCH --job-name=airrflow_tcr
#SBATCH --out="slurm-%j.out"
#SBATCH --time=06-23:00:00
#SBATCH --cpus-per-task=2
#SBATCH --mem=5G
#SBATCH --mail-type=ALL
#SBATCH --partition=pi_kleinstein

module load Java/17.0.4

export NXF_WRAPPER_STAGE_FILE_THRESHOLD='30000'
nextflow pull nf-core/airrflow -r 5.1.1
nextflow run nf-core/airrflow -r 5.1.1 \
	-profile mccleary \
	--mode fastq \
	--library_generation_method sc_10x_genomics \
	--reference_10x /gpfs/gibbs/pi/kleinstein/zhaochen_rcc/scrcc/refdata-cellranger-vdj-GRCh38-alts-ensembl-7.1.0 \
	--input /gpfs/gibbs/pi/kleinstein/zhaochen_rcc/scrcc/tcr_output/samplesheet_scrcc_tcr.tsv \
	--outdir /gpfs/gibbs/pi/kleinstein/zhaochen_rcc/scrcc/tcr_output/tcr_airrflow \
	--embeddings esm2 \
	--clonal_threshold 0 \
	--use_gpu \
	-c /gpfs/gibbs/pi/kleinstein/zhaochen_rcc/scrcc/tcr_output/custom_tcr.config \
	-w /vast/palmer/scratch/kleinstein/zy325/work_scrcc_tcr \
	-resume
