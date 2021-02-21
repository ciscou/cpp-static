#!/bin/bash

curl http://www.ceramicapadilla.es/es/catalogo.json | jq . > categories.json

for category_id in `cat categories.json | jq 'map(.id) | .[]'`
do
  curl http://www.ceramicapadilla.es/es/catalogo/${category_id}/productos.json | jq . > category_${category_id}_products.json
done
