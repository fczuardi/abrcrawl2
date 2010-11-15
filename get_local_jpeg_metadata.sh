#!/bun/bash
IMAGES_DIRECTORY="data/images/high"
METADATA_DIRECTORY="data/images/metadata"
if [ -d "$IMAGES_DIRECTORY" ]
then
  if [ ! -d "$METADATA_DIRECTORY" ]
  then
    `mkdir -p "$METADATA_DIRECTORY"`
  fi
  for DIR in "$IMAGES_DIRECTORY"/*
  do
    echo "$DIR"
    for FILE in "$DIR"/*
    do
      echo "  $FILE"
      DIRNAME=$(basename $DIR)
      FILENAME=$(basename $FILE)
      if [ ! -d "$METADATA_DIRECTORY/$DIRNAME" ]
      then
        `mkdir -p "$METADATA_DIRECTORY/$DIRNAME"`
      fi
      `identify -verbose "$FILE" > "$METADATA_DIRECTORY/$DIRNAME/$FILENAME.txt"`
    done
  done
else
  echo "Directory $DIRECTORY does not exists"
fi