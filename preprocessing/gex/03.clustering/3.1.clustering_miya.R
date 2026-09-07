options(future.globals.maxSize = 2 * 1024^3) # 2GB
library(Seurat)
library(dplyr)
library(data.table)
library(ggplot2)
source("~/Projects/heads/clustering.r")

data_dir = "/gpfs/gibbs/pi/braun/zy325"

### Sample-level QC ###
# Based on web summary (cellranger)
# Samples are filtered due to
# 1. Median genes per cell < 500
# 2. Estimated number of cells < 100
# 3. Not kidney tumor

rm_samples = paste0("SC_RCC_",c("08","17","25","34","63","77",
                                "69"))

### Miya ###

obj_path = "/gpfs/gibbs/pi/braun/mh2632/SC_RCC_Individual_RDS/SC_RCC_merged_20230612.rds"

obj = readRDS(obj_path)

meta = obj@meta.data
meta = meta[,-grep("pANN_|DF.classifications_",colnames(meta))]

meta = meta %>% mutate(
    name=rownames(meta),
    sample_id3=gsub("_PostQC.*$","",name),
    sample_id3=gsub("_new_mt","",sample_id3))

meta$sample_id3[meta$sample_id3 == "SC_07_NORM"] = "SC_07_NK"
meta$orig.ident[meta$sample_id3 == "SC_64_NORM"] = "SC_64_NORM"

meta = meta %>% mutate(
    sample_id1 = gsub("SC_","SC_RCC_",sample_id3),
    sample_id2 = gsub("_","",sample_id1)) %>%
    select(
        orig.ident,nCount_RNA,nFeature_RNA,percent.mt,name,
        sample_id1,sample_id2,sample_id3,DoubletScore,DoubletCall)

obj@meta.data = meta

### Batch ###

batch = as.data.frame(fread(file.path(data_dir,"metadata","batch.csv")))

meta = left_join(obj@meta.data,batch,by="sample_id1")
rownames(meta) = rownames(obj@meta.data)

obj@meta.data = meta

obj = obj[,-which(obj$sample_id1 %in% rm_samples)]

obj[["RNA"]] = as(obj[["RNA"]],"Assay5")

obj = clustering(obj,
                plot_QC_metrics = F,
                group.by.vars = "batch_lab",
                harmony_theta = 1,dims = 1:50)

saveRDS(obj,file=file.path(data_dir,"processed","theta1_dims50","scrcc_miya_clustered.rds"))

message("Done.")
