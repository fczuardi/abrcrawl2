#!/bin/bash
DATA_PATH="data"
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
        FILENAME=$(basename $FILE)
        if [ ! -d "$METADATA_DIRECTORY/$DIRNAME" ]
        then
          `mkdir -p "$METADATA_DIRECTORY/$DIRNAME"`
        fi
        if [ ! -f "$METADATA_DIRECTORY/$DIRNAME/$FILENAME.txt" ]
        then
          echo "Getting info from $FILE..."
          `identify -verbose "$FILE" > "$METADATA_DIRECTORY/$DIRNAME/$FILENAME.txt"`
        else 
          echo "$METADATA_DIRECTORY/$DIRNAME/$FILENAME.txt exists already, skipped."
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