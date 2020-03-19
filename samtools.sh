#!/bin/bash
#PBS -W umask=012
#PBS -M thaisfernanda.godoy@gmail.com
#PBS -m bea
#PBS -N sam_region
#PBS -l nodes=1:ppn=1
#PBS -l walltime=350:00:00
#PBS -q default
#PBS -j oe
#PBS -o /home/users/tgodoy/samtools_mpileup.pbs.out

PATH=/thunderstorm/programas/samtools:/thunderstorm/programas/samtools/bcftools:/thunderstorm/programas/samtools/misc:$PATH
SAMTOOLS_INDEX=/thunderstorm/db/genomes/Coutinho/galinha/samtools

    cd /home/users/tgodoy/

    samtools mpileup -q20 -Q20 -AB -r Chr2:105,848,755-112,648,761 pb) -ugf $SAMTOOLS_INDEX/genoma_Ggallus.fa /path/animal_1.bam | bcftools view -bvcg - > animal_1_region.raw.bcf

#bcftools view animal_1_region.raw.bcf | vcfutils.pl varFilter -D99999 -S > animal_1_region.flt.vcf

    echo finished
