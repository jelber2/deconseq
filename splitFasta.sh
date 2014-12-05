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
#PBS -A hpc_startup_albuseb
#PBS -l nodes=1:ppn=1
#PBS -l walltime=00:15:00
#PBS -o /work/albuseb/deconseq_ref/
#PBS -j oe
#PBS -N splitFasta.pl

# Let's mark the time things get started with a date-time stamp.

date

# Set work directory

export WORK_DIR=/work/albuseb/deconseq_ref

# splits the deconseq_ref.fa into 10 files
# output is deconseq_ref.fa_c1.fasta, deconseq_ref.fa_c2.fasta, etc.

cd $WORK_DIR
perl /home/albuseb/bin/deconseq-standalone-0.4.3/splitFasta.pl -verbose -i /work/albuseb/deconseq_ref/deconseq_ref.fa -n 10
