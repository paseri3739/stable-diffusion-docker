# data/

`data/` is intentionally treated as local state.

What stays in git:

- directory skeleton via `.gitkeep`
- this README
- examples under `data/examples/`

What does not stay in git:

- models
- outputs
- caches
- user settings
- extension checkouts

Expected live paths:

- `data/config.json`
- `data/ui-config.json`
- `data/styles.csv`
- `data/params.txt`
- `data/models/...`
- `data/outputs/...`
- `data/extensions/...`
- `data/cache/...`

Use the files in `data/examples/` as references only. Real runtime files should live at the normal paths above.

