#!/bin/bash -login
#SBATCH -J snakemake
#SBATCH --account=bjoyce3
#SBATCH --partition=standard
#SBATCH --qos=user_qos_bjoyce3
#SBATCH -t 01:00:00
#SBATCH -N 1


# activate conda in general
module load anaconda

# activate a specific conda environment, if you so choose
source activate smake

# go to a particular directory
cd /home/u15/sateeshp/snakemake_examples/eigen_vectors

# make things fail on errors
set -o nounset
set -o errexit
set -x

### run your commands here!
snakemake -s eigen.snakefile --cluster-config cluster_config.yml --cluster "sbatch --account={cluster.account} --partition={cluster.partition} --time={cluster.time} --cpus-per-task={cluster.cpus} -J snake --mem={cluster.mem}" --jobs 10 --latency-wait=25
