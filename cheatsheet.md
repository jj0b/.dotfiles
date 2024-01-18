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
:split <filename> - Split window horiontally
:new [filename] - Create new window

#### tabs

:tabnew file.txt - open file.txt in a new tab
:tabclose - Close current tab
:tabnext - Go to next tab
:tabprevious - Go to previous tab
:tablast - Go to last tab
:tabfirst - Go to first tab

### custom

#### normal mode

move text up: A-j
move text down: A-k

choose buffer: gb

open new tab: to <file_name>
close tab: tc
next tab: tn
previous tab: tp
last tab: tl
first tab: tf

split horizontal: ss
split vertical: sv
toggle between open windows: <space>
move between windows: s + hjkl
resize window: C-w + arrows

move between windows: <leader>h, <leader>j, <leader>k, <leader>l
resize windows: C-Up, C-Down, C-Left, C-Right
navigate buffers, next: S-l
navigate buffers, previous: S-h

### source plugins with Packer

source file: so %
install Packer plugins: PackerInstall

### nvim-treesitter

provides better syntax highlighting
install language: TSInstall <language>
list languages and install status: TSInstallInfo
update installed languages: TSUpdate

### nvim-surround

#### Old text -- Command -- New text

surr*ound_words ysiw) (surround_words)
*make strings ys$" "make strings"
[delete ar*ound me!] ds] delete around me!
remove <b>HTML t*ags</b> dst remove HTML tags
'change quot*es' cs'" "change quotes"
<b>or tag* types</b> csth1<CR> <h1>or tag types</h1>
delete(functi*on calls) dsf function calls

### telescope

find files: ;f
live grep: ;r
buffers: \\
help tags: ;t
resume: ;;
diagnostics: ;e

#### telescope-browser

file browser: sf
open file: o
create file: c
rename file: r
delete file: d
toggle hidden files: h

## tmux

### plugins with tpm (https://github.com/tmux-plugins/tpm)

install plugins: <prefix> I
update plugins: <prefix> U
remove plugins not on list: <prefix> alt u

### panes

split pane vertical: <prefix> "
split pane horizontal: <prefix> %
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
detach from current session: <prefix> d
start new named session: tmux new -s <session-name>
rename session: tmux rename-session -t <old-number || old-name> <new-name>
kill current session: <prefix> :kill-session
kill other session: tmux kill-session -t <other-session>
kill all sessions: tmux kill-server
