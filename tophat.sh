#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe threaded 10

module load bowtie2/2.1.0
module load tophat/2.0.9
module load igenomes
ucsc=$IGENOMES_ROOT/Homo_sapiens/UCSC/hg38

tophat \
--GTF $HOME/circrna/gencode.v23.annotation.gtf \
--output-dir $TMPDIR/$3 \
--b2-very-sensitive \
--fusion-search \
--fusion-min-dist 200 \
--num-threads $NSLOTS \
$ucsc/Sequence/Bowtie2Index/genome \
$1 \
$2

mv -f $TMPDIR/$3 tophat/$3

