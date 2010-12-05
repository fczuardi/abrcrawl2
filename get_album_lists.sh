#!/bun/bash
DATA_PATH="../abrcrawl2_data/data"
if [ -z $1 ]
then
  echo "Get a sequence of html pages from the agencia brazil's album list view. (wget is required)"
  echo "The script gets pages from older to new, so page 1 means the last page (February 2010)."
  echo "Usage: get_album_lists [first_page] [last_page]"
else
  STEP=$1
  LAST_PAGE=188
  while [ $STEP -le $2 ]
  do
    PAGE=$((LAST_PAGE - $STEP + 1))
    echo "Getting page $PAGE..."
    wget --content-disposition "http://agenciabrasil.ebc.com.br/ultimasfotos?p_p_id=galeria&_galeria_railsRoute=%2Fgerenciador_galeria%2Fgaleria%3Fpage%3D$PAGE/high?p_p_id=galeria" -P "$DATA_PATH/html/list_albums/odhd/$STEP"
    ((STEP++))
  done
fi