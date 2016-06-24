#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe threaded 10

# set the paths
module load igenomes
module load mapsplice/2.1.8

fbase=$1
outdir=$(basename $fbase)
ref_genome=$IGENOMES_ROOT/Homo_sapiens/UCSC/hg38/Sequence/Chromosomes
bowtie_index=$IGENOMES_ROOT/Homo_sapiens/UCSC/hg38/Sequence/BowtieIndex/genome

# transfer files and uncompress
echo "Transferring files to TMPDIR. ["$(date)"]"
cp $fbase* $TMPDIR
echo "Uncompressing files in TMPDIR. ["$(date)"]"
gunzip $TMPDIR/*.gz

# split into mate pairs
R1=$(paste -s -d ',' <(ls $TMPDIR/* | grep 'R1'))
R2=$(paste -s -d ',' <(ls $TMPDIR/* | grep 'R2'))

mkdir $TMPDIR/$outdir

echo "Running MapSplice. ["$(date)"]"

# run mapsplice
python $MAPSPLICE_ROOT/mapsplice.py \
-1 $R1 \
-2 $R2 \
-c $ref_genome \
-x $bowtie_index \
-p $NSLOTS \
-o $TMPDIR/$outdir \
--bam \
--fusion-non-canonical \
--min-fusion-distance 200 \
--gene-gtf gencode.v23.annotation.gtf \
--filtering 1

echo "Finished MapSplice. ["$(date)"]"

# move and clean up
mv -f $TMPDIR/$outdir $(pwd)
rm -f $TMPDIR/*.fastq

echo "Transfer and cleanup succeeded. ["$(date)"]"
echo "Job complete."


