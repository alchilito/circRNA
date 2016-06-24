#!/bin/bash
#$ -S /bin/bash
#$ -cwd

module load bedtools/2.22.0

bedtools multicov -D -bams $1 -bed $2 > ${2%.*}.multicov