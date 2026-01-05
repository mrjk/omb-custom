
alias h='history'
alias j='jobs -l'
alias mkdir='mkdir -p'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../..'
alias ~='cd ~'

alias ll='ls -lAh'
alias la='ls -lA'
alias l='ls -ClFh'
alias ltr='ls -ahltr'
alias lsd="ls -l | grep ^d"


# Supershorts
alias s='sudo -i'
alias v='vim'
alias sv='sudo vim'



alias vih='sudo vim /etc/hosts '
alias vit='sudo vim /etc/fstab '

! command -v colordiff >&/dev/null || alias diff='colordiff '
! command -v column >&/dev/null || alias tmount='mount |column -t '

alias wgets='wget --no-check-certificate '
alias wgeth='wget --no-check-certificate -S -O /dev/null '
alias uncmt="grep '^[^#|^$|^ *$]' "
alias monip='wget -q -O - "$@" monip.org | grep -o "[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}"'
alias monhost='echo "My host is ..."; host $(wget -q -O - "$@" monip.org | grep -o "[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}")'
alias text2ascii='tail --bytes=+4'


alias ssh_unsecure='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o CheckHostIP=no'
alias ssh_local='ssh -o CheckHostIP=no '

