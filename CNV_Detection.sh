################# 
#### Author: Thaís Fernanda Godoy 
#### Script description: Identification of CNV by joint PennCNV Option (using parental information:father-mother-offspring)
#### Date: 12 Juli 2017
#################
	
  ## Inputs: 
  # lista_animals.txt (after the genomic wave correction)
  # animais_GG50.pfb (pfb file)
  # HMM_GG50.hmm (hmm file after the train option)
	
########### SCRIPT
#!/bin/bash
#PBS -M thaisfernanda.godoy@gmail.com
#PBS -m abe
#PBS -q long
#PBS -N jointF2
#PBS -l nodes=1:ppn=1
#PBS -l walltime=200:00:00
#PBS -j oe
#PBS -l mem=40gb
#PBS -o /path/Reljoint_GG50.out

    module unload devel/perl-5.18.2
    module load bio/penncnv_2011_6_6

    cd /path/
    detect_cnv.pl -joint -hmm HMM_GG50.hmm -pfb animais_GG50.pfb -list lista_animals.txt -out Resultadojoint_GG50.jointcnv -lastchr 33

