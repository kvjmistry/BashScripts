#!/bin/bash
# This bash script will get a list of file names find the location on tape and see whether they are staged online or nearline or both. 
# Returns either ONLINE, NEARLINE or ONLINE_AND_NEARLINE
# If it returns something else, then I would probably stay away from using this, its also quite slow!


input="filelist.txt"
slash="/"
while IFS= read -r var
do
  DIR_TO_FILE=$(samweb locate-file ${var} | sed -e "s@${PREFIX}@@" -e "s@${SUFFIX}@@");
  cat $DIR_TO_FILE$slash".(get)($var)(locality)";
done < "$input"