#!/bin/bash

for folder in category product
do
  (
    cd "$folder" || exit

    for id in */
    do
      (
        cd "$id" || exit
        mkdir -p thumb

        for image in *.jpg
        do
          convert -define jpeg:size=200x200 "$image"  -thumbnail 100x100^ -gravity center -extent 100x100 "thumb/$image"
        done
      )
    done
  )
done
