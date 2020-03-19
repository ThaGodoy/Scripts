################## 
#### Author: Thaís Godoy
#### Script description: Creat the file with %GC in a SNP window (Gal gal 5.0)
#### Date: 3 April 2017
################## 

### Load file, from any sample, to extract probes positions
    setwd("/path/")
    format <- read.table("animal_1.cnv.txt", sep="\t", header=T, row.names = )

### Extract position from all probes
    inputgw <- format[,1:3]

### Window to calculate GC and AT percentage 
    inputgw$start <- inputgw$Position - 500
    inputgw$end <- inputgw$Position + 500
    
### Delete probe position 
    inputgw <- inputgw[,-3]

### Change column postions
    inputgw <- inputgw[,c(2,3,4,1)]

### Select the Chr type there are in th inputgw
    chr_inputgw <- subset(inputgw, select= c("Chr"))
    chr_inputgw <- unique(chr_inputgw$Chr)
    chr_inputgw <- as.data.frame(chr_inputgw)

### Merge chr_inputgw with size_chr  
    size <- read.table("size_chr.txt", header = FALSE, sep = "\t")
    info_size <- merge(chr_inputgw, size, by.x="chr_inputgw", by.y="V1", all.x= TRUE)

### Stabilish boundaries
##start
    inputgw$start[inputgw$start < 0] <- 1

##end
# add max column
    inputgw <- merge(inputgw, info_size, by.x="Chr", by.y="chr_inputgw", all.x=TRUE)

### Stabilish the max of end column
   inputgw$end <- ifelse((inputgw$end > inputgw$V2), inputgw$V2, inputgw$end)

### Remove a column V2 and column name and add chr in first column
   inputgw <- inputgw[,1:4]
   inputgw$Chr <- sub("^", "chr", inputgw$Chr)
   colnames(inputgw) <- NULL

### Save bed file
    setwd("/path/")
    write.table(inputgw, file = "intervalGC_GG50.bed", sep="\t", col.names=F, row.names=F, quote=F)


### Select chr (1-33, M, Z, W, LGE64)
    setwd("/path/")
    intervalGC <- read.table("intervalGC_GG50.bed", header = FALSE, sep = "\t")

    intervalGC2 <- subset(intervalGC, V1 == "chr2" | V1 == "chr1" | V1 == "chr3" |
                      V1 == "chr4" | V1 == "chr5" | V1 == "chr6" | V1 == "chr7" |
                      V1 == "chr8" | V1 == "chr9" | V1 == "chr10" | V1 == "chr11" |
                      V1 == "chr12" | V1 == "chr13" | V1 == "chr14" | V1 == "chr15"|
                      V1 == "chr16" | V1 == "chr17" | V1 == "chr18" | V1 == "chr19"|
                      V1 == "chr20" | V1 == "chr21" | V1 == "chr22" | V1 == "chr23" |
                      V1 == "chr24" | V1 == "chr25" | V1 == "chr26" | V1 == "chr27" |
                      V1 == "chr28" | V1 == "chr29" | V1 == "chr30" | V1 == "chr31" |
                      V1 == "chr32" | V1 == "chr33" | V1 == "chrM" | V1 == "chrW" |
                      V1 == "chrZ" | V1 == "chrLGE64")

    intervalGC2$V3 <- as.integer(as.character(intervalGC2$V3))
    
    setwd("/path/")
    write.table(intervalGC2, file = "intervalGC_GG50_2.bed", sep="\t", col.names=F, row.names=F, quote=F)

###########################
# SCRIPT 
#!/bin/bash
#PBS -M thaisfernanda.godoy@gmail.com
#PBS -m abe
#PBS -q short
#PBS -N apt
#PBS -l nodes=1:ppn=1
#PBS -l walltime=10:00:00
#PBS -j oe
#PBS -l mem=30gb
#PBS -o "/path/"erroGCcontent2.out

    module load bio/bedtools-2.26.0 

    cd "/path/"
  
#To calculate the GC % in a window of 1KB (500pb from both side of probe)
  
    bedtools nuc -fi /path/genome.fa -bed intervalGC_GG50_2.bed > result_GC_GG50.txt

