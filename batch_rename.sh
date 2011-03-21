#!/bin/bash
DATA_PATH="../abrcrawl2_data/data"
IMAGES_DIRECTORY="$DATA_PATH/images/high"
METADATA_DIRECTORY="$DATA_PATH/images/metadata"
PORTRAIT_DIRECTORY="$DATA_PATH/images/portrait"
LANDSCAPE_DIRECTORY="$DATA_PATH/images/landscape"

for file in "$LANDSCAPE_DIRECTORY"/*
do
  ESCAPED_FILE=`echo "$file" | sed s#" "#"SSSPACEEE"#g`
  FILENAME=$(basename $ESCAPED_FILE)
  FILE_ID=${FILENAME/.*/''}
  FILE_TAIL=`echo "$FILENAME" | sed s/[0-9]*./''/`
  ZEROED_FILE_ID=`printf %07d $FILE_ID`
  NEW_NAME=`echo "$ZEROED_FILE_ID.$FILE_TAIL"| sed s/"SSSPACEEE"/" "/`
  OLD_NAME=`echo "$FILENAME"| sed s/"SSSPACEEE"/" "/`
  echo "mv \"$LANDSCAPE_DIRECTORY/$OLD_NAME\" \"$LANDSCAPE_DIRECTORY/$NEW_NAME\""
  `mv "$LANDSCAPE_DIRECTORY/$OLD_NAME" "$LANDSCAPE_DIRECTORY/$NEW_NAME"`
done
