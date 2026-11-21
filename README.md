# EasyView for PdfCraft

> **Third-party project, not affiliated with PdfCraft.** This is an independent add-on made by [LudaLunizz](https://github.com/LudaLunizz). It is not made, endorsed, sponsored or supported by the PdfCraft authors or by storytold. It only builds on their open-source software: PdfCraft is theirs, and it keeps its own licence and its own name. "PdfCraft" is used here only to say which program this works with.

A "viewer mode" for [PdfCraft](https://github.com/storytold/pdfcraft): a stripped-down, browser-like window with only a tab strip and the page area, for reading several PDFs side by side in tabs.

PdfCraft has no plugin system, so this ships as a source patch.

## Status: v0.2.2; viewer mode tested in the headless UI harness and by hand in a real window (19 Nov 2026); "my set" and "open my set at startup" (21 Nov 2026) tested in the UI harness only so far. v0.2.1 (21 Nov 2026) fixes 5 bugs (#16), each with a UI-harness test, not yet tried by hand. v0.2.2 (21 Nov 2026) fixes the web (wasm) build that v0.2.1 broke (#18)

- **Turn on:** the eye button in the title bar, View ▸ Viewer mode, or Ctrl+E (⌘E on macOS). **Turn off:** the crossed-out eye in the strip, Ctrl+E or Esc.
- **Tabs:** click to switch; close with the ×, a middle click, Ctrl+W or the right-click menu (unsaved changes ask first); Ctrl+Tab / Ctrl+Shift+Tab step through them.
- **Pages:** Page Up/Down, Home/End, arrows and the wheel work as usual.
- **My set (the PDFs you read every day):** open them, then press the bookmark button in the viewer strip (or View ▸ Save open tabs as my set). From then on the files button next to it (or View ▸ Open my set in viewer mode) opens them all together in viewer mode. Files already open are not opened twice; moved or deleted files are reported. The set is kept in PdfCraft's own settings, as absolute paths; files never saved to disk are left out.
- **My set at startup:** View ▸ Open my set at startup (a checkbox, off by default) opens the set in viewer mode whenever PdfCraft starts without a file. A PDF you double-click still opens alone.
- These are registered commands (`view.viewer_mode`, `view.viewer_set.open`, `view.viewer_set.save`, `view.viewer_set.at_start`), so they are in the palette and the shortcuts list too.
- Six UI tests in `crates/ui-egui/tests/it/viewer_mode.rs` pass. Tried by hand in a real window by the maintainer: no issues found.

## Apply

Made against PdfCraft `storytold/pdfcraft` at commit `bad6ac7` (workspace version 0.21.1, 18 Nov 2026).

```bash
git clone https://github.com/storytold/pdfcraft
cd pdfcraft
git checkout bad6ac7
git apply /path/to/patches/0001-viewer-mode.patch
cargo check -p pdfcraft-ui-egui
```

The six viewer-mode tests pass on that commit (`cargo test -p pdfcraft-ui-egui --test it viewer_mode`, 21 Nov 2026). On a newer PdfCraft the patch may need small changes; the first one to expect is the Esc handling in `crates/ui-egui/src/app/keys.rs`.

## License

Dual-licensed, like PdfCraft itself: **MIT OR Apache-2.0**, at your option. See [`LICENSE-MIT`](LICENSE-MIT) and [`LICENSE-APACHE`](LICENSE-APACHE). Copyright (c) 2026 LudaLunizz.

This is a third-party, unofficial patch and is not affiliated with PdfCraft. It is not made, endorsed or supported by the PdfCraft maintainers; PdfCraft is theirs and keeps its own licence (MIT OR Apache-2.0). Problems in PdfCraft itself belong in [storytold/pdfcraft](https://github.com/storytold/pdfcraft); see [SECURITY.md](SECURITY.md) and [CONTRIBUTING.md](CONTRIBUTING.md) for this repository.
