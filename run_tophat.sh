#!/bin/bash
#$ -S /bin/bash
#$ -cwd

# qsub run_tophat.sh Melanocytes-JQ1-R*-*Hr 20140827
# qsub run_tophat.sh sk-mel-147-JQ1-R-*hr 20140627
# qsub run_tophat.sh 501mel-JQ1-R-*hr 20140627

export FILES=/ifs/data/sequence/results/hernandolab/$2/fastq/*$1*.fastq.gz
export ID=$(ls $FILES | xargs -I{} basename {} | awk -F_ '{print $1}' | uniq)

#sed -E 's/-[0-9]+[Hh]r-[0-9]+$//g;s/[0-9]+-[0-9]+[Hh]r$//g'

for i in $ID;
do
	R1=$(paste -s -d ',' <(ls $FILES | grep $i | grep 'R1'))
    R2=$(paste -s -d ',' <(ls $FILES | grep $i | grep 'R2'))
    qsub tophat.sh $R1 $R2 $i
done