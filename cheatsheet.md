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
go to other instances: *
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
redo: ctrl+r
copy line: yy
paste below: p
paste above: P
visual line mode: V
visual block mode: C-v

### search
search for pattern: /<pattern><Esc>
next occurrence of pattern: n
previous occurrence of pattern: N
next and highlight: gn
previous and highlight: gN
change then go to next: cgn<Esc>
delete then go to next dgn<Esc>

## tmux

### panes
split pane vertical: C-a |
split pane horizontal: C-a -
change pane: alt/option + <arrow-key>
toggle pane full screen: C-a z
close pane: C-d

### windows
new window: C-a c
previous window: C-a p
next window: C-a n
go to window: C-a <number>
rename current window: C-a ,

### sessions
list sessions: tmux ls
attach to session: tmux attach -t <number || session-name>
start new named session: tmux new -s <session-name>
rename session: tmux rename-session -t <old-number || old-name> <new-name>
kill current session: C-a :kill-session
kill other session: tmux kill-session -t <other-session>
kill all sessions: tmux kill-server
