deconseq
========
####log into your account on SuperMikeII
####go to your work directory on the cluster
    cd /work/albuseb #or whatever it is

####make a directory to store the FASTA files for DeconSeq
    mkdir deconseq_ref #or whatever you want to call the reference directory

####make a directoy to store the tmp files for DeconSeq
    mkdir deconseq_tmp

####make a directory to store the output files for DeconSeq
    mkdir deconseq_out

####go to the deconseq_ref directory that you just made
    cd deconseq_ref

####get all virus FASTA files (here fna is for Fasta Nucleic Acid)
    wget ftp://ftp.ncbi.nih.gov/genomes/Viruses/all.fna.tar.gz

####rename the file to all.vir.fna.tar.gz
    mv all.fna.tar.gz allvir.fna.tar.gz

####extracts only the fna files and not the folders (the strip-components part) from all.fna.tar.gz
    tar -xzf allvir.fna.tar.gz --strip-components 2

####creates a FASTA file called virus.fa from all the .fna files (1 after the other, after the other)
    cat *.fna > virus.fa

####gets rid of all of the .fna files (you don't need them any more
    rm *.fna

####repeat above steps for bacteria
####get all bacteria FASTA files, extract only .fna files (might take 3-5 minutes), combine into one fasta file (take 1-2 minutes), get rid of .fna files
    wget ftp://ftp.ncbi.nih.gov/genomes/Bacteria/all.fna.tar.gz
    mv all.fna.tar.gz allbac.fna.tar.gz
    tar -xzf allbac.fna.tar.gz --strip-components 2
    cat *.fna > bacteria.fa
    rm *.fna

####combine virus.fa and bacteria.fa
    cat bacteria.fa virus.fa > deconseq_ref.fa

####Now you need to install DeconSeq
####go back to your home folder
    cd /home/albuseb

####make a new directory called bin to store your program in
    mkdir bin

####make a new directory called scripts to store your scritps in
    mkdir scripts

####go to this directory
    cd scripts

####make new directory for deconseq scripts
    mkdir deconseq

####go to this directory
    cd deconseq

####you need to put the following scripts here (not sure how you are doing file transfers)
#####make_BWA_index.sh
#####splitFasta.sh
    wget https://raw.githubusercontent.com/jelber2/deconseq/master/make_BWA_index.sh
    wget https://raw.githubusercontent.com/jelber2/deconseq/master/splitFasta.sh

#####you need to change the allocation for each file using the text editor nano
    nano make_BWA_index.sh
#####find #PBS -A hpc_startup_albuseb
#####change hpc_startup_albuseb to your allocation name
#####once done making changes, press 'ctrlX' (ctrl plus X)
######you will see   Save modified buffer (ANSWERING "No" WILL DESTROY CHANGES) ?
######then press 'Y' to save changes
######you will then see   File Name to Write: make_BWA_index.sh
######press 'Enter' to save file as itself
#####do the same thing for splitFasta.sh
    nano splitFasta.sh


####go back to bin folder
    cd ..
    cd ..
    cd bin

####download DeconSeq (deconseq-standalone-0.4.3.tar.gz) to bin folder
wget http://downloads.sourceforge.net/project/deconseq/standalone/deconseq-standalone-0.4.3.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fdeconseq%2Ffiles%2Fstandalone%2F&ts=1417735856&use_mirror=hivelocity

####unzip the compressed tar file
    tar -xzf deconseq-standalone-0.4.3.tar.gz

####go to the new directory
    cd deconseq-standalone-0.4.3

####use splitFasta.pl to split the 10GB file into 10 files
####note the command below must be implemented with splitFasta.sh (because LSU HPC does not like processes running on the head node)
####perl splitFasta.pl -verbose -i /work/albuseb/deconseq_ref/deconseq_ref.fa -n 10

####to use splitFasta.sh, enter the following in the terminal
    qsub /home/albuseb/scripts/deconseq/splitFasta.sh

####check the status of the job using
    qstat -u albuseb

####combine the small files into a larger one
    cd /work/albuseb/deconseq_ref
    cat deconseq_ref.fa_c4.fasta deconseq_ref.fa_c5.fasta deconseq_ref.fa_c6.fasta deconseq_ref.fa_c7.fasta deconseq_ref.fa_c8.fasta deconseq_ref.fa_c9.fasta deconseq_ref.fa_c10.fasta > deconseq_ref.fa_c4a.fasta

####Time to make BWA indexes
####assumes you are in /home/albuseb/bin/deconseq-standalone-0.4.3/
####make bwa executable
    chmod u+x bwa64

####test bwa64
    ./bwa64

####should see:
    Program: bwa (alignment via Burrows-Wheeler transformation)
    Version: 0.5.9-r16
    Contact: Heng Li <lh3@sanger.ac.uk>
    etc...

####use make_BWA_index.sh to implement the following commands:
####/home/albuseb/bin/deconseq-standalone-0.4.3/bwa64 index -a bwtsw -p deconseq_ref.fa_c1 deconseq_ref.fa_c1.fasta
####/home/albuseb/bin/deconseq-standalone-0.4.3/bwa64 index -a bwtsw -p deconseq_ref.fa_c2 deconseq_ref.fa_c2.fasta
####etc.

####to use make_BWA_index.sh
    qsub /home/albuseb/scripts/deconseq/make_BWA_index.sh


####change the location of the database(s) in the DeconSeqConfig.pm file
    nano DeconSeqConfig.pm

####scroll to use constant DB_DIR => 'db/';
#####change to '/work/albuseb/deconseq_ref/

####scroll to use constant TMP_DIR => 'tmp/';
#####change to '/work/albuseb/deconseq_temp/

####scroll to use constant TMP_OUT => 'out/';
#####change to '/work/albuseb/deconseq_out/

####scroll to use constant DBS =>
#####change hsref to deconseq_ref
#####change 'Human Reference GRCh37' to 'NCBI_ALL_BAC_&_Vir'
#####change 'hs_ref_GRCh37' to 'deconseq_ref1,deconseq_ref2,deconseq_ref3,deconseq_ref4,deconseq_ref5,deconseq_ref6,deconseq_ref7,deconseq_ref8,deconseq_ref9,deconseq_ref10'

####scroll to use constant DB_DEFAULT =>
#####change to hsref to deconseq_ref