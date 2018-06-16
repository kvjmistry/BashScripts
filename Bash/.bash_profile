# added by Anaconda2 5.0.1 installer
export PATH="/Users/kvjmistry/anaconda2/bin:$PATH"

# Add sublime to path
export PATH="/usr/local/bin:$PATH"

#kerberos path
export PATH=/usr/krb5/bin:$PATH

# Add why does it always rain 
if [ -f ~/.bash_aliases ]; then
    source ~/.cache/colour.sh
fi

#colourful terminal
export PS1="\[`tput setaf 2``tput bold`\]\u@\h\[`tput setaf 4``tput bold`\] $\[`tput sgr0`\] "

#give coloured ls commands
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'

# Add tbrowser function
if [ -f ~/functions/tbrowser.sh ]; then
    source ~/functions/tbrowser.sh
fi

# Add bash aliases.
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi





