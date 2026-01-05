
#>&2 echo 'INFO: Default oh-my-bash-mrjk loader executed'

# This represent a sane but full configuration for a developper

plugins=(
  # Core
  # battery
  colored-man-pages

  # MrJK
  home_paths
  mise
  direnv

  # Optional tools
  # fzf
  # jump
)
aliases=(
  # Core
  general
  chmod
  ls
  misc

  # Extra
  mrjk_user
  mrjk_user_dev
)

if [ $(id -u) = 0 ]; then
  aliases+=(mrjk_root)
fi

completions=(
  # Core
  brew
  defaults
  docker
  git
  # jump
  makefile
  pip
  pip3
  ssh
  docker-compose
)
