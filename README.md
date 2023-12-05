# Nicholas-BINF6309F2023-Module10
# plink tutorial on Hapmap1 
## Using PLINK to analyze example data: randomly selected genotypes (approximately 80,000 autosomal SNPs) from the 89 Asian HapMap individuals. A phenotype has been simulated based on the genotype at one SNP. 
## Walks through using PLINK to work with the data, using a range of features: data management, summary statistics, population stratification and basic association analysis.
## Script to run: bash sbatch_plink.sh
## Ensure you are on a compute node prior to running:
### srun --partition=short --pty --export=ALL --nodes=1 --ntasks=1 --mem=10Gb --time=00:20:00 /bin/bash 
### IMPORTANT - If want to see output files then need to take out the rm files in sbatch_plink.sh

# 2 bash scripts inside sbatch_plink.sh:
## 1) getExamples.sh - This script uses wget to download the input files found at https://zzz.bwh.harvard.edu/plink/hapmap1.zipLinks to scratch directory. Then unzip the resulting hapmap1.zip file in plink_analysis directory.
### New files created: hapmap1.ped, hapmap1.map, pop.phe, qt.phe

## 2) plinkHapmap1.sh - This script runs through the plink commands following along with the tutorial. 
### 1) Data management: Made binary PED files. Files created = hapmap1.bed, hapmap1.bim, and hapmap1.fam
### 2) Summary Statistics: Found summary statistics on missing rates. Files created = miss_stat.log, miss_stat.imiss, and miss_stat.lmiss
### 3) Population Stratification summary statistics: Allele frequencies - Without stratification - located in w_out_strat/ directory - Files created = freq_stat.log and freq_stat.frq
### 4) Stratified by pop.phe data: located in w_strat/ directory. Files created = freq_stat.log and freq_stat.frq.strat
### 5) Basic association analysis: Adjusted for multiple testing. Files created = as2.log, as2.assoc (the uncorrect original associations), and as2.assoc.adjusted (associations adjusted by various methods for multiple testing)
#### columns: Chromosome
##### SNP identifier
##### Unadjusted, asymptotic significance value
##### Genomic control adjusted significance value. This is based on a simple estimation of the inflation factor based on median chi-square statistic. These values do not control for multiple testing therefore.
##### Bonferroni adjusted significance value
##### Holm step-down adjusted significance value
##### Sidak single-step adjusted significance value
##### Sidak step-down adjusted significance value
##### Benjamini & Hochberg (1995) step-up FDR control
##### Benjamini & Yekutieli (2001) step-up FDR control
#### No single variant is significant at the 0.05 level after genome-wide correction. After genomic correlation analysis, the mean chi-squared statistic is 1.18739. No very strong stratification exists, there is perhaps a hint of an increased false positive rate, as both values are greater than 1.00.
### 6) Genotyping and other association models: Files created = mod2.model and mod2.log
#### all are highly significant (as would be expected for a strong, common, allelic effect) although the allelic test has the most significant p-value. This makes sense, as the data were essentially simulated under an allelic (dosage) model.
### 7) Stratification Analysis: genome-wide IBS clustering constrained to require at least one case and one control per cluster, and ppc threshold of 0.01 constrained to clusters of no more than 2 individuals). Files created = version2.log, version2.cluster1, version2.cluster2, version2.cluster3
### 8) Association analysis, accounting for clusters: using Cochran-Mantel-Haenszel association statistic. Tests for SNP-disease association conditional on the clusering supplied by the cluster file. Files created = aac2.log, aac2.cmh, and aac2.cmh.adjusted
#### rs2222162 now has a significance value of 5.47e-05 even if we use Bonferroni adjustment for multiple comparisons.
### 9) Quantitative trait association analysis (with permutation) Files created = quant2.log, quant2.qassoc, and quant2.qassoc.perm
### 10) Extracting a SNP of interest: for just snp rs2222162. Files created = rec_snp1.log and rec_snp1.raw
