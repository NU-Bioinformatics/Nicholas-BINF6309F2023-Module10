# getExample.sh


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
# his script should use wget to download the input files found at https://zzz.bwh.harvard.edu/plink/hapmap1.zipLinks to an external site. to your scratch directory. Then use unzip command to unzip the resulting hapmap1.zip file, resulting in four new files:
## hapmap1.ped
## hapmap1.map
## pop.phe
## qt.phe
#
# ASSUMES 


###
# Core script
###

# Set your scratch directory
SCRATCH_DIR="/scratch/chevalier.n/Nicholas-BINF6309F2023-Module10/plink_analysis"

# URL of the hapmap1.zip file
ZIP_URL="https://zzz.bwh.harvard.edu/plink/hapmap1.zip"

# Download the hapmap1.zip file to the scratch directory
wget "$ZIP_URL" -P "$SCRATCH_DIR"

# Unzip the hapmap1.zip file
unzip "$SCRATCH_DIR/hapmap1.zip" -d "$SCRATCH_DIR"

# Display a message indicating the process is complete
echo "Files extracted successfully:"
ls -l "$SCRATCH_DIR"

echo "Script execution complete."

#
