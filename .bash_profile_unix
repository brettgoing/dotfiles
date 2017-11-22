export PATH=$HOME/bin:/usr/local/redis/bin:$PATH
alias cddev="cd $HOME/go/src/github.com/VerveWireless/otas"

# colorize all the things
username='\[\033[0;33m\]\u\[\033[0m\]'
host='\[\033[0;32m\]@\h\[\033[0m\]'
pwd='\[\033[1;34m\]\w\[\033[0m\]'
export PS1="$username$host $pwd\$ "
export GREP_OPTIONS='--color=auto'
alias ls="ls --color"

# grep
alias g="grep -ir  --include=\"*.go\" --exclude-dir=\"Godeps\""

# ssh
eval `ssh-agent -s`
ssh-add ~/.ssh/id_rsa &>/dev/null

# postgres
export PATH="/usr/pgsql-9.5/bin:${PATH}"
export LD_LIBRARY_PATH="/usr/local/lib:/usr/lib"
