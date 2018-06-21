##### SETTINGS #####
V_MAIN='uboonecode'
V_VERSMAIN='v06_26_01_br'
V_QUAL_A='e10'
V_QUAL_B='prof'

V_BAS='larsoft'
V_VERSBAS='v06_26_01_13'

V_PROJ1='larsim'
V_VERS1='v06_26_01_01_branch'

DIRNAME="uboonecode_hsngen"
# DIRNAME="${V_MAIN}_${V_VERSMAIN}"
#########################



##### AUX FUNCTIONS #####
run(){
  COLOR='\033[1;33m'
  DEFAULT='\033[0m'
  echo -e "${COLOR}-> ${1}${DEFAULT}";
  eval ${1};
}
#########################


##### SETUP AND RUN #####
CURR="${PWD}"
run "rm -rf ${DIRNAME}";
run "rm source_${DIRNAME}.sh";

run "source /grid/fermiapp/products/uboone/setup_uboone.sh";
run "setup git";
run "setup gitflow";
run "setup mrb";
run "setup ninja v1_7_2";
run "export MRB_PROJECT=larsoft";
run "setup ${V_BAS} ${V_VERSBAS} -q ${V_QUAL_A}:${V_QUAL_B}";
run "mkdir ${DIRNAME}";
run "cd ${DIRNAME}";
run "mrb newDev";
run "source localProducts_${V_BAS}_${V_VERSBAS}_${V_QUAL_A}_${V_QUAL_B}/setup";
run "cd ${MRB_SOURCE}";
run "mrb g -t ${V_VERSMAIN} ${V_MAIN}";
# run "mrb g -t ${V_VERS1} ${V_PROJ1}";
# run "mrb g ${V_PROJ2}";

run "mrb uc";
run "cd ${MRB_BUILDDIR}";
run "mrbsetenv";
run "mrb i --generator ninja -j16";
run "cd ${MRB_TOP}";
run "mrbslp";

# Create source file
run "cd ${CURR}";
run "touch source_${DIRNAME}.sh";
echo 'run(){' >> source_${DIRNAME}.sh;
echo '  COLOR="\033[1;33m"' >> source_${DIRNAME}.sh;
echo '  COLOR="\033[1;33m"' >> source_${DIRNAME}.sh;
echo '  DEFAULT="\033[0m"' >> source_${DIRNAME}.sh;
echo '  echo -e "${COLOR}-> ${1}${DEFAULT}";' >> source_${DIRNAME}.sh;
echo '  eval ${1};' >> source_${DIRNAME}.sh;
echo '}' >> source_${DIRNAME}.sh;
echo "run 'source /grid/fermiapp/products/uboone/setup_uboone.sh'" >> source_${DIRNAME}.sh;
echo "run 'setup ${V_BAS} ${V_VERSBAS} -q ${V_QUAL_A}:${V_QUAL_B}'" >> source_${DIRNAME}.sh;
echo "run 'setup ninja v1_7_2'" >> source_${DIRNAME}.sh;
echo "run 'source ${DIRNAME}/localProducts_${V_BAS}_${V_VERSBAS}_${V_QUAL_A}_${V_QUAL_B}/setup'" >> source_${DIRNAME}.sh;
echo "run 'mrbslp'" >> source_${DIRNAME}.sh;
#########################