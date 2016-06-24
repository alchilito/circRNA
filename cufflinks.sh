#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe threaded 10

# for f in $(ls -r tophat) ; do qsub cufflinks.sh $f ; done

module load cufflinks/2.2.1
module load igenomes
ref_genome=$IGENOMES_ROOT/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta

tophat=$(basename $1)
mkdir -p cufflinks

# run cufflinks
cufflinks \
--GTF-guide gencode.v23.annotation.gtf \
--frag-bias-correct $ref_genome/genome.fa \
--multi-read-correct \
--upper-quartile-norm \
--min-isoform-fraction 0.1 \
--min-frags-per-transfrag 10 \
--num-threads $NSLOTS \
--output-dir cufflinks/$tophat \
tophat/$tophat/accepted_hits.bam



