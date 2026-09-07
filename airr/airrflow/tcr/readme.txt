1. Manually copy fastq files from SAY
2. Run rename.sh to standardize the filename
3. Create samplesheet_scrcc_tcr.tsv
4. Run run_airrflow_scrcc_tcr.sh
5. SCRCC63 and SCRCC77 have 0 cells pass QC, thus removed from samplesheet, and resume the same airrflow run
# Deleted from samplesheet:
# SCRCC77	/gpfs/gibbs/pi/kleinstein/zhaochen_rcc/scrcc/tcr_fastq/fastq_v2/SCRCC77_S15_L002_R1_001.fastq.gz	/gpfs/gibbs/pi/kleinstein/zhaochen_rcc/scrcc/tcr_fastq/fastq_v2/SCRCC77_S15_L002_R2_001.fastq.gz	SCRCC77	human	TR	tumor	NA	NA	Yale	TRUE
# SCRCC63	/gpfs/gibbs/pi/kleinstein/zhaochen_rcc/scrcc/tcr_fastq/fastq_v2/SCRCC63_S15_L004_R1_001.fastq.gz	/gpfs/gibbs/pi/kleinstein/zhaochen_rcc/scrcc/tcr_fastq/fastq_v2/SCRCC63_S15_L004_R2_001.fastq.gz	SCRCC63	human	TR	tumor	NA	NA	Yale	TRUE
