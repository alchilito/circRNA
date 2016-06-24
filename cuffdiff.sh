#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe threaded 10

module load cufflinks/2.2.1
module load igenomes
ucsc=$IGENOMES_ROOT/Homo_sapiens/UCSC/hg19

outdir=$3
mkdir -p cuffdiff

cuffdiff \
--output-dir $TMPDIR/$outdir \
--num-threads $NSLOTS \
--compatible-hits-norm \
--multi-read-correct \
--frag-bias-correct $$IGENOMES_ROOT/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa \
$HOME/circrna/gencode.v23.annotation.gtf \
$HOME/Melanocytes-JQ1-R4-24Hr-OLD/alignments.bam) \
$(paste -s -d ',' <(ls tophat/*$2*/accepted_hits.bam))

mv -f $TMPDIR/$outdir cuffdiff/$outdir

