#!/bin/bash

# This macro will build larsoft. 
# You can put these commands as an alias which will
# allow you to run this script anywhere and return you to the current working directory.

# An alias template is:
# alias buildnlarsoft='cd $MRB_BUILDDIR; make install -j8; cd -;'

# You can simply run this script by the command source Build_Larsoft.sh
cd $MRB_BUILDDIR; 
make install -j8; 
cd -;

