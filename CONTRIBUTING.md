# Contributing

*EasyView for PdfCraft is a third-party project and is not affiliated with PdfCraft or its authors; it only builds on their software.*

Issues and pull requests are welcome. This repository holds one thing: a source
patch for [PdfCraft](https://github.com/storytold/pdfcraft) that adds a viewer
mode (see the [README](README.md)).

## Setup

| Path | What |
|---|---|
| `patches/0001-viewer-mode.patch` | the patch, made against the PdfCraft commit named in the README |
| `scripts/check-patch.sh` | applies the patch to a PdfCraft checkout (what CI runs; `pinned DIR` keeps the patched checkout) |

To change the patch, apply it to a PdfCraft checkout, edit there, run the
tests, and regenerate the patch with `git diff --binary` (run `git add -N` on new
files first).

## Before you open a pull request

```sh
git clone https://github.com/storytold/pdfcraft && cd pdfcraft
git checkout <commit named in the README>
git apply /path/to/patches/0001-viewer-mode.patch
cargo test -p pdfcraft-ui-egui --test it viewer_mode      # the viewer-mode tests
cargo check -p pdfcraft-ui-egui --target wasm32-unknown-unknown   # the web build
```

CI (`.github/workflows/ci.yml`) checks that the patch still applies to the
pinned PdfCraft commit and, as an early warning, to PdfCraft's current `main`.
On the pinned commit it also builds the patch for the web (wasm) and runs the
viewer-mode tests.
The pinned commit is set in one place, `scripts/check-patch.sh`; change it
together with the README when you rebase the patch.

## Conventions

- Keep the patch small and limited to the viewer mode; unrelated changes to
  PdfCraft belong upstream.
- **GitHub Actions are pinned to a full commit SHA** with the version in a
  comment; Dependabot proposes updates.

## Issues and pull requests

Open an issue first for anything beyond a typo, saying what you want and why.
Work on a branch named `<issue number>-short-name`, and start the pull request
description with `Closes #<number>`. Wait for CI to be green; the maintainer
merges with a rebase, so the history stays linear. Security problems go to
**Security → Report a vulnerability**, not to a public issue (see
[SECURITY.md](SECURITY.md)).

Developed with help from Claude Code; every change is reviewed, tested and
released by the maintainer.
