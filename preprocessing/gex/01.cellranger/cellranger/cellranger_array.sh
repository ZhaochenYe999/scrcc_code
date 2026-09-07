#!/bin/bash
#SBATCH --job-name=scrcc
#SBATCH --array=1-2
#SBATCH --out="/dev/null"
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --mail-type=ALL
#SBATCH --partition=day

### Slurm cellranger job array ###

sample_id=$(sed -n "${SLURM_ARRAY_TASK_ID}p" scrcc_samples.txt)

exec > "logs/${sample_id}.log" 2>&1

bash run_cellranger.sh ${sample_id}
