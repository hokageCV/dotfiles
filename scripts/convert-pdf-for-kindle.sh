#!/bin/bash

COLUMNS=2

for arg in "$@"; do
  case "$arg" in
  --cols=*)
    COLUMNS="${arg#*=}"
    ;;
  -*)
    echo "Unknown option: $arg"
    echo "Usage: $0 <path-to-pdf> [--cols=<1|2>]"
    exit 1
    ;;
  *)
    INPUT="$arg"
    ;;
  esac
done

if [ -z "$INPUT" ]; then
  echo "Usage: $0 <path-to-pdf> [--cols=<1|2>]"
  echo "  --cols: 1 or 2 (default: 2)"
  exit 1
fi

if [ "$COLUMNS" != "1" ] && [ "$COLUMNS" != "2" ]; then
  echo "Error: --cols must be 1 or 2"
  exit 1
fi

BASENAME=$(basename "$INPUT" .pdf)
TMPDIR=$(mktemp -d)
OUTPUT="$HOME/Documents/${BASENAME}.azw3"

echo "Converting: $INPUT"
echo "Columns: $COLUMNS"
echo "Output: $OUTPUT"

echo ""
echo "Step 1/3: Converting layout..."

if [ "$COLUMNS" == "2" ]; then
  echo "" | k2pdfopt -w 1072 -h 1448 -mode 2col "$INPUT" -o "$TMPDIR/${BASENAME}_k2opt.pdf"
else
  echo "" | k2pdfopt -w 1072 -h 1448 "$INPUT" -o "$TMPDIR/${BASENAME}_k2opt.pdf"
fi

if [ $? -ne 0 ]; then
  echo "k2pdfopt failed"
  rm -rf "$TMPDIR"
  exit 1
fi

echo ""
echo "Step 2/3: Running OCR..."
ocrmypdf --redo-ocr --optimize 3 --clean "$TMPDIR/${BASENAME}_k2opt.pdf" "$TMPDIR/${BASENAME}_text.pdf"
if [ $? -ne 0 ]; then
  echo "ocrmypdf failed"
  rm -rf "$TMPDIR"
  exit 1
fi

echo ""
echo "Step 3/3: Converting to AZW3..."
ebook-convert "$TMPDIR/${BASENAME}_text.pdf" "$OUTPUT" --output-profile tablet --extra-css 'p { text-align: left !important; }'
if [ $? -ne 0 ]; then
  echo "ebook-convert failed"
  rm -rf "$TMPDIR"
  exit 1
fi

rm -rf "$TMPDIR"

echo ""
echo "Done! Saved to: $OUTPUT"
