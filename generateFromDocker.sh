#!/bin/bash

# Generate e-book from docker image dalibo/pandocker:stable, running the command:
# docker container run --rm -it -u $(id -u ${USER}):$(id -g ${USER}) --name pandoc -v "$PWD":/usr/src/myapp -w /usr/src/myapp dalibo/pandocker:latest-buster-full --filter pandoc-crossref


CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ROOT_DIR="$( dirname "$CURRENT_DIR" )" # $CURRENT_DIR
SCRIPT_DIR="$ROOT_DIR/from-hugo-to-book"
BUILD="$SCRIPT_DIR/build/"
CONTENT_DIR="$ROOT_DIR/codingepaduli" # NO ending slash "/"
RESOURCE_DIR="$ROOT_DIR/codingepaduli/static"

echo "Current dir: $CURRENT_DIR"
echo "Root dir: $ROOT_DIR"
echo "Script dir: $SCRIPT_DIR"
echo "Build dir: $BUILD"
echo "Content dir: $CONTENT_DIR"
echo "Resource dir: $RESOURCE_DIR"

source "$SCRIPT_DIR/books.sh"
# source "$SCRIPT_DIR/books_with_exe.sh"

declare -A books
books[0,0]=$BOOKNAME_HTML
books[0,1]=$CHAPTERS_HTML
books[1,0]=$BOOKNAME_JAVASCRIPT
books[1,1]=$CHAPTERS_JAVASCRIPT
books[2,0]=$BOOKNAME_P5_JS
books[2,1]=$CHAPTERS_P5_JS

STYLESHEET="$SCRIPT_DIR/stylesheet.css"

PDF_FIRST_PAGE=""  #"$SCRIPT_DIR/cover.md"
EPUB_COVER="$SCRIPT_DIR/cover_ebook_2.jpg"
EPUB_METADATA="$SCRIPT_DIR/epub_metadata.xml"

IMAGE_PREPROCESS_FILTER_EBOOK="$SCRIPT_DIR/replace_image_source.lua"
PAGEBREAK_PREPROCESS_FILTER="$SCRIPT_DIR/pagebreak.lua"

# Common pandoc command for all formats
PANDOC_COMMAND="pandoc --standalone --from=markdown+yaml_metadata_block --toc --toc-depth=3 --lua-filter=$IMAGE_PREPROCESS_FILTER_EBOOK --lua-filter=$PAGEBREAK_PREPROCESS_FILTER --resource-path=$RESOURCE_DIR "  # --fail-if-warnings --top-level-division=section

if [ -d "$BUILD" ]
then
  echo "";
  # echo "Cancella prima la cartella: $BUILD"
  # rm -rf "$BUILD"
  # mkdir "$BUILD"
fi

mkdir -p "$BUILD"

cd "$ROOT_DIR"

for ((i=0; i<3; i++))
do

    echo -ne "Generating pdf ${books[${i},0]}\n"
    PANDOC_COMMAND_PDF="  $PANDOC_COMMAND --output=$BUILD${books[${i},0]}.pdf $PDF_FIRST_PAGE $SCRIPT_DIR/ebook_title.txt  ${books[${i},1]} $SCRIPT_DIR/title.md    --to=latex --pdf-engine=xelatex --top-level-division=chapter --number-sections -V geometry:margin=2cm --highlight-style=tango --css=$STYLESHEET" # --verbose --metadata-file=metadata.yml -V documentclass=scrreprt -V mainfont:NotoSans-Regular

    $PANDOC_COMMAND_PDF

    echo -ne "Generating ebook ${books[${i},0]} \n"
    PANDOC_COMMAND_EBOOK="$PANDOC_COMMAND --output=$BUILD${books[${i},0]}.epub $SCRIPT_DIR/ebook_title.txt ${books[${i},1]} $SCRIPT_DIR/title.md --epub-chapter-level=1 --epub-metadata=$EPUB_METADATA --epub-cover-image=$EPUB_COVER --css=$STYLESHEET --listings" #

    $PANDOC_COMMAND_EBOOK

    # Generating open document
    echo -ne "Generating open document ${books[${i},0]} \n"
    PANDOC_COMMAND_ODT="$PANDOC_COMMAND --output=$BUILD${books[${i},0]}.odt ${books[${i},1]}  --to=odt"

    $PANDOC_COMMAND_ODT
done

