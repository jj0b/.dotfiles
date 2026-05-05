# Cheatsheet

## neovim

### general

check if a key is mapped: :verb map <key>
repeat command: .
center cursor: zz
view default keymaps: :h key-notation
open file: :e <file_name>

### movement

move: h,j,k,l
top of file: gg
bottom of file: G
skip blocks: {,}
loop commands with numbers
move forward by words: w
move backward by words: b
move to line: :<num>
beginning of line: 0
end of line: $
beginning word: ^
move forward by word, ignore punctuation: W
move back by word, ignore punctuation: B
go to (before) character in line: t+<char>
go to (on) character in line: f+<char>
go between block parenthesis: %
go to next instance of word: \*
go to next instance of character under cursor: ;

### insert

insert: i
insert at beginning of line: I
insert line below: o
insert line above: O
append after cursor: a
append to end of line: A

### delete

delete line: dd (also copies to buffer)
delete character under cursor: x
delete to end of line: D
delete characters: d+<command>

### modify

change characters: c+<command>
change case of letter: ~
undo/redo: u
redo: C-r
copy line: yy
paste below: p
paste above: P
copy to + buffer: "+yy
paste from + buffer: "+p
visual line mode: V
visual block mode: C-v
select word and change multiple instances: \*cgn<foo>Esc then . to change other instances

### edit multiple lines

1. go into visual block mode with C-v
2. use hjkl to select lines
3. insert with S-i
4. <esc> to change all lines

### search

search for pattern: /<pattern><Esc>
next occurrence of pattern: n
previous occurrence of pattern: N
next and highlight: gn
previous and highlight: gN
change selected word then go to next: cgn<Esc>
delete selected word then go to next dgn<Esc>
remove highlighting: :noh
clear search: C-l

#### buffers

:ls - list all buffers
:b4 - switch to buffer number 4
:bn - switch to next buffer in the buffer list
:bp - switch to previous buffer in the buffer list
:bf - switch to first buffer in the buffer list
:bl - switch to last buffer in the buffer list
:b foo<Tab> - switch by buffer name with tab-completion
:b# - switch to the alternate file

#### window

<Ctrl-W>+v - Opens a new vertical split
<Ctrl-W>+s - Opens a new horizontal split
<Ctrl-W>+c - Closes a window
<Ctrl-W>+o - Makes current window the only one on screen and closes other windows
<Ctrl-W>+h/j/k/l - Moves the cursor to left/bottom/top/right

:vsplit <filename> - Split window vertically
:split <filename> - Split window horizontally
:new [filename] - Create new window

#### tabs

:tabnew file.txt - open file.txt in a new tab
:tabclose - Close current tab
:tabnext - Go to next tab
:tabprevious - Go to previous tab
:tablast - Go to last tab
:tabfirst - Go to first tab

### LazyVim (default `<leader>` is space)

Full list: https://www.lazyvim.org/keymaps — press `<leader>` and pause to open **which-key**.

#### often used

- find files (repo root): `<leader>ff`
- find files (cwd): `<leader>fF`
- grep / live grep (root): `<leader>/` or `<leader>sg`
- grep (cwd): `<leader>sG`
- buffer picker: `<leader>,` or `<leader>fb`
- file explorer (Snacks): `<leader>e` (root), `<leader>E` (cwd)
- Mason (install LSP/formatters): `<leader>cm` or `:Mason`
- Lazy (plugins): `<leader>l` or `:Lazy`
- LazyVim extras: `:LazyExtras` (or edit `lazyvim.json`)
- prev / next buffer: `[b` / `]b` or `<S-h>` / `<S-l>`
- window focus: `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`
- split below / right: `<leader>-`, `<leader>|`
- delete window: `<leader>wd`
- move line down / up: `<A-j>`, `<A-k>` (normal / insert / visual)
- format buffer / selection: `<leader>cf`

#### tabs (which-key under `<leader><tab>`)

LazyVim groups tab keys under `<leader><tab>` (new / close / next / prev / last / first, etc.). Press `<leader><tab>` and read the popup.

### lazy.nvim (plugins)

- plugin UI: `:Lazy` (sync, update, pin)
- extras list: `:LazyExtras`
- reload current file as config: `:source %` (or `so %`)

### mini.surround (LazyVim default)

Prefix is **`gs`** (see `:h MiniSurround`).

| Action                       | Keys (typical)        |
| ---------------------------- | --------------------- |
| add surrounding              | `gsa` + motion + char |
| delete surrounding           | `gsd`                 |
| replace surrounding          | `gsr`                 |
| find / highlight surrounding | `gsf` / `gsF` / `gsh` |

### find / grep / lists (Snacks picker by default)

- diagnostics (workspace): `<leader>sd`; buffer: `<leader>sD`
- resume last picker: `<leader>sR`
- help: `<leader>sh`

## tmux

Config: `tmux/.config/tmux/tmux.conf` (stows to `~/.config/tmux/tmux.conf`).

### prefix

**`<prefix>` = Ctrl+Space** (not the default `C-b`).

### panes

- split with **new pane below** (tmux `split-window -v`): `<prefix> "`
- split with **new pane to the right** (tmux `split-window -h`): `<prefix> %`
- both splits open in the **current pane’s working directory**
- move focus (**no prefix**, [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) — tmux passes keys through when a pane is Neovim): `C-h`, `C-j`, `C-k`, `C-l`
- zoom / unzoom current pane (tmux default): `<prefix> z`
- close pane (**confirm**): `<prefix> x`
- kill **all other** panes (**confirm**): `<prefix> e`
- exit shell in pane (usual): `C-d`

### other bindings from your config

- reload config: `<prefix> r`
- **macOS** `open` on pane’s cwd: `<prefix> o`
- **lazygit** in a popup (`80%` size): `<prefix> g`

### copy mode (vi)

- enter copy mode: `<prefix> [`
- then: `v` start selection, `C-v` rectangle, `y` yank and exit

### windows & sessions (mostly tmux defaults)

Windows start at index **1** (`base-index 1`); `renumber-windows` is on.

- new window: `<prefix> c`
- previous / next: `<prefix> p` / `<prefix> n`
- go to window: `<prefix> <number>`
- rename: `<prefix> ,`
- close: `<prefix> &`

Sessions:

- list: `tmux ls`
- attach: `tmux attach -t <name-or-number>`
- detach: `<prefix> d`
- new named: `tmux new -s <name>`
- rename: `tmux rename-session -t <old> <new>`
- kill session: `<prefix> :kill-session` (command mode) or `tmux kill-session -t <name>`
- kill server: `tmux kill-server`
