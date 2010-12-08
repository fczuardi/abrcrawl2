#!/bin/bash
# echo "Compare 2 local image folders and re-download the missing files. (wget is required)"
DATA_PATH="../abrcrawl2_data/data"
SIZE1="small"
SIZE2="high"

for dir in $(find "$DATA_PATH/images/$SIZE1" -type d)
do
  if [ ! -d ${dir/"$SIZE1"/"$SIZE2"} ]
  then
    PHOTO_ID=`expr "$dir" : '.*\/\(.*\)'` 
    wget --content-disposition --waitretry=1 "http://agenciabrasil.ebc.com.br/galeriaimagens/images/fotos/$PHOTO_ID/$SIZE2?p_p_id=galeria" -P ${dir/"$SIZE1"/"$SIZE2"}
  fi
done
