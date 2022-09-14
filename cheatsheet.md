# Cheatsheet

## neovim

### general

repeat command: .
center cursor: zz
view default keymaps: :h key-notation

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
visual line mode: V
visual block mode: C-v
change multiple instances: cgn<foo>Esc .

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
change then go to next: cgn<Esc>
delete then go to next dgn<Esc>

### custom

leader: <space>

#### normal mode

open nvim-tree file explorer: <leader>e
move between windows: <leader>h, <leader>j, <leader>k, <leader>l
resize windows: C-Up, C-Down, C-Left, C-Right
navigate buffers, next: S-l
navigate buffers, previous: S-h
move text up: A-j
move text down: A-k
search files with fzf respecting gitignore: <leader>p

#### insert mode

escape to normal mode from insert mode: jj
insert trailing ; from insert mode: ;;
insert trailing , from insert mode: ,,
move text up: A-j
move text down: A-k

#### visual mode

stay in indent mode: <, >
move text up: A-j
move text down: A-k
paste replace visual selection without copying it: p

### source plugins with VIM Plug

source file: so %
install VIM Plug plugins: PlugInstall

### nvim-treesitter

provides better syntax highlighting
install language: TSInstall <language>
list languages and install status: TSInstallInfo
update installed languages: TSUpdate

### nvim-surround

#### Old text Command New text

surr*ound_words ysiw) (surround_words)
*make strings ys$" "make strings"
[delete ar*ound me!] ds] delete around me!
remove <b>HTML t*ags</b> dst remove HTML tags
'change quot*es' cs'" "change quotes"
<b>or tag* types</b> csth1<CR> <h1>or tag types</h1>
delete(functi*on calls) dsf function calls

### nvim-tree

move around like in any vim buffer
<CR> or o on .. will cd in the above directory
<C-]> will cd in the directory under the cursor
<BS> will close current opened directory or parent
type a to add a file. Adding a directory requires leaving a leading / at the end of the path.
you can add multiple directories by doing foo/bar/baz/f and it will add foo bar and baz directories and f as a file
type r to rename a file
type <C-r> to rename a file and omit the filename on input
type x to add/remove file/directory to cut clipboard
type c to add/remove file/directory to copy clipboard
type p to paste from clipboard. Cut clipboard has precedence over copy (will prompt for confirmation)
type d to delete a file (will prompt for confirmation)
type ]c to go to next git item
type [c to go to prev git item
type - to navigate up to the parent directory of the current file/directory
if the file is a directory, <CR> will open the directory otherwise it will open the file in the buffer near the tree
if the file is a symlink, <CR> will follow the symlink (if the target is a file)
<C-v> will open the file in a vertical split
<C-x> will open the file in a horizontal split
<C-t> will open the file in a new tab
<Tab> will open the file as a preview (keeps the cursor in the tree)
I will toggle visibility of folders hidden via |g:nvim_tree_ignore|
H will toggle visibility of dotfiles (files/folders starting with a .)
R will refresh the tree
Double left click acts like <CR>
Double right click acts like <C-]>

## tmux

### plugins with tpm (https://github.com/tmux-plugins/tpm)

install plugins: <prefix> I
update plugins: <prefix> U
remove plugins not on list: <prefix> alt u

### panes

split pane vertical: <prefix> |
split pane horizontal: <prefix> -
change pane: <prefix> h, <prefix> j, <prefix> k, <prefix> l
toggle pane full screen: <prefix> z
close pane immediately: C-d
close pane with confirmation: <prefix> x
resize panes: <prefix> C-k, C-j, C-h, C-l 

### windows

new window: <prefix> c
previous window: <prefix> p
next window: <prefix> n
go to window: <prefix> <number>
rename current window: <prefix> ,
close window: <prefix> &

### sessions

list sessions: tmux ls
attach to session: tmux attach -t <number || session-name>
start new named session: tmux new -s <session-name>
rename session: tmux rename-session -t <old-number || old-name> <new-name>
kill current session: <prefix> :kill-session
kill other session: tmux kill-session -t <other-session>
kill all sessions: tmux kill-server
