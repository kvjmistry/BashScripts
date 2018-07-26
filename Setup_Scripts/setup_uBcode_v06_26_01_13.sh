#!bin/bash
source /grid/fermiapp/products/uboone/setup_uboone.sh
setup uboonecode v06_26_01_13 -q e10:prof
setup ninja v1_8_2
source local*/setup
cd $MRB_BUILDDIR
mrbsetenv
cd -

echo "Setup Complete... environmental variables have been set:"
echo "UB SCRATCH"
echo "UB_PERSISTENT"
echo "UBDATA"
echo "UBAPP"
echo "UBSRCS"

export UB_SCRATCH=/pnfs/uboone/scratch/users/kmistry
export UB_PERSISTENT=/pnfs/uboone/persistent/users/kmistry
export UBAPP=/uboone/app/users/kmistry/
export UBDATA=/uboone/data/users/kmistry/
export UBSRCS=/uboone/app/users/kmistry/uBcode_v06_26_01_13/srcs/uboonecode/uboone/
