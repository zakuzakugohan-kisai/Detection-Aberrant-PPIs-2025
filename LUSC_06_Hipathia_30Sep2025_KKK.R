################################################################################
# Project: Model-based quantification of protein–protein interaction aberrations
#             for exploring dysregulated signalling pathways 
#             through pathway maps and gene expression levels
# Program: LUSC_06_Hipathia_30Sep2025_KKK.R
# Objective: Detection of dysregulated signalling pathways 
# Author: Kenta Kevee Kisaï
# R version: 4.5.1
# Platform: Windows
# Made: 8 September 2025
# Update: 30 September 2025
# Note:
################################################################################

#------------------------------------------------------------------------------#
# Working directory
# Input: None
# Output: None
#------------------------------------------------------------------------------#
getwd()

#------------------------------------------------------------------------------#
# File loading
  # Input: 2_TCGA_LUSC_RNASeq_Group_8Jul2024.xlsx 
  #           and 2_TCGA_LUSC_RNASeq_UnstrandedTPM_9Jul2024.xlsx
  # Output: GROUP_01 and TPM_01
#------------------------------------------------------------------------------#
install.packages('readxl')
library(readxl)
GROUP_01 <- read_excel('../1_RAW/2_TCGA_LUSC_RNASeq_Group_8Jul2024.xlsx')
TPM_01 <- read_excel('../1_RAW/2_TCGA_LUSC_RNASeq_UnstrandedTPM_9Jul2024.xlsx')

#------------------------------------------------------------------------------#
# Analysis using HiPathia
# Input: GROUP_01 and TPM_01
# Output: CMP_01
#------------------------------------------------------------------------------#
# Remove Ensembl gene ID version
TPM_02 <- TPM_01
TPM_02$Gene_id <- sub('\\..*', '', TPM_02$Gene_id)

# Extract expression matrix
TPM_03 <- as.matrix(TPM_02[, -(1:2)])
rownames(TPM_03) <- TPM_02$Gene_id

# Translate gene IDs to Entrez IDs
BiocManager::install('hipathia')
library(hipathia)
EXP_01 <- translate_data(TPM_03, 'hsa')

# Scale the data between 0 and 1 based on percentile
EXP_02 <- normalize_data(EXP_01, percentil = TRUE)

# Load the mTOR signalling pathway in human
PATH_01 <- load_pathways(species = 'hsa', pathways_list = 'hsa04150')

# Compute signal scores for decomposed pathways
SGNL_01 <- hipathia(EXP_02, PATH_01, decompose = TRUE)
SGNL_02 <- get_paths_data(SGNL_01, matrix = TRUE)

# Extract group information
GROUP_02 <- GROUP_01$GROUP

# Compare signal scores between the case and control
CMP_01 <- do_wilcoxon(SGNL_02, GROUP_02, g1 = 'LUSC', g2 = 'NST', paired = TRUE)





