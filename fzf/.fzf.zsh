# Setup fzf
# ---------
if [[ ! "$PATH" == */home/kristoffer/.fzf/bin* ]]; then
  export PATH="$PATH:/home/kristoffer/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/kristoffer/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/kristoffer/.fzf/shell/key-bindings.zsh"

