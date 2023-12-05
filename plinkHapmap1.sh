#!/bin/bash
# plinkHapmap1.sh
## Bash script to run plink commands following along with the tutorial (https://zzz.bwh.harvard.edu/plink/tutorial.shtml)

# Load necessary modules and activate environment
# module load anaconda3/2021.11
# module load binf6309/01-14-2022
# source activate BINF-12-2021

# Set the path to PLINK executable
PLINK="plink"

# Set your scratch directory
SCRATCH_DIR="/scratch/chevalier.n/Nicholas-BINF6309F2023-Module10/plink_analysis"

# Step 1: Making a binary PED file at default filter settings
echo "Step 1: Making a binary PED file at default filter settings..."
$PLINK --file "$SCRATCH_DIR/hapmap1" --make-bed --out "$SCRATCH_DIR/hapmap1"
echo "Step 1 complete. Files created: hapmap1.bed, hapmap1.bim, and hapmap1.fam"

# Step 2: Summary statistics - missing rates
echo "Step 2: Summary statistics - missing rates..."
$PLINK --bfile "$SCRATCH_DIR/hapmap1" --missing --out "$SCRATCH_DIR/miss_stat"
echo "Step 2 complete. Files created: miss_stat.log, miss_stat.imiss, and miss_stat.lmiss"

# Step 3: Summary statistics - allele frequencies (without stratification)
echo "Step 3: Summary statistics - allele frequencies (without stratification)..."
mkdir w_out_strat
W_OUT_STRAT_DIR="/scratch/chevalier.n/Nicholas-BINF6309F2023-Module10/plink_analysis/w_out_strat" 
$PLINK --bfile "$SCRATCH_DIR/hapmap1" --freq --out "$W_OUT_STRAT_DIR/freq_stat"
echo "Step 3 complete. Files located in w_strat. Files created: freq_stat.log and freq_stat.frq"

# Step 4: Summary statistics - allele frequencies (stratified by pop.phe data)
echo "Step 4: Summary statistics - allele frequencies (stratified by pop.phe data)..."
mkdir w_strat
STRAT_DIR="/scratch/chevalier.n/Nicholas-BINF6309F2023-Module10/plink_analysis/w_strat"
$PLINK --bfile "$SCRATCH_DIR/hapmap1" --freq --within "$SCRATCH_DIR/pop.phe" --out "$STRAT_DIR/freq_stat"
echo "Step 4 complete. Files located in w_out_strat. Files created: freq_stat.log and freq_stat.frq.strat"

# Step 5: Basic association analysis (adjusted for multiple testing)
echo "Step 5: Basic association analysis (adjusted for multiple testing)..."
$PLINK --bfile "$SCRATCH_DIR/hapmap1" --assoc --adjust --out "$SCRATCH_DIR/as2"
echo "Step 5 complete. Files created: as2.log, as2.assoc (the uncorrect original associations), and as2.assoc.adjusted (associations adjusted by various methods for multiple testing)"

# Step 6: Genotypic and other association models (run with the --cell 0 override)
echo "Step 6: Genotypic and other association models (run with the --cell 0 override)..."
$PLINK --bfile "$SCRATCH_DIR/hapmap1" --model --cell 0 --out "$SCRATCH_DIR/mod2"
echo "Step 6 complete. Files created: mod2.log and mod2.model"

# Step 7: Stratification analysis
echo "Step 7: Stratification analysis..."
$PLINK --bfile "$SCRATCH_DIR/hapmap1" --cluster --ppc 0.01 --cc --out "$SCRATCH_DIR/version2"
echo "Step 7 complete. Files created: version2.log, version2.cluster1, version2.cluster2, version2.cluster3"

# Step 8: Association analysis, accounting for clusters
echo "Step 8: Association analysis, accounting for clusters..."
$PLINK --bfile "$SCRATCH_DIR/hapmap1" --cmh --cluster --out "$SCRATCH_DIR/aac2"
echo "Step 8 complete. Files created: aac2.log, aac2.cmh, and aac2.cmh.adjusted"

# Step 9: Quantitative trait association analysis (with permutation)
echo "Step 9: Quantitative trait association analysis (with permutation)..."
$PLINK --bfile "$SCRATCH_DIR/hapmap1" --qassoc --perm --out "$SCRATCH_DIR/quant2"
echo "Step 9 complete. Files created: quant2.log, quant2.qassoc, and quant2.qassoc.perm"

# Step 10: Extracting SNP of interest (for just snp rs2222162)
echo "Step 10: Extracting SNP of interest (for just snp rs2222162)..."
$PLINK --bfile "$SCRATCH_DIR/hapmap1" --snp rs2222162 --recode --out "$SCRATCH_DIR/rec_snp1"
echo "Step 10 complete. Files created: rec_snp1.log and rec_snp1.raw"

echo "All steps completed successfully."
