#!/bin/bash
#SBATCH --job-name=scrcc_07_resume
#SBATCH --out="/dev/null"
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --mail-type=ALL
#SBATCH --partition=day

### Resume SC_RCC_07 cellranger count (previous run TIMEOUT at 8h, 45/95 ALIGN_AND_COUNT chunks done) ###

exec > "logs/SC_RCC_07.log" 2>&1

bash run_cellranger.sh SC_RCC_07
