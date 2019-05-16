#!/bin/bash
# This setup script will build an experiment code whilst taking an input 
# and will also create a setup script for you in the current directory.
# to run this code run source build_larsoft.sh <experimentcode> v08_xx_xx eXX
# if you are NOT krishan, then make sure you change the username variable!
# if you want to clone a packge such as larsim, change the varibles at top and uncomment the parts near the bottom

USER=kmistry
code=${1}
version=${2}
qual=${3}
# Make sure you uncomment the relavent parts
Larsoft_ver='v06_26_01_13' # use these for builing with larsim etc. 
Larsoft_qual='e10'
package='larevt'
package_ver='v06_26_01'

##### AUX FUNCTIONS #####
run(){
  COLOR='\033[1;33m'
  DEFAULT='\033[0m'
  echo -e "${COLOR}-> ${1}${DEFAULT}";
  eval ${1};
}

# function that creates the meat of the setup script
setup_script_creation () {
    run "Creating Setup Script..."
    echo "run 'setup ${code} ${version} -q ${qual}:prof'" >> setup_${code}_${version}_${qual}.sh;
    echo "run 'setup ninja v1_8_2'"  >> setup_${code}_${version}_${qual}.sh;
    echo "run 'source local*/setup'" >> setup_${code}_${version}_${qual}.sh;
    echo "run 'mrbslp'" >> setup_${code}_${version}_${qual}.sh;
    echo "   " >> setup_${code}_${version}_${qual}.sh;
    echo "echo 'Setup Complete... environmental variables have been set:'" >> setup_${code}_${version}_${qual}.sh;
    echo "echo '${PREFIX}_SCRATCH'" >> setup_${code}_${version}_${qual}.sh;
    echo "echo '${PREFIX}_PERSISTENT'" >> setup_${code}_${version}_${qual}.sh;
    echo "echo '${PREFIX}DATA'" >> setup_${code}_${version}_${qual}.sh;
    echo "echo '${PREFIX}APP'" >> setup_${code}_${version}_${qual}.sh;
    echo "echo '${PREFIX}SRCS'" >> setup_${code}_${version}_${qual}.sh;
    echo "   " >> setup_${code}_${version}_${qual}.sh;
    echo "export ${PREFIX}_SCRATCH=/pnfs/${experiment}/scratch/users/${USER}" >> setup_${code}_${version}_${qual}.sh;
    echo "export ${PREFIX}_PERSISTENT=/pnfs/${experiment}/persistent/users/${USER}" >> setup_${code}_${version}_${qual}.sh;
    echo "export ${PREFIX}APP=/${experiment}/app/users/${USER}/" >> setup_${code}_${version}_${qual}.sh;
    echo "export ${PREFIX}DATA=/${experiment}/data/users/${USER}/" >> setup_${code}_${version}_${qual}.sh;   
}

#########################

# Create the setup file and initialize
run "touch setup_${code}_${version}_${qual}.sh";
echo "#!/bin/bash" >> setup_${code}_${version}_${qual}.sh;
echo "   " >> setup_${code}_${version}_${qual}.sh;
echo 'run(){' >> setup_${code}_${version}_${qual}.sh;
echo '  COLOR="\033[1;33m"' >> setup_${code}_${version}_${qual}.sh;
echo '  COLOR="\033[1;33m"' >> setup_${code}_${version}_${qual}.sh;
echo '  DEFAULT="\033[0m"' >> setup_${code}_${version}_${qual}.sh;
echo '  echo -e "${COLOR}-> ${1}${DEFAULT}";' >> setup_${code}_${version}_${qual}.sh;
echo '  eval ${1};' >> setup_${code}_${version}_${qual}.sh;
echo '}' >> setup_${code}_${version}_${qual}.sh;
echo "   " >> setup_${code}_${version}_${qual}.sh;


if [ $code == "uboonecode" ]
then
   experiment=uboone
   PREFIX=UB
   source /cvmfs/uboone.opensciencegrid.org/products/setup_uboone.sh
   echo "run 'source /cvmfs/uboone.opensciencegrid.org/products/setup_uboone.sh'" >> setup_${code}_${version}_${qual}.sh;
   # Call setup script function
   setup_script_creation 
   echo "export ${PREFIX}SRCS=${PWD}/srcs/${code}/${experiment}/" >> setup_${code}_${version}_${qual}.sh;
   echo "  " >> setup_${code}_${version}_${qual}.sh;
   echo "echo 'Setting up larbatch to latest version'" >> setup_${code}_${version}_${qual}.sh;
   echo "run 'unsetup larbatch'" >> setup_${code}_${version}_${qual}.sh;
   echo "run 'setup larbatch'" >> setup_${code}_${version}_${qual}.sh;
elif [ $code == "sbndcode" ]
then
   experiment=sbnd
   PREFIX=SBND
   source /grid/fermiapp/larsoft/products/setup
   source /cvmfs/sbnd.opensciencegrid.org/products/sbnd/setup_sbnd.sh
   echo "run 'source /grid/fermiapp/larsoft/products/setup'" >> setup_${code}_${version}_${qual}.sh;
   echo "run 'source /cvmfs/sbnd.opensciencegrid.org/products/sbnd/setup_sbnd.sh'" >> setup_${code}_${version}_${qual}.sh;
   # Call setup script function
   setup_script_creation 
   echo "export ${PREFIX}SRCS=${PWD}/srcs/${code}/${code}/" >> setup_${code}_${version}_${qual}.sh;
elif [ $code == "lariatsoft" ]
then 
    experiment=lariat
    PREFIX=LARIAT
    source /grid/fermiapp/larsoft/products/setup
    source /grid/fermiapp/lariat/setup_lariat.sh
    echo "run 'source /grid/fermiapp/larsoft/products/setup'" >> setup_${code}_${version}_${qual}.sh;
    echo "run 'source /grid/fermiapp/lariat/setup_lariat.sh'" >> setup_${code}_${version}_${qual}.sh;
    # Call setup script function
    setup_script_creation 
    echo "export ${PREFIX}SRCS=${PWD}/srcs/${code}/" >> setup_${code}_${version}_${qual}.sh;
else
   echo "Invalid experiment code input, enter lariatsoft, uboonecode or sbndcode"
fi

run "Setting up ${code} ${version} -q ${qual}:prof..."
run "setup ninja v1_8_2";
#run "setup larsoft ${Larsoft_ver} -q ${Larsoft_qual}:prof"
run "setup ${code} ${version} -q ${qual}:prof";
run "mrb newDev -f";
run "source  local*/setup";
run "cd srcs";
#run "mrb g -t ${package} ${package_ver}";
run "mrb g -t ${version} ${code}";
run "cd ${MRB_BUILDDIR}";
run "mrbsetenv";
echo "Now Building Larsoft...";
run "mrb i --generator ninja -j16"; # Choose if using extra cores. 
#run "mrb i --generator ninja";
run "cd ..";
run "mrbslp";
echo "SETUP DONE!"
#########################
