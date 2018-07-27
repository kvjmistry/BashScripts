#!/bin/bash
# This setup script will build uboonecode whilst taking an input 
# to run this code run source build_larsoft.sh <experimentcode> v08_xx_xx eXX

if [ $1 == "uboonecode" ]
then
   code=uboonecode
   source /grid/fermiapp/products/uboone/setup_uboone.sh
elif [ $1 == "sbndcode" ]
then
   code=sbndcode
   source /grid/fermiapp/larsoft/products/setup
   source /cvmfs/sbnd.opensciencegrid.org/products/sbnd/setup_sbnd.sh
elif [ $1 == "lariatsoft" ]
then
    code=lariatsoft
    source /grid/fermiapp/larsoft/products/setup
    source /grid/fermiapp/lariat/setup_lariat.sh
else
   echo "Invalid experiment code input, eneter lariatsoft, uboonecode or sbndcode"
fi

echo "Setting up $code $2 -q $3:prof..."

setup ninja v1_8_2
echo "Setting up ninja v1_8_2..."
setup $code $2 -q $3:prof
mrb newDev
source local*/setup
cd srcs
mrb g -t $2 $code
cd $MRB_BUILDDIR
mrbsetenv
echo "Now Building Larsoft..."
mrb i --generator ninja -j 32
mrbslp
cd ..
