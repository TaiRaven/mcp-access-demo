#!/usr/bin/env sh
# Wraps page.html (the artifact source) in a full HTML document for GitHub Pages.
set -e
cd "$(dirname "$0")/.."
{
  printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n</head>\n<body>\n'
  cat page.html
  printf '\n</body>\n</html>\n'
} > index.html
echo "index.html built"
