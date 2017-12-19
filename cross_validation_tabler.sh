# writes cross-validation results from admixture to files
# make sure the admixture call creates the log files!
# in the following example, command line arg. would be log*.out
# for K in 1 2 3 4 5; do admixture --cv some_pedigree.bed $K | tee log${K}.out; done

# Create list of necessary files
log_files=$1
echo "searching $1 and related files"
ls -1 county_log*.out > logs.list

# Get K value in column one, cross-validation value in column 2
# Write to file cv.txt
while read LOG; do grep CV $LOG | awk -F ' ' '{ print  $3 "\t" $4 }' | sed 's/(K=//g' | sed 's/)://g'
done < logs.list > cv.txt

# Clean-up
echo "Cross validation results: "
cat cv.txt
rm -f logs.list
