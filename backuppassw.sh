#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi


targetDirectory=$1
destinationDirectory=$2


echo "THE FIRST ARGUMENT$1"
echo "THE SECOND ARGUMENT$2"


currentTS=$(date +"%Y%m%d%H%M%S")



backupFileName="backup_${currentTS}.tar.gz"





origAbsPath=$(cd "$targetDirectory" && pwd)



cd "$destinationDirectory"
destDirAbsPath=($pwd)


cd "$origAbsPath"
cd "$destDirAbsPath"


yesterdayTS=$(($currentTS - 24 * 60 * 60))

declare -a toBackup

for file in $(ls) 
do
  
  if ((date -r $file +%s > $yesterdayTS))
  then
    toBackup+=($file)
   
  fi
done


tar -czvf $backupFileName.tar.gz ${toBackup}

mv "$backupFileName" "$destDirAbsPath"
