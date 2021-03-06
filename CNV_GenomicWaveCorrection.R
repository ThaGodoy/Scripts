################# 
#### Author: Thaís Fernanda Godoy 
#### Script description: GENOMIC WAVE CORRECTION - GGA5.0
#### Input organization and Genomic Wave script
#### Date: 7 April 2017
#################

#### Inputs: listfile and gcmodelfile
#listfile (list  with animal names)
    echo cel_files; ls -l /path/*.cnv.txt > /path/list_animalsGG50.txt
    cat list_animalsGG50.txt | tr '/' '\t'| cut -f9 > list_animalsGG50_2.txt

# gcmodelfile
#result_GC_GG50.txt - result from bedtools with %GC
    cat result_GC_GG50.txt | cut -f1,2,3,4,6 > result_GC_GG50_2.txt

#in R
### Load file, from any sample, to extract probes positions
    setwd("/path/")
    format <- read.table("animal_1.txt", sep="\t", header=T)

### select name probe and real postition
    format <- subset(format, select= c("Name", "Position"))

### merge ResultGC with real position 
    setwd("/path/")
    result <- read.table("result_GC_GG50_2.txt", sep="\t", header=T)
    GCmodelfile <- merge(result, format, by.x="V4", by.y="Name", all.x=TRUE)

### change GC decimal to % (multiple for 100)
    GCmodelfile$V5 <- GCmodelfile$V5 * 100

### remove start and end 
    GCmodelfile <- GCmodelfile[,-c(3,4)]

### inverter postion columns 
    GCmodelfile <- GCmodelfile[,c(1,2,4,3)]

### write column names: Name Chr Position GC
    colnames(GCmodelfile) <- c("Name", "Chr", "Position", "GC")

    setwd("/path/")
    write.table(GCmodelfile, file = "gwavecerto_gcmodel_GG50.txt", col.names = TRUE, row.names = FALSE, sep = "\t", quote = FALSE)


#####    Script     ######

#!/bin/bash
#PBS -M thaisfernanda.godoy@gmail.com
#PBS -m abe
#PBS -q long
#PBS -N genomicwave
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -j oe
#PBS -l mem=40gb
#PBS -o path/relat_adjust_GG50.out

    module unload devel/perl-5.18.2
    module load bio/penncnv_2011_6_6

    cd path

####Adjusted with genomic wave

    genomic_wave.pl -adjust -listfile List_AnimalsGG50.txt -gcmodelfile gwavecerto_gcmodel_GG50.txt
