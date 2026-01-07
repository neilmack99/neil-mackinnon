Simple starter site

- Open `site/index.html` in your browser to view locally.
- Run `preview.ps1` to serve the repo locally (no Python/Node required).
  - PowerShell: `.\
eview.ps1` (or `.\
eview.ps1 -Root site -Port 8000`)
- To publish with GitHub Pages: either
  - move the contents of `site/` into a `docs/` folder and enable Pages from the repository `main` branch `/docs` folder, or
  - publish the `site/` contents via a `gh-pages` branch (use a deploy action or `gh-pages` tool).

Files to edit:
- `index.html` — markup
- `styles.css` — styles
- `app.js` — interactive behavior

Edit these files and push to the repo to iterate.

Local preview (PowerShell script):

`.\preview.ps1` — serves the repository root on port 8000 by default.
`.\preview.ps1 -Root site -Port 8000` — serve the `site/` folder instead.

Stop the server with Ctrl+C.
