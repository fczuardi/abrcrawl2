#!/bin/bash
DATA_PATH="data"
if [ -z $1 ]
then
  echo "Get a sequence of photos from agencia brazil's website. (wget is required)"
  echo "Usage: get_photos [first_photo_id] [last_photo_id] [small | normal | high]"
else
  STEP=$1
  if [ -z $3 ]
  then
    SIZE="high"
  else
    SIZE=$3
  fi
  while [ $STEP -le $2 ]
  do
    if [ ! -d "$DATA_PATH/images/$SIZE/$STEP" ]
    then
      wget --content-disposition "http://agenciabrasil.ebc.com.br/galeriaimagens/images/fotos/$STEP/$SIZE?p_p_id=galeria" -P "$DATA_PATH/images/$SIZE/$STEP"
    else
      echo "$DATA_PATH/images/$SIZE/$STEP exists already, skipped."
    fi
    ((STEP++))
  done
fi