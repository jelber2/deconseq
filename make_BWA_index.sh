#!/bin/bash
#
###############################################################################
#
# "make_BWA_index.sh" SuperMikeII script 
# created by Jean P. Elbers
# jean.elbers@gmail.com
# last edited 4 December 2014
#
###############################################################################
#
#PBS -q single
#PBS -A hpc_startup_jelber2
#PBS -l nodes=1:ppn=1
#PBS -l walltime=03:00:00
#PBS -o /work/jelber2/deconseq_ref/
#PBS -j oe
#PBS -N make_BWA_index.sh

# Let's mark the time things get started with a date-time stamp.

date

# Set work directory

export WORK_DIR=/work/jelber2/deconseq_ref

# Makes BWA index for the four deconseq_ref.fa_c#.fasta files

cd $WORK_DIR
/home/jelber2/bin/deconseq-standalone-0.4.3/bwa64 index -a bwtsw -p deconseq_ref.fa_c1.fasta
/home/jelber2/bin/deconseq-standalone-0.4.3/bwa64 index -a bwtsw -p deconseq_ref.fa_c2.fasta
/home/jelber2/bin/deconseq-standalone-0.4.3/bwa64 index -a bwtsw -p deconseq_ref.fa_c3.fasta
/home/jelber2/bin/deconseq-standalone-0.4.3/bwa64 index -a bwtsw -p deconseq_ref.fa_c4.fasta
