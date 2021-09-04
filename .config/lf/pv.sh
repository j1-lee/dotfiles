#!/bin/sh

case "${1##*.}" in
  pdf) pdftotext -l 3 "$1" -;;
  wiki) highlight --out-format ansi --syntax md "$1";;
  html) w3m -dump "$1";;
  csv) head --lines "$3" "$1";;
  rar) rar l "$1";;
  zip) unzip -l "$1";;
  tar|gz) tar tf "$1";;
  *)
    case "$(file --mime-type --brief --dereference "$1")" in
      text/*) highlight --out-format ansi --force "$1";;
      *) file --brief --dereference "$1" | fmt --width "$2";;
    esac
    ;;
esac
