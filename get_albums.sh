#!/bun/bash
if [ -z $1 ]
then
  echo "Get a sequence of html pages from the agencia brazil's album show view. (wget is required)"
  echo "Usage: get_albums [first_album_id] [last_album_id]"
else
  STEP=$1
  while [ $STEP -le $2 ]
  do
    echo "Getting album $STEP..."
    wget --content-disposition "http://agenciabrasil.ebc.com.br/ultimasfotos?p_p_id=galeria&_galeria_railsRoute=%2Fgerenciador_galeria%2Fgaleria%2Fshow%3Fid%3D$STEP" -P "data/html/albums/$STEP"
    ((STEP++))
  done
fi
# http://agenciabrasil.ebc.com.br/ultimasfotos?p_p_id=galeria&_galeria_railsRoute=%2Fgerenciador_galeria%2Fgaleria%2Fshow%3Fid%3D[ALBUM_ID]
