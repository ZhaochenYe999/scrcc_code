#!/bin/bash
#SBATCH --job-name=clustering
#SBATCH --out="slurm-%j.out"
#SBATCH --partition=day
#SBATCH --account=braun
#SBATCH --cpus-per-task=8
#SBATCH --mem=256G
#SBATCH --time=08:00:00

module load miniconda
conda activate skinR44Py312

Rscript /home/zy325/scratch.braun/3.1.clustering_miya.R