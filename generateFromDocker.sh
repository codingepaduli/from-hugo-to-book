#!/bin/bash

# Generate e-book from docker image dalibo/pandocker:stable, running the command:
# docker container run --rm -it -u $(id -u ${USER}):$(id -g ${USER}) --name pandoc -v "$PWD":/usr/src/myapp -w /usr/src/myapp dalibo/pandocker:stable --filter pandoc-crossref


CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "$CURRENT_DIR"

BUILD="$CURRENT_DIR/build/"
CONTENT_DIR="$CURRENT_DIR/../codingepaduli" # NO ending slash "/"
RESOURCE_DIR="$CURRENT_DIR/../codingepaduli/static"
echo "$BUILD"
echo "$CONTENT_DIR"
echo "$RESOURCE_DIR"


METADATA="metadata.xml"

STYLESHEET="stylesheet.css"

FIRST_PAGE="$CURRENT_DIR/cover.md"

IMAGE_PREPROCESS_FILTER_EBOOK="replace_image_source.lua"
PAGEBREAK_PREPROCESS_FILTER="pagebreak.lua"
PROMOTE_HEADERS_FILTER="promote-headers.lua"

: ' commento multilinea
BOOKNAME="Appunti-di-laboratorio-Sistemi-Reti"
CHAPTERS="
          $CONTENT_DIR/content/coding/tools/EditorConfig.md
          $CONTENT_DIR/content/coding/tools/Git.md
          $CONTENT_DIR/content/coding/tools/MacchineVirtuali.md
          $CONTENT_DIR/content/coding/tools/VirtualBox.md
          $CONTENT_DIR/content/coding/tools/AQemu.md
          $CONTENT_DIR/content/coding/tools/Vagrant.md
          $CONTENT_DIR/content/coding/shell/PowerShell/intro.md
          $CONTENT_DIR/content/coding/shell/PowerShell/Concetti.md
          $CONTENT_DIR/content/coding/shell/PowerShell/PrimiScript.md
          $CONTENT_DIR/content/coding/shell/PowerShell/CmdLet-Filesystem-Path.md
          $CONTENT_DIR/content/coding/shell/PowerShell/CmdLet-Filesystem-FileCartelle.md"
'

: ' commento multilinea
BOOKNAME="Appunti-di-laboratorio-TPSIT"
CHAPTERS="
          $CONTENT_DIR/content/coding/web/html/intro.md
          $CONTENT_DIR/content/coding/web/html/etichette.md
          $CONTENT_DIR/content/coding/web/html/tagTesto.md
          $CONTENT_DIR/content/coding/web/html/tagAttributes.md
          $CONTENT_DIR/content/coding/web/html/metadati.md
          $CONTENT_DIR/content/coding/web/html/codificaUnicode.md
          $CONTENT_DIR/content/coding/web/html/validazione.md
          $CONTENT_DIR/content/coding/web/html/immagini.md
          $CONTENT_DIR/content/coding/web/javascript/intro.md
          $CONTENT_DIR/content/coding/web/javascript/primi_script.md
          $CONTENT_DIR/content/coding/web/javascript/Variabili.md
          $CONTENT_DIR/content/coding/web/javascript/operatori.md
          $CONTENT_DIR/content/coding/web/javascript/istruzioni_condizionali_iterative.md
          $CONTENT_DIR/content/coding/web/javascript/funzioni.md
          $CONTENT_DIR/content/coding/web/javascript/interazioneHtml.md
          $CONTENT_DIR/content/coding/web/javascript/selettoriCSS.md
          $CONTENT_DIR/content/coding/tools/Gradle.md"
'

: ' commento multilinea
BOOKNAME="Appunti-di-laboratorio-di-informatica-per-telecomunicazioni"
CHAPTERS="
          $CONTENT_DIR/content/coding/web/html/intro.md
          $CONTENT_DIR/content/coding/web/html/etichette.md
          $CONTENT_DIR/content/coding/web/html/tagTesto.md
          $CONTENT_DIR/content/coding/web/html/tagAttributes.md
          $CONTENT_DIR/content/coding/web/html/metadati.md
          $CONTENT_DIR/content/coding/web/html/codificaUnicode.md
          $CONTENT_DIR/content/coding/web/html/validazione.md
          "
          #$CONTENT_DIR/content/coding/web/html/immagini.md
'

BOOKNAME="Appunti-di-laboratorio-di-informatica-su-p5-js"
CHAPTERS="
        $CONTENT_DIR/content/coding/web/javascript/intro.md
        $CONTENT_DIR/content/coding/web/javascript/primi_script.md
        $CONTENT_DIR/content/coding/web/javascript/Variabili.md
        $CONTENT_DIR/content/coding/web/p5js/intro.md
        $CONTENT_DIR/content/coding/web/p5js/colorsAndStyles.md
        $CONTENT_DIR/content/coding/web/p5js/interactivity.md
        "
: ' commento multilinea
        $CONTENT_DIR/content/coding/web/javascript/intro.md
        $CONTENT_DIR/content/coding/web/javascript/primi_script.md
        $CONTENT_DIR/content/coding/web/javascript/Variabili.md
        $CONTENT_DIR/content/coding/web/javascript/primi_script_exe.md
        $CONTENT_DIR/content/coding/web/javascript/operatori.md
'

# Common pandoc command for all formats
PANDOC_COMMAND="pandoc --standalone --from=markdown+yaml_metadata_block --toc --toc-depth=3 --lua-filter=$CURRENT_DIR/$IMAGE_PREPROCESS_FILTER_EBOOK --lua-filter=$CURRENT_DIR/$PAGEBREAK_PREPROCESS_FILTER --resource-path=$RESOURCE_DIR "  # --fail-if-warnings --top-level-division=section


if [ -d $BUILD ]
then
  echo "";
  # echo "Cancella prima la cartella: $BUILD"
  # rm -rf "$BUILD"
  # mkdir "$BUILD"
fi

cat $CHAPTERS | grep -e '^#' > epub_index.md

cd $CONTENT_DIR

echo "Generating pdf"
PANDOC_COMMAND_PDF="  $PANDOC_COMMAND --output=$BUILD$BOOKNAME.pdf $FIRST_PAGE $CURRENT_DIR/ebook_title.txt  $CHAPTERS     --to=latex --pdf-engine=xelatex --top-level-division=chapter --number-sections -V geometry:margin=2cm -V book --highlight-style=tango --css=$CURRENT_DIR/$STYLESHEET" # --verbose --metadata-file=metadata.yml -V documentclass=scrreprt

$PANDOC_COMMAND_PDF

echo "Generating ebook"
PANDOC_COMMAND_EBOOK="$PANDOC_COMMAND --output=$BUILD$BOOKNAME.epub $CURRENT_DIR/ebook_title.txt $CHAPTERS --epub-chapter-level=1 --epub-metadata=$CURRENT_DIR/epub_metadata.xml --epub-cover-image=$CURRENT_DIR/cover_ebook.jpg --css=$CURRENT_DIR/$STYLESHEET --listings" #

$PANDOC_COMMAND_EBOOK



#@REM OPTION 1 for PDF: Use HTML5 rendering engine (wkhtmltopdf)
#@REM pandoc -o %BUILD%%BOOKNAME%.pdf %CURRENT_DIR%\%TITLE% %CHAPTERS% %TOC% -t html5 --standalone

#@REM OPTION 2 for PDF: Use LATEX Library
# REM Set documentclass to article, report, book, memoir
#pandoc -o %BUILD%%BOOKNAME%.pdf %CURRENT_DIR%\%TITLE% %CHAPTERS% %TOC% --standalone -t latex -V documentclass=%LATEX_CLASS%

# Generating open document
echo "Generating open document"
PANDOC_COMMAND_ODT="$PANDOC_COMMAND --output=$BUILD$BOOKNAME.odt $CHAPTERS  --to=odt"

$PANDOC_COMMAND_ODT
