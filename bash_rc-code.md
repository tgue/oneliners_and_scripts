*Personalizing your profile

Some code to search through your bash history. The way this works is that it looks for any command starting with the same letter(s) 
as the ones you have typed by clicking on the up and down arrow keys. Say you want to look for previous awk commands, you start typing ```awk``` 
and then click arrow up and it will show the previous awk command

```
bind '"\e[A":history-search-backward'

bind '"\e[B":history-search-forward'
```

it is useful to extend your history in this case: 

```
export HISTSIZE=25000 

export HISTCONTROL=erasedups

shopt -s histappend
```

this expands the size to 25 000 lines (rather than standard 10 000) and deletes duplicates. It also allows to save history from multiple windows without overriding.
