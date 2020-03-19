################# 
#### Author: Thaís Fernanda Godoy 
#### Script description: PBF file - GGA5.0
#### Date: 29 May 2017
#################

# Input: lista_animals.txt (after the genomic wave correction)

########### SCRIPT
!/bin/bash
#PBS -M thaisfernanda.godoy@gmail.com
#PBS -m abe
#PBS -q long
#PBS -N pfb
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -j oe
#PBS -l mem=40gb
#PBS -o "/path/"relat_pfb_GG50.out

    module unload devel/perl-5.18.2
    module load bio/penncnv_2011_6_6

    cd "/path/"

    compile_pfb.pl -listfile lista_animals.txt -output animais_GG50.pfb 
