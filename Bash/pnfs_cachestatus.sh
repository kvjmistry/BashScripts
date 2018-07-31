#!/bin/bash
# To run ./pnfs_cachestatus <pnfsfilename> 


pnfsfile=$1

#If no path is supplied,print help message and exit
if [ $# -lt 1 ]; then
   echo "###ERROR: need provide the pnfs path to check. Usage:"
   echo "$0 <pnfspath>"
   exit 1
fi

#Check whether the file exists and non-zero size
if [ ! -s $pnfsfile ]; then
   echo "###ERROR: $pnfsfile does not exist or has a zero-size."
   exit 1
fi

filebasename=`basename $pnfsfile`
filedirname=`dirname $pnfsfile`

cache_status=`cat ${filedirname}/".(get)($filebasename)(locality)"`
 
#check whether in dCache pool
if [[ $cache_status == *"ONLINE"* ]]; then
  echo "CACHED!";
  exit_status=0
else
  echo "NOT CACHED!";
  exit_status=1
fi

exit $exit_status

     

