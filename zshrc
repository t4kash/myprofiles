# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

setopt auto_pushd
setopt auto_cd
#setopt correct
setopt list_packed
setopt nolistbeep

basePS="[%n@%m %c]$ "
# PROMPT="%B%{[33m%}${basePS}%{[m%}%b"

# set terminal title
case "${TERM}" in
kterm*|xterm*)
    precmd() {
        #echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
        echo -ne "\033]0;s\007"
    }
    PROMPT="%B%{[33m%}${basePS}%{[m%}%b"
    ;;
*)
    PROMPT="${basePS}"
    ;;
esac

# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#export SVN_EDITOR=vi
export SVN_EDITOR=/usr/local/bin/vim

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias view='/usr/local/bin/vim -R'
alias vim='/usr/local/bin/vim'
alias vi='/usr/local/bin/vim'
alias ls='ls -F'
alias doc='cd ~/Documents'
alias down='cd ~/Downloads'
alias svn='/usr/local/bin/svn'
alias works='cd ~/Documents/workspace'
alias memo='cd ~/Dropbox/memo'

function grepsvn() {
#   grep -ir $* | grep -v .svn
#   find . -name .svn -prune -o -type f -exec grep -iH $* {} \;
    find . -name .svn -prune -o -type f | grep -v '\.exe' | grep -v .svn | grep -v '\.pdf$' | xargs grep -iH --binary-files=without-match $*
}

function greps() {
    local curpath=$(pwd)
    mdfind -onlyin . $1 | cut -c $((${#curpath} + 2))- | xargs grep -iH $1
}


PATH=$PATH:/Applications/Xcode.app/Contents/Developer/usr/bin:/usr/local/share/npm/bin

#
#export RAILS_ENV=production

#export CC=/usr/local/bin/gcc-4.2



#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

#export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# for Mac sqlplus
#export DYLD_LIBRARY_PATH=/Applications/instantclient
export PATH=$PATH:/Applications/instantclient
export NLS_LANG=American_Japan.JA16EUC
#export SQLPATH=/Applications/instantclient
alias sqlplus='DYLD_LIBRARY_PATH=/Applications/instantclient SQLPATH=/Applications/instantclient /Applications/instantclient/sqlplus'

export PATH=$PATH:$HOME/bin

# load local environments
[ -f ~/.zshrc_local ] && source ~/.zshrc_local

