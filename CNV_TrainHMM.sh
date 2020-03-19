################# 
#### Author: Thaís Fernanda Godoy 
#### Script description: Train the HMM using the initial HMM file 
#### Date: 10 June 2017
#################

# Input: lista_animals.txt (after the genomic wave correction) and animais_GG50.pfb (pfb file)

########### SCRIPT
#!/bin/bash
#PBS -M thaisfernanda.godoy@gmail.com
#PBS -m abe
#PBS -q long
#PBS -N train_HMM
#PBS -l nodes=1:ppn=1
#PBS -l walltime=30:00:00
#PBS -j oe
#PBS -l mem=35gb
#PBS -o /path/relat_trainHMM_GG50.out

    module unload devel/perl-5.18.2
    module load bio/penncnv_2011_6_6

    cd /path/ 
  
#Train the HMM using an initial HMM file using the train option and write an output called Test.hmm
  
    detect_cnv.pl --train -hmm hhall.hmm -pfb animais_GG50.pfb -log Train_2.log --listfile lista_animals.txt -out HMM_GG50 -lastchr 33
