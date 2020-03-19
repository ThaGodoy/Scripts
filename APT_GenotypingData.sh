#!/bin/bash
#PBS -M thaisfernanda.godoy@gmail.com
#PBS -m abe
#PBS -q short
#PBS -N APT
#PBS -l nodes=1:ppn=2
#PBS -l walltime=08:00:00
#PBS -j oe
#PBS -l mem=15gb
#PBS -o /path/Rel_APT.out

    module load bio/apt-1.16

    cd /path/

## Clean the genotyping data
#1) apt-geno-QC:
apt-geno-qc \
    --analysis-files-path /path/ \
    --xml-file /path/Axiom_GW_GT_Chicken.r1.apt-geno-qc.AxiomQC1.xml \
    --cel-files /path/cel_files_correct.txt \
    --out-file /path/results.txt

# Filter DQC smaller or similar to 0.82:
    cat results.txt | cut -f1,18 | grep -v "#" | grep -v "axiom_dishqc_DQC" | sort -nk2 | awk '$2>=0.8000' | cut -f1 | sort | awk '{print $2"/path/c$ tion/cel_files/"_$1}' > cell_list_DQC.txt
    sed '1icel_files' cell_list_DQC.txt > cell_list_DQC_OK.txt

#2) apt-probeset-genotype
apt-probeset-genotype \
   --analysis-files-path /path/ \
   --xml-file /path/Axiom_GW_GT_Chicken_96orMore_Step1.r1.apt-probeset-genotype.AxiomGT1.xml \
   --cel-files /path/cell_list_DQC_OK.txt \
   --out-dir /path/Output_genotype \
   --cc-chp-output \
   --write-models

# Filter Call Rate smaller or similar to 90:

cat AxiomGT1.report.txt | grep -v "#" | grep -v "cel_files" | awk '{print $1,$3}' | sort -nk2 | awk '$2>=90' | cut -f1 | sort | awk '{print $4"/path/"_$1}' > cell_list_CALL.txt
sed '1icel_files' cell_list_CALL.txt > cell_list_CALL_OK.txt

#3) apt-probeset-genotype
apt-probeset-genotype \
   --analysis-files-path /path/ \
   --xml-file /path/Axiom_GW_GT_Chicken_96orMore_Step2.r1.apt-probeset-genotype.AxiomGT1.xml \
   --cel-files /path/cell_list_CALL_OK.txt \
   --out-dir /path/Output_Step2 \
   --cc-chp-output \
   --write-models
   
   cd /path/

#3) Classification of SNPs (using Call Rate and MAF2)

Ps_Metrics --posterior-file AxiomGT1.snp-posteriors.txt --call-file AxiomGT1.calls.txt --metrics-file metrics.txt

Ps_Classification --species-type diploid --metrics-file metrics.txt --output-dir /home/gcosta/Output_genotype/Output_genotype --converted --cr-cutoff 98.000000 --fld-cutoff 3.600$

echo finished
