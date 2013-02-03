#!/bin/bash
# Screenshot: http://i.imgur.com/2asnT.png
# git magic inspired by https://github.com/gf3/dotfiles/blob/master/.bash_prompt

parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

prompt_desc() {
  OUTPUT=""
  if [ -n "$SSH_CLIENT" ] ; then
    OUTPUT="${OUTPUT}ssh/"
  fi
  if [[ -n $(git branch 2> /dev/null) ]] ; then
    OUTPUT="${OUTPUT}$(parse_git_branch)/"
  fi

  [[ -n "$OUTPUT" ]] && echo " ${OUTPUT%?}"
}

CYAN="\033[36m"
WHITE="\033[37m"
ORANGE="\033[33m"
RESET="\033[0m"

PS1="\[${WHITE}\]\w \[${CYAN}\]${USER}@${HOSTNAME}\[${WHITE}\]\$(prompt_desc) \[${RESET}\]"