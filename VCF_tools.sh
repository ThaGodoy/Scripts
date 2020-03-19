#!/bin/bash
#PBS -M thaisfernanda.godoy@gmail.com
#PBS -m abe
#PBS -q short
#PBS -N vcftools
#PBS -l nodes=1:ppn=2
#PBS -l walltime=20:00:00
#PBS -j oe
#PBS -l mem=63gb
#PBS -o /home/tgodoy/vcftools_freq.out

module load bio/vcftools-0.1.12b

cd /home/tgodoy/

vcftools --vcf vcf_parentais.txt --keep TT_list.txt --freq

echo finished
