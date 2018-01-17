#!/bin/bash

#$ -cwd
#$ -pe thread 16
#$ -S /bin/bash
#$ -N stacks_town
#$ -e stacksProcDenovoTownErr
#$ -o stacksProcDenovoTownOut
#$ -q !nem
#$ -V

if [[ "$1" != "" ]]
then
wd=$1
fi

if [[ "$1" == "" ]]
then
echo "no directory supplied, using current dir"
wd=$(pwd)
fi

# the population map (popmap_town_county) contains samples identified by same name as the barcode
# identifier used in process_shortreads.

# parameters (m, M, n) customized for my dataset (Paris et al. 2017)
# for details see http://onlinelibrary.wiley.com/doi/10.1111/2041-210X.12775/full

echo "time started:"
date
# first run as dry run (-d at end of command denovo_map.pl) to verify your popmap is correct
# then comment it out and re-run script to execute program
denovo_map.pl -o ./denovo_map/town_county -T 16 -O ../popmap_town_county.tsv --samples ./ \
-X "populations:--fstats" -X "populations:--log_fst_comp" \
-X "populations:--vcf" -X "populations:--plink" -X "populations:--genepop" \
-m 5 -M 5 -n 6 -S -b 1 \
-d

echo "time over:"
date
