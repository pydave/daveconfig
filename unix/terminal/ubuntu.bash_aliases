#! /bin/bash
#
#################
# Linux

alias gogo='xdg-open'
# safer way to delete
alias trash='mv -t ~/.local/share/Trash/files --backup=t'
# aptitude
alias aptupdate='sudo aptitude update'
alias aptinstall='sudo aptitude install'
alias aptremove='sudo aptitude remove'
alias aptautoremove='sudo apt-get autoremove'   # no autoremove for aptitude
alias aptsearch='apt-cache search'
alias aptshow='apt-cache show'
alias aptwhichrepo='apt-cache policy'
alias aptpkglist='dpkg-query --list'
alias aptfiles='dpkg-query --listfiles'
