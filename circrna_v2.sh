#!/bin/bash
#$ -S /bin/bash
#$ -cwd

## STEP 1: Running MapSplice

# takes the file path and makes a script launcher
function MapSpliceLauncher() {
files=$1
ids=$(ls $files* | xargs -I{} basename {} | awk -F_ '{print $1}' | uniq)
folder=$(dirname $files)
for id in $ids; do
echo mapsplice.sh $folder/$id
done
}


#/ifs/data/sequence/results/hernandolab/20140627/fastq/sk-mel-147-JQ1-R \
#/ifs/data/sequence/results/hernandolab/20140827/fastq/Melanocytes-JQ1-R \
#/ifs/data/sequence/results/hernandolab/20141203/fastq/scramble_A_ATGTCA_L007_R \
#/ifs/data/sequence/results/hernandolab/20141203/fastq/scramble_A_ATGTCA_L008_R \
#/ifs/data/sequence/results/hernandolab/20141203/fastq/scramble_B_GTCCGC_L007_R \
#/ifs/data/sequence/results/hernandolab/20141203/fastq/scramble_B_GTCCGC_L008_R \
#/ifs/data/sequence/results/hernandolab/20141203/fastq/scramble_C_GTGAAA_L007_R \
#/ifs/data/sequence/results/hernandolab/20141203/fastq/scramble_C_GTGAAA_L008_R \

# Short Term Culture patient samples (n=10)
#/ifs/data/sequence/results/osmanlab/melanoma/2015-07-17-NYGC/FASTQ/09-203-LN
#/ifs/data/sequence/results/osmanlab/melanoma/2015-07-17-NYGC/FASTQ/10-040-LN
#/ifs/data/sequence/results/osmanlab/melanoma/2015-07-17-NYGC/FASTQ/10-230-Par
#/ifs/data/sequence/results/osmanlab/melanoma/2015-07-17-NYGC/FASTQ/11-001-BM
#/ifs/data/sequence/results/osmanlab/melanoma/2015-07-17-NYGC/FASTQ/11-103-BM
#/ifs/data/sequence/results/osmanlab/melanoma/2015-07-17-NYGC/FASTQ/11-161-BM
#/ifs/data/sequence/results/osmanlab/melanoma/2015-07-17-NYGC/FASTQ/12-215-LN
#/ifs/data/sequence/results/osmanlab/melanoma/2015-07-17-NYGC/FASTQ/12-019-LN
#/ifs/data/sequence/results/osmanlab/melanoma/2015-07-17-NYGC/FASTQ/12-126-BM
#/ifs/data/sequence/results/osmanlab/melanoma/2015-07-17-NYGC/FASTQ/12-273-BM

# public datasets

#/ifs/home/ulloaa01/circrna/public/CSHL/wgEncode


# run the for loop to launch scripts
# delete or add experimental sets as needed
for exp in \
/ifs/home/ulloaa01/circrna/public/CSHL/wgEncode \
; do
MapSpliceLauncher $exp
done

## STEP 2: What to do next?


#run a differential expression script 


