#!/bin/bash
#
###############################################################################
#
# "run_deconseq.sh" SuperMikeII script 
# created by Jean P. Elbers
# jean.elbers@gmail.com
# last edited 4 December 2014
#
###############################################################################
#
#PBS -q single
#PBS -A hpc_startup_jelber2
#PBS -l nodes=1:ppn=1
#PBS -l walltime=12:00:00
#PBS -o /work/jelber2/deconseq_ref/
#PBS -j oe
#PBS -N run_deconseq.sh

# Let's mark the time things get started with a date-time stamp.

date

# Set work directory

export WORK_DIR=/work/jelber2/deconseq_ref

# Makes BWA index for the 4 deconseq_ref.fa_c#.fasta files

cd $WORK_DIR
/home/jelber2/bin/deconseq-standalone-0.4.3/perl deconseq.pl -f /work/jelber2/deconseq_ref/SRR649350_1.fastq -dbs deconseq_ref
