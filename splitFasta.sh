#!/bin/bash
#
###############################################################################
#
# "splitFasta.sh" SuperMikeII script 
# created by Jean P. Elbers
# jean.elbers@gmail.com
# last edited 4 December 2014
#
###############################################################################
#
#PBS -q single
#PBS -A hpc_startup_jelber2
#PBS -l nodes=1:ppn=1
#PBS -l walltime=00:15:00
#PBS -o /work/jelber2/deconseq_ref/
#PBS -j oe
#PBS -N splitFasta.pl

# Let's mark the time things get started with a date-time stamp.

date

# Set work directory

export WORK_DIR=/work/jelber2/deconseq_ref

# splits the deconseq_ref.fa into files < 3GB
# output is deconseq_ref.fa_c1.fasta, deconseq_ref.fa_c2.fasta, etc.

cd $WORK_DIR
perl /home/jelber2/bin/deconseq-standalone-0.4.3/splitFasta.pl -verbose -i /work/jelber2/deconseq_ref/deconseq_ref.fa -s 3000
