: ' commento multilinea

Elenco di ebook da creare a partire dagli articoli elencati

For each post, set the weight variable in the Hugo Frontmatter following the rules below:
    HTML: 10000 - 60 * x
    JS: 9000 - 60 * x + 20
    P5JS: 9000 - 60 * x + 40
'

#CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# echo "Current dir for books: $CURRENT_DIR"
# echo "Content dir for books: $CONTENT_DIR"

BOOKNAME_JAVASCRIPT="Appunti-di-laboratorio-di-informatica-su-javascript"
CHAPTERS_JAVASCRIPT="
        $CONTENT_DIR/content/coding/web/javascript/conversioni.md
        $CONTENT_DIR/content/coding/web/javascript/istruzioni_condizionali_iterative.md
        $CONTENT_DIR/content/coding/web/javascript/selettoriCSS.md
        $CONTENT_DIR/content/coding/web/javascript/DOM.md
        "

BOOKNAME_HTML="Appunti-di-laboratorio-di-tpsit-su-html5-e-css"
CHAPTERS_HTML="
        $CONTENT_DIR/content/coding/web/html/etichette.md
        $CONTENT_DIR/content/coding/web/html/tagTesto.md
        $CONTENT_DIR/content/coding/web/html/immagini.md
        $CONTENT_DIR/content/coding/web/html/metadati.md
        $CONTENT_DIR/content/coding/web/html/validazione.md
        $CONTENT_DIR/content/coding/web/html/codificaUnicode.md
        $CONTENT_DIR/content/coding/web/html/form.md
        $CONTENT_DIR/content/coding/web/html/Accessibilita.md
        $CONTENT_DIR/content/coding/web/css/intro.md
        $CONTENT_DIR/content/coding/web/css/selettoriCSS.md
        "

BOOKNAME_SISTEMI="Appunti-di-laboratorio-sistemi-e-reti"
CHAPTERS_SISTEMI="
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
        $CONTENT_DIR/content/coding/shell/PowerShell/CmdLet-Filesystem-FileCartelle.md
        "

BOOKNAME_P5_JS="Appunti-di-laboratorio-di-informatica-su-p5-js"
CHAPTERS_P5_JS="
        $CONTENT_DIR/content/coding/Storia.md
        $CONTENT_DIR/content/coding/web/html/etichette.md
        $CONTENT_DIR/content/coding/web/html/tagTesto.md
        $CONTENT_DIR/content/coding/web/html/codificaUnicode.md
        $CONTENT_DIR/content/coding/web/html/codificaUnicode_appendice_combinazioni.md
        $CONTENT_DIR/content/coding/web/html/metadati.md
        $CONTENT_DIR/content/coding/web/html/validazione.md
        $CONTENT_DIR/content/coding/web/html/Accessibilita.md
        $CONTENT_DIR/content/coding/web/javascript/intro.md
        $CONTENT_DIR/content/coding/web/p5js/intro.md
        $CONTENT_DIR/content/coding/web/p5js/graphicsPrimitives.md
        $CONTENT_DIR/content/coding/web/p5js/colorsAndStyles.md
        $CONTENT_DIR/content/coding/web/javascript/Variabili.md
        $CONTENT_DIR/content/coding/web/p5js/variables.md
        $CONTENT_DIR/content/coding/web/p5js/soundsAndImages.md
        $CONTENT_DIR/content/coding/web/p5js/interactivity.md
        $CONTENT_DIR/content/coding/web/javascript/funzioni.md
        "
