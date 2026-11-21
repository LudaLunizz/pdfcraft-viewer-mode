#!/usr/bin/env bash
# Apply patches/0001-viewer-mode.patch to PdfCraft and report whether it applies.
# Usage: scripts/check-patch.sh pinned|main [DIR]
#   pinned  the PdfCraft commit the patch was made against (must apply)
#   main    PdfCraft's current main (early warning that the patch needs a rebase)
#   DIR     keep the patched checkout in DIR/pdfcraft (CI builds it there); without it the
#           check runs in a temporary folder that is removed afterwards
set -euo pipefail

# The PdfCraft commit the patch is made against; keep in step with the README.
PINNED=bad6ac7fa2ced2f522c557b793bd4ee169a6a485

patch="$(cd "$(dirname "$0")/.." && pwd)/patches/0001-viewer-mode.patch"
if [ -n "${2:-}" ]; then
  work="$2"
else
  work="$(mktemp -d)"
  trap 'rm -rf "$work"' EXIT
fi

git init -q "$work/pdfcraft"
cd "$work/pdfcraft"
git remote add origin https://github.com/storytold/pdfcraft.git
case "${1:-pinned}" in
  pinned) ref="$PINNED" ;;
  main) ref=main ;;
  *) echo "usage: $0 pinned|main" >&2; exit 2 ;;
esac
git fetch -q --depth 1 origin "$ref"
git checkout -q FETCH_HEAD
echo "PdfCraft $(git rev-parse --short HEAD) ($ref)"
git apply --check "$patch"
echo "patch applies"
if [ -n "${2:-}" ]; then
  git apply "$patch"
  echo "patched checkout kept in $work/pdfcraft"
fi
