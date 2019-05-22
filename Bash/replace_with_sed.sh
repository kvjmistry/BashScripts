# Bash script to run multism in chunks of 100 universes
# This is done to avoid the memory limitations from EventWeight 
# We need to replace the random seed in the fcl file for this to work which is what all these sed commands are doing

# Line 646 is the line with GENIE all mode is where the random seed is located
# This command will grab what the current seed is
SEED=`sed "646 q;d" eventweight_microboone_NuMI_MULTISIM_template.fcl | grep -oP "(?<=    random_seed: )\w+"`
SEED_NEW=$((SEED+1))
echo "Current SEED in file is ${SEED}"

# Now loop over 10 times  
for i in {1..10}
do
	echo "Replacing SEED to ${SEED_NEW}"
	# Replace the seed in the file
	sed -i "646 s|$SEED|$SEED_NEW|" eventweight_microboone_NuMI_MULTISIM_template.fcl
	
	# Add 1 to the seeds
	SEED=$((SEED+1))
	SEED_NEW=$((SEED_NEW+1))
	
	# Now run the command
	lar -c myeventweight_multisim_genie_template.fcl -S /uboone/data/users/kmistry/NuMI_EventFilter/book/files.list -o /pnfs/uboone/scratch/users/kmistry/eventweight/genie/all/filtered_eventweight_genie_multisim_100Univ_all_sample${i}.root
done

# Command to run the qevec and qe only since they are so SLOW
#lar -c myeventweight_multisim_genie.fcl -S /uboone/data/users/kmistry/NuMI_EventFilter/book/files.list -o /pnfs/uboone/scratch/users/kmistry/eventweight/genie/indiv/filtered_eventweight_genie_multisim_250Univ_indiv_no_qema_qevec_sample2.root | tee /pnfs/uboone/scratch/users/kmistry/eventweight/genie/indiv/output_genie_2.txt
