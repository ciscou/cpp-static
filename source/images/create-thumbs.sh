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
          convert -define jpeg:size=400x400 "$image" -thumbnail 200x200^ -gravity center -extent 200x200 "thumb/$image"
        done
      )
    done
  )
done
