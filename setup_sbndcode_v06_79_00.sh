echo "Setting up sbndcode v06_79_00..."

source /grid/fermiapp/larsoft/products/setup;
source /cvmfs/sbnd.opensciencegrid.org/products/sbnd/setup_sbnd.sh;
setup sbndcode v06_79_00 -q e15:prof;
setup ninja v1_8_2;
source localProducts*/setup;
mrbslp;

echo "Setup Complete... environmental variables have been set:"
echo "SBND SCRATCH"
echo "SBND_PERSISTENT"
echo "SBND_MOLRADRECO"

export SBND_SCRATCH=/pnfs/sbnd/scratch/users/kmistry
export SBND_PERSISTENT=/pnfs/sbnd/persistent/users/kmistry
export SBND_MOLRADRECO=/sbnd/app/users/kmistry/sbndcode_v06_79_00/srcs/sbndcode/sbndcode/MolRadReco
