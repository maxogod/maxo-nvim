# MaxoNvim - Help

**Hi bro! need help? - No worries, i got your back B)**

---

## The Leader o7

* `<leader>` == **space**
* `<localleader>` == `\`

---

## Finding & opening files

* `<Ctrl>p` - Find them FAST! (fuzzy file picker)
    - `<Enter>` - open in a **new tab**
    - `<Ctrl>s` - open in a **vertical split**
* `<leader>fg` - Search files by the words inside them (live grep, opens in a new tab).
* `<leader>fb` - Jump to an open buffer.
* `<leader>fh` - Search Neovim's own help pages.
* `<leader>fr` - Find & replace across the whole project (Spectre).
* `/<pattern>` then `n` / `N` - Find a pattern, jump next/prev. Use \c or \C for case sensitivity.
* `gx` - Open the file path or URL under the cursor in your system handler.

## Tabs & windows

* `<leader>t` - New tab.
* `<leader><number>` - Jump straight to that tab (1-9).
* `<Alt><Left/Right>` - Previous / next tab.
* `<Alt>w` - Close the current window.
* `:Shutdown` - Close everything at once and quit.

---

## The file tree

* `<leader>e` - Toggle the tree.
* `g?` - **In-tree help. Shows all 60-odd tree keys, press it when lost.**

Inside the tree:

* `<Enter>` - Open the file in a **new tab**.
* `o` - Open in the current window. `<Tab>` - preview without leaving the tree.
* `<Ctrl>v` / `<Ctrl>x` - Open in a vertical / horizontal split.
* `a` - Add file or dir (end the name with `/` to make a dir).
* `r` - Rename. `d` - Delete. `D` - Trash.
* `Y` - Copy file. `X` - Cut (move) file. `p` - Paste into the path.
* `gy` - Copy absolute path. `ge` - Copy basename.
* `H` - Toggle hidden files. `I` - Toggle git-ignored files.
* `E` - Expand all. `W` - Collapse all. `R` - Refresh.
* `f` - Live filter, `F` - clear it. `S` - Search.
* `P` - Jump to parent dir. `-` - Go up a level.
* `]c` / `[c` - Next / prev git change. `]e` / `[e` - Next / prev diagnostic.
* `q` - Close the tree.

---

## Fast editing

* `<Ctrl>s` - Save this file (`:w`).
* `<Ctrl><Alt>s` - Save every open file (`:wa`).
* `<Ctrl>a` - Select the whole buffer.
* `<Ctrl>z` - Undo. `<Ctrl>y` - Redo.

* `<leader>y` - Copy selection to system clipboard.
* `<leader>x` - Cut selection to system clipboard.

* `<Alt><Up/Down>` - Move the selected lines up n' down!
* `<Ctrl><Shift><Up/Down>` - Duplicate the line / selection.
* `<Shift>d` - Delete the current line (normal mode).
* `<Enter><Enter>` - Append an empty line below (normal mode).
* `select + <Tab>` / `<Shift><Tab>` - Indent / unindent the selection.
* `<Ctrl><Backspace>` - Delete the word before the cursor (insert mode).
* `<Ctrl><Delete>` - Delete the word after the cursor (insert mode).
* `<leader>/` - Toggle comment (line in normal mode, block in visual).
    - Vim's own `gcc` / `gc{motion}` work too.
* `select + <Shift>u` / `u` - Upper / lowercase the selection.
* `:%s/old/new/g` - Replace all `old` with `new` in the file.

### Wrapping things in brackets & quotes (surround)

* `select + S<char>` - Wrap the selection, e.g. `S"` gives `"example"`.
* `ys{motion}{char}` - Wrap a motion, e.g. `ysiw)` wraps the word in `()`.
* `yss{char}` - Wrap the whole line.
* `cs{old}{new}` - Change surrounding, e.g. `cs"'` turns `"x"` into `'x'`.
* `ds{char}` - Delete the surrounding pair.

Brackets and quotes close themselves as you type, and `/*` closes with `*/`.
HTML/JSX tags auto-close and auto-rename their pair.

### Multiple cursors (batch edit, oh yeah)

* `<Alt><Shift><Up/Down>` - Add a cursor above / below.
* `<Ctrl>n` - Select the word under the cursor, press again for the next match.
* `<Shift><Left/Right>` - Grow the selection under every cursor.
* `<Esc>` - Drop back to one cursor.

### Selecting by code structure

* `select + an` - Grow the selection to the parent syntax node.
* `select + in` - Shrink it to the child node.
* `select + ]n` / `[n` - Move to the next / previous node.

### Folding

* `c1` - Collapse the current fold.      `x0` - Expand the current fold.
* `c2` - Collapse all but this one.      `x1` - Expand this one + children.
* `c3` - Collapse everything.            `x2` - Expand one level.
* `<Ctrl>k` - Collapse current fold.     `x3` - Expand everything.
* `<Ctrl>l` - Expand current fold.
* `<Ctrl><Alt>k` / `<Ctrl><Alt>l` - Collapse / expand everything.

---

## Completion (blink.cmp)

* `<Up>` / `<Down>` - Previous / next suggestion.
* `<Enter>` - Accept the selected suggestion.
* `<Esc>` - Dismiss the menu.
* `<Ctrl><Space>` - Force the menu open / toggle the docs window.
* `<Ctrl><Up>` / `<Ctrl><Down>` - Scroll the documentation window.
* `<Tab>` / `<Shift><Tab>` - Jump between snippet placeholders.
* `<Ctrl>s` - Show the signature of the function you're calling (insert mode).

Nothing is preselected, so `<Enter>` on an untouched menu just inserts a newline.

---

## Details & Info (LSP)

* `gd` - Go to definition (opens it in a **new tab**).
* `<leader>gi` - Go to implementation (falls back to the definition).
* `<Ctrl>i` - See the doc of an object/fn/var/etc. (`K` does the same).
* `<Ctrl>r` - See code references to the thing under the cursor.
* `<Ctrl>e` - Expand the error message under the cursor.
* `[d` / `]d` - Prev / next diagnostic.
* `<leader>rn` - Refactor: rename the symbol everywhere.
* `<leader>ca` - Code actions for whatever is under the cursor.
* `<leader>f` - Format the current file.
* `<leader>tf` - Toggle format-on-save (it's **on** by default).

### LSP servers

* `:Mason` / `<leader>m` - The LSP catalog. Install what you need bro!
* `<leader>lr` - Restart every language server.

---

## Git

* `:G` - Check your repo status.
* `:G <git command>` - Run any git command (`:G commit`, `:G push`, ...).
* `<leader>gb` - Toggle inline git blame for the current line.
* `<leader>gB` - Open the commit under the cursor in your browser.
* `:Gdiffsplit` - Diff the file against the index, side by side.

---

## Toggles

* `<leader>tf` - Format on save.
* `<leader>wr` - Line wrapping.
* `<leader>bg` - Background transparency (see your terminal wallpaper through nvim).

---

## Plugins & config

* `:Lazy` / `<leader>L` - Plugin manager. `U` updates, `X` cleans, `?` for help.
* `:checkhealth` - Diagnose a broken setup.
* `<leader>h` - Open this cheat sheet.
* `<leader><leader>` - Source the file you're editing (handy for config tweaks).

**Add a plugin:** drop a file in `lua/plugins/` returning a lazy.nvim spec.
**Add a language server:** drop a file in `lua/lsp/<name>.lua` returning its
config table. Both are picked up automatically, nothing else to edit.

---

## Fast quitting

* `<Alt>w` - Close this window.
* `:Shutdown` - This will quit everything at once!
