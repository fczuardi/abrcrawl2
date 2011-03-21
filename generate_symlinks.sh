#!/bin/bash
DATA_PATH="../abrcrawl2_data/data"
IMAGES_DIRECTORY="$DATA_PATH/images/high"
METADATA_DIRECTORY="$DATA_PATH/images/metadata"
PORTRAIT_DIRECTORY="$DATA_PATH/images/portrait"
LANDSCAPE_DIRECTORY="$DATA_PATH/images/landscape"
STEP=$1
P_COUNTER=0
L_COUNTER=1
# `mkdir -p "$PORTRAIT_DIRECTORY/people/$3/"`
# `mkdir -p "$LANDSCAPE_DIRECTORY/people/$3/"`

if [ -d "$IMAGES_DIRECTORY" ]
then
  if [ ! -d "$PORTRAIT_DIRECTORY" ]
  then
    `mkdir -p "$PORTRAIT_DIRECTORY"`
  fi
  if [ ! -d "$LANDSCAPE_DIRECTORY" ]
  then
    `mkdir -p "$LANDSCAPE_DIRECTORY"`
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
        # echo "$DIR $DIRNAME $METADATA_DIRECTORY"
        if [ ! -d "$METADATA_DIRECTORY/$DIRNAME" ]
        then
          echo "Error $METADATA_DIRECTORY/$DIRNAME is not here!"
        else
          if [ ! -f "$METADATA_DIRECTORY/$DIRNAME/$FILENAME.txt" ]
          then
            echo "Error $FILE is not there."
          else 
            WIDTH=`cat "$METADATA_DIRECTORY/$DIRNAME/$FILENAME.txt" | grep Geometry: | sed s/.*Geometry:.// | sed s/x.*//`
            HEIGHT=`cat "$METADATA_DIRECTORY/$DIRNAME/$FILENAME.txt" | grep Geometry: | sed s/.*Geometry:.// | sed s/.*x// | sed s/+.*//`
            # SEARCH=`cat "$METADATA_DIRECTORY/$DIRNAME/$FILENAME.txt" | grep "$3"`
            # if [ ! -z "$SEARCH" ]
            # then
            #   echo "Serra $PWD/$DIR/$FILENAME"
            #   if [ "$WIDTH" -lt "$HEIGHT" ]
            #   then
            #     ((P_COUNTER++))
            #     SYMLINK_NAME=`printf %08d $P_COUNTER`".jpg"
            #     `ln -s "$PWD/$DIR/$FILENAME" "$PORTRAIT_DIRECTORY/people/$3/$SYMLINK_NAME"`
            #   else
            #     SYMLINK_NAME=`printf %08d $L_COUNTER`".jpg"
            #     `ln -s "$PWD/$DIR/$FILENAME" "$LANDSCAPE_DIRECTORY/people/$3/$SYMLINK_NAME"`
            #     ((L_COUNTER++))
            #   fi
            # fi
            # echo "$WIDTH,$HEIGHT"
            echo "$PWD/$DIR/$ESCAPED_FILENAME"
            if [ "$WIDTH" -lt "$HEIGHT" ]
            then
              ((P_COUNTER++))
              SYMLINK_NAME=`printf %08d $P_COUNTER`".jpg"
              `cp "$PWD/$DIR/$ESCAPED_FILENAME" "$PORTRAIT_DIRECTORY/$STEP.$ESCAPED_FILENAME"`
            else
              SYMLINK_NAME=`printf %08d $L_COUNTER`".jpg"
              `cp "$PWD/$DIR/$ESCAPED_FILENAME" "$LANDSCAPE_DIRECTORY/$STEP.$ESCAPED_FILENAME"`
              ((L_COUNTER++))
            fi
          fi
        fi
      done
    fi
    ((STEP++))
  done
  echo "$P_COUNTER vs $L_COUNTER"
else
  echo "Directory $DIRECTORY does not exists"
fi