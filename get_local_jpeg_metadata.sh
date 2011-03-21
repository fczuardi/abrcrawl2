#!/bin/bash
DATA_PATH="../abrcrawl2_data/data"
IMAGES_DIRECTORY="$DATA_PATH/images/high"
METADATA_DIRECTORY="$DATA_PATH/images/metadata"
STEP=$1
if [ -d "$IMAGES_DIRECTORY" ]
then
  if [ ! -d "$METADATA_DIRECTORY" ]
  then
    `mkdir -p "$METADATA_DIRECTORY"`
  fi
  while [ $STEP -le $2 ]
  do
    DIR="$IMAGES_DIRECTORY/$STEP"
    if [ -d "$DIR" ]
    then
      for FILE in "$DIR"/*
      do
        DIRNAME=$(basename $DIR)
        ESCAPED_FILE=`echo "$FILE" | sed s#" "#"SSSPACEEE"#g`
        FILENAME=`basename $ESCAPED_FILE| sed s#"SSSPACEEE"#" "#g`
        ESCAPED_FILENAME=`echo $FILENAME | sed s/\s/\\\s/`
        if [ ! -d "$METADATA_DIRECTORY/$DIRNAME" ]
        then
          `mkdir -p "$METADATA_DIRECTORY/$DIRNAME"`
        fi
        if [ ! -f "$METADATA_DIRECTORY/$DIRNAME/$ESCAPED_FILENAME.txt" ]
        then
          echo "Getting info from $FILE..."
          `identify -verbose "$FILE" > "$METADATA_DIRECTORY/$DIRNAME/$ESCAPED_FILENAME.txt"`
        else 
          echo "$METADATA_DIRECTORY/$DIRNAME/$ESCAPED_FILENAME.txt exists already, skipped."
        fi
      done
    else
      echo "$DIR not found!"
    fi
    ((STEP++))
  done
else
  echo "Directory $DIRECTORY does not exists"
fi