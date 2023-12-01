#!/usr/bin/env bash
# sbatch_plink.sh


###
# Slurm commands to request resources
###
#SBATCH --partition=express # choose from debug, express, or short
#SBATCH --job-name=plink # change this name to be informative for what you are running (eg. name of key script)
#SBATCH --time=00:30:00 # max time to run in hh:mm:ss, must be at or below max for partition
#SBATCH -N 1 # nodes requested
#SBATCH -n 1 # task per node requested
#SBATCH --output="batch-%x-%j.output" # where to direct standard output
# output file will be batch-<job-name>-<job-ID>.output and include stdout and stderr


###
# Usage
###
# Copy sbatch_plink.sh, getExamples.sh, and plinkHapmap1.sh to your /scratch/username/ directory (or subdirectory)
# From that same directory run this command: 
# sbatch sbatch_plink.sh /home/username/where-to-put-output-files
#
# ASSUMES 


###
# Core script
###
echo "Starting script $(date)"
echo "*****Preparation*****"

echo "Loading required modules"
echo "   Anaconda3"
module load anaconda3/2021.11
echo "   Loading additional BINF6309 programs"
module load binf6309/01-14-2022
echo "   Loading BINF6309 Environment (includes plink)"
source activate BINF-12-2021

echo "Creating analysis folder"
mkdir plink_analysis
cd plink_analysis

echo "Copying analysis scripts to analysis folder"
cp ../getExamples.sh .
cp ../plinkHapmap1.sh .


echo "*****Analysis*****"
echo "Downloading genotype, map, and phenotype data from the PLINK tutorial $(date)"
bash getExamples.sh

echo "Processing hapmap1 data with plink $(date)"
bash plinkHapmap1.sh


echo "*****Cleanup*****"
echo "Copy results to ${1}"
cd ..
cp -r plink_analysis/ ${1}

echo "Cleaning up input and output files"
rm -r plink_analysis/

echo "Ending script $(date)"
echo "Don't forget to remove your log files in $(pwd) manually"
cp batch*.output $1
