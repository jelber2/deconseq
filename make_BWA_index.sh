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
#PBS -A hpc_startup_albuseb
#PBS -l nodes=1:ppn=1
#PBS -l walltime=03:00:00
#PBS -o /work/albuseb/deconseq_ref/
#PBS -j oe
#PBS -N make_BWA_index.sh

# Let's mark the time things get started with a date-time stamp.

date

# Set work directory

export WORK_DIR=/work/albuseb/deconseq_ref

# Makes BWA index for the 10 deconseq_ref.fa_c#.fasta files

cd $WORK_DIR
/home/albuseb/bin/deconseq-standalone-0.4.3/bwa64 index -a bwtsw -p deconseq_ref1 deconseq_ref.fa_c1.fasta
/home/albuseb/bin/deconseq-standalone-0.4.3/bwa64 index -a bwtsw -p deconseq_ref2 deconseq_ref.fa_c2.fasta
/home/albuseb/bin/deconseq-standalone-0.4.3/bwa64 index -a bwtsw -p deconseq_ref3 deconseq_ref.fa_c3.fasta
/home/albuseb/bin/deconseq-standalone-0.4.3/bwa64 index -a bwtsw -p deconseq_ref4 deconseq_ref.fa_c4.fasta
/home/albuseb/bin/deconseq-standalone-0.4.3/bwa64 index -a bwtsw -p deconseq_ref5 deconseq_ref.fa_c5.fasta
/home/albuseb/bin/deconseq-standalone-0.4.3/bwa64 index -a bwtsw -p deconseq_ref6 deconseq_ref.fa_c6.fasta
/home/albuseb/bin/deconseq-standalone-0.4.3/bwa64 index -a bwtsw -p deconseq_ref7 deconseq_ref.fa_c7.fasta
/home/albuseb/bin/deconseq-standalone-0.4.3/bwa64 index -a bwtsw -p deconseq_ref8 deconseq_ref.fa_c8.fasta
/home/albuseb/bin/deconseq-standalone-0.4.3/bwa64 index -a bwtsw -p deconseq_ref9 deconseq_ref.fa_c9.fasta
/home/albuseb/bin/deconseq-standalone-0.4.3/bwa64 index -a bwtsw -p deconseq_ref10 deconseq_ref.fa_c10.fasta

