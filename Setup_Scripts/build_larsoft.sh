#!/bin/bash
# This setup script will build an experiment code whilst taking an input 
# and will also create a setup script for you in the current directory.
# to run this code run source build_larsoft.sh <experimentcode> v08_xx_xx eXX

USER=kmistry
code=$1
version=$2
qual=$3

##### AUX FUNCTIONS #####
run(){
  COLOR='\033[1;33m'
  DEFAULT='\033[0m'
  echo -e "${COLOR}-> ${1}${DEFAULT}";
  eval ${1};
}

setup_script_creation () {
    echo "run 'setup ${code} ${version} -q ${qual}:prof'" >> setup_${code}_${version}_${qual}.sh;
    echo "run 'setup ninja v1_8_2'"  >> setup_${code}_${version}_${qual}.sh;
    echo "run 'source local*/setup'" >> setup_${code}_${version}_${qual}.sh;
    echo "run 'mrbslp'" >> setup_${code}_${version}_${qual}.sh;
    echo "   " >> setup_${code}_${version}_${qual}.sh;
    echo "Setup Complete... environmental variables have been set:" >> setup_${code}_${version}_${qual}.sh;
    echo "${PREFIX}_SCRATCH" >> setup_${code}_${version}_${qual}.sh;
    echo "${PREFIX}_PERSISTENT" >> setup_${code}_${version}_${qual}.sh;
    echo "${PREFIX}DATA" >> setup_${code}_${version}_${qual}.sh;
    echo "${PREFIX}APP" >> setup_${code}_${version}_${qual}.sh;
    echo "${PREFIX}SRCS" >> setup_${code}_${version}_${qual}.sh;
    echo "   " >> setup_${code}_${version}_${qual}.sh;
    echo "export ${PREFIX}_SCRATCH=/pnfs/${experiment}/scratch/users/${USER}" >> setup_${code}_${version}_${qual}.sh;
    echo "export ${PREFIX}_PERSISTENT=/pnfs/${experiment}/persistent/users/${USER}" >> setup_${code}_${version}_${qual}.sh;
    echo "export ${PREFIX}APP=/${experiment}/app/users/${USER}/" >> setup_${code}_${version}_${qual}.sh;
    echo "export ${PREFIX}DATA=/${experiment}/data/users/${USER}/" >> setup_${code}_${version}_${qual}.sh;   
}

#########################

# Create the setup file and initialize
run "touch setup_${code}_${version}_${qual}.sh";
echo "#!bin/bash" >> setup_${code}_${version}_${qual}.sh;
echo "   " >> setup_${code}_${version}_${qual}.sh;


if [ code == "uboonecode" ]
then
   code=uboonecode
   experiment=uboone
   PREFIX=UB
   source /grid/fermiapp/products/uboone/setup_uboone.sh
   echo "run 'source /grid/fermiapp/products/uboone/setup_uboone.sh'" >> setup_${code}_${version}_${qual}.sh;
   # Call setup script function
   setup_script_creation 
   echo "export ${PREFIX}SRCS=${PWD}/srcs/${code}/${experiment}/" >> setup_${code}_${version}_${qual}.sh;
elif [ code == "sbndcode" ]
then
   code=sbndcode
   experiment=sbnd
   PREFIX=SBND
   source /grid/fermiapp/larsoft/products/setup
   source /cvmfs/sbnd.opensciencegrid.org/products/sbnd/setup_sbnd.sh
   echo "run 'source /grid/fermiapp/larsoft/products/setup'" >> setup_${code}_${version}_${qual}.sh;
   echo "run '/cvmfs/sbnd.opensciencegrid.org/products/sbnd/setup_sbnd.sh'" >> setup_${code}_${version}_${qual}.sh;
   # Call setup script function
   setup_script_creation 
   echo "export ${PREFIX}SRCS=${PWD}/srcs/${code}/${code}/" >> setup_${code}_${version}_${qual}.sh;
elif [ code == "lariatsoft" ]
then
    code=lariatsoft
    experiment=lariat
    PREFIX=LARIAT
    source /grid/fermiapp/larsoft/products/setup
    source /grid/fermiapp/lariat/setup_lariat.sh
    echo "run 'source /grid/fermiapp/larsoft/products/setup'" >> setup_${code}_${version}_${qual}.sh;
    echo "run '/grid/fermiapp/lariat/setup_lariat.sh'" >> setup_${code}_${version}_${qual}.sh;
    # Call setup script function
    setup_script_creation 
    echo "export ${PREFIX}SRCS=${PWD}/srcs/${code}/" >> setup_${code}_${version}_${qual}.sh;
else
   echo "Invalid experiment code input, eneter lariatsoft, uboonecode or sbndcode"
fi

echo "Setting up ${code} ${version} -q ${qual}:prof..."

run "setup ninja v1_8_2";
run "setup ${code} ${version} -q ${qual}:prof";
run "mrb newDev";
run "source local*/setup";
run "cd srcs";
run "mrb g -t ${version} ${code}";
run "cd ${MRB_BUILDDIR}";
run "mrbsetenv";
echo "Now Building Larsoft...";
run "mrb i --generator ninja -j 32";
run "mrbslp";
run "cd ..";

echo "SETUP DONE!"
#########################