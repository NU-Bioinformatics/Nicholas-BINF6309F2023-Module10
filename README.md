# Nicholas-BINF6309F2023-Module10
# plink tutorial on Hapmap1 
## Using PLINK to analyze example data: randomly selected genotypes (approximately 80,000 autosomal SNPs) from the 89 Asian HapMap individuals. A phenotype has been simulated based on the genotype at one SNP. 
## Walks through using PLINK to work with the data, using a range of features: data management, summary statistics, population stratification and basic association analysis.

## Data management: Made binary PED files
### hapmap1.bed, hapmap1.bim, and hapmap1.fam

## Summary Statistics: Found summary statistics on missing rates:
### miss_stat.log, miss_stat.imiss, and miss_stat.lmiss

## Population Stratification summary statistics: Allelet frequencies
### Without stratification - located in w_out_strat/ directory
#### freq_stat.log and freq_stat.frq
### Stratified by pop.phe data: located in w_strat/ directory
#### freq_stat.log and freq_stat.frq.strat


## Basic association analysis: Adjusted for multiple testing
### as2.log, as2.assoc (the uncorrect original associations), and as2.assoc.adjusted (associations adjusted by various methods for multiple testing)
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
### No single variant is significant at the 0.05 level after genome-wide correction. After genomic correlation analysis, the mean chi-squared statistic is 1.18739. No very strong stratification exists, there is perhaps a hint of an increased false positive rate, as both values are greater than 1.00.

## Genotyping and other association models:
### mod2.model and mod2.log
### all are highly significant (as would be expected for a strong, common, allelic effect) although the allelic test has the most significant p-value. This makes sense, as the data were essentially simulated under an allelic (dosage) model.

## Stratification Analysis: genome-wide IBS clustering constrained to require at least one case and one control per cluster, and ppc threshold of 0.01 constrained to clusters of no more than 2 individuals)
### version2.log, version2.cluster1, version2.cluster2, version2.cluster3

## Association analysis, accounting for clusters: using Cochran-Mantel-Haenszel association statistic. Tests for SNP-disease association conditional on the clusering supplied by the cluster file.
### aac2.log, aac2.cmh, and aac2.cmh.adjusted
### rs2222162 now has a significance value of 5.47e-05 even if we use Bonferroni adjustment for multiple comparisons.


## Quantitative trait association analysis (with permutation)
### quant2.log, quant2.qassoc, and quant2.qassoc.perm
### quant3.qassoc.gxe - shows association within the continuous phenotype. The file shows show the number of non-missing individuals in each category along with the regression coefficient and standard error, followed by a test of whether these two regression coefficients are significantly different (Z_GXE) and an asymptotic significance value (P_GXE). In this case, we see the similar effect in both populations (regression coefficients around -2) and the test for interaction of SNP x population interaction is not significant.

## Extracting a SNP of interest: for just snp rs2222162
### rec_snp1.log and rec_snp1.raw
