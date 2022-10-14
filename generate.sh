#!/bin/bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Current dir: $CURRENT_DIR"

BUILD="$CURRENT_DIR/build/"
CONTENT_DIR="$CURRENT_DIR/../codingepaduli" # NO ending slash "/"
RESOURCE_DIR="$CURRENT_DIR/../codingepaduli/static"
echo "Build dir: $BUILD"
echo "Content dir: $CONTENT_DIR"
echo "Resource dir: $RESOURCE_DIR"

source books.sh

declare -A books
books[0,0]=$BOOKNAME_HTML
books[0,1]=$CHAPTERS_HTML
books[1,0]=$BOOKNAME_JAVASCRIPT
books[1,1]=$CHAPTERS_JAVASCRIPT
books[2,0]=$BOOKNAME_P5_JS
books[2,1]=$CHAPTERS_P5_JS

METADATA="metadata.xml"

STYLESHEET="stylesheet.css"

FIRST_PAGE="$CURRENT_DIR/cover.md"

IMAGE_PREPROCESS_FILTER_EBOOK="replace_image_source.lua"
PAGEBREAK_PREPROCESS_FILTER="pagebreak.lua"

# Common pandoc command for all formats
PANDOC_COMMAND="/usr/bin/pandoc --standalone --from=markdown+yaml_metadata_block --toc --toc-depth=3 --lua-filter=$CURRENT_DIR/$IMAGE_PREPROCESS_FILTER_EBOOK --lua-filter=$CURRENT_DIR/$PAGEBREAK_PREPROCESS_FILTER --resource-path=$RESOURCE_DIR "  # --fail-if-warnings --top-level-division=section


if [ -d $BUILD ]
then
  echo "";
  # echo "Cancella prima la cartella: $BUILD"
  # rm -rf "$BUILD"
  # mkdir "$BUILD"
fi

mkdir -p $BUILD

cd $CONTENT_DIR

for ((i=0; i<3; i++))
do

    echo -ne "Generating pdf ${books[${i},0]} \n"
    PANDOC_COMMAND_PDF="  $PANDOC_COMMAND --output=$BUILD${books[${i},0]}.pdf $FIRST_PAGE $CURRENT_DIR/ebook_title.txt  ${books[${i},1]}     --to=latex --pdf-engine=xelatex --top-level-division=chapter --number-sections -V geometry:margin=2cm --highlight-style=tango --css=$CURRENT_DIR/$STYLESHEET" # --verbose --metadata-file=metadata.yml -V documentclass=scrreprt -V mainfont:NotoSans-Regular

    $PANDOC_COMMAND_PDF

    echo -ne "Generating ebook ${books[${i},0]} \n"
    PANDOC_COMMAND_EBOOK="$PANDOC_COMMAND --output=$BUILD${books[${i},0]}.epub $CURRENT_DIR/ebook_title.txt ${books[${i},1]} --epub-chapter-level=1 --epub-metadata=$CURRENT_DIR/epub_metadata.xml --epub-cover-image=$CURRENT_DIR/cover_ebook.jpg --css=$CURRENT_DIR/$STYLESHEET --listings" #

    $PANDOC_COMMAND_EBOOK

    # Generating open document
    echo -ne "Generating open document ${books[${i},0]} \n"
    PANDOC_COMMAND_ODT="$PANDOC_COMMAND --output=$BUILD${books[${i},0]}.odt ${books[${i},1]}  --to=odt"

    $PANDOC_COMMAND_ODT
done

