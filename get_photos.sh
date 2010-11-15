#!/bun/bash
if [ -z $1 ]
then
  echo "Get a sequence of photos from agencia brazil's website. (wget is required)"
  echo "Usage: get_photos [first_photo_id] [last_photo_id]"
else
  STEP=$1
  while [ $STEP -le $2 ]
  do
    wget --content-disposition "http://agenciabrasil.ebc.com.br/galeriaimagens/images/fotos/$STEP/high?p_p_id=galeria" -P "data/images/high/$STEP"
    ((STEP++))
  done
fi