#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe threaded 10

module load cufflinks/2.2.1
module load igenomes
ref_genome=$IGENOMES_ROOT/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta

ls cufflinks/*/transcripts.gtf > merged.files

# run cufflinks
cuffmerge \
--num-threads $NSLOTS \
--ref-gtf gencode.v23.annotation.gtf \
--ref-sequence $ref_genome/genome.fa \
merged.files



