# Generic omb loader

# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

existing_files() {
    local result=()
    
    for arg in "$@"; do
        # Expand glob patterns
        for file in $arg; do
            # Check if file exists (and is not the unexpanded glob itself)
            if [[ -e "$file" ]]; then
                result+=("$file")
            fi
        done
    done
    
    # Print results, one per line
    printf '%s\n' "${result[@]}"
}
first_existing_file() {
    existing_files "$@" | head -n 1
}


#SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
_osh_install_src=$(first_existing_file \
  ~/.oh-my-bash/oh-my-bash.sh \
  ~/opt/oh-my-bash/oh-my-bash.sh \
  ~/.local/share/oh-my-bash/oh-my-bash.sh \
  /usr/share/oh-my-bash/oh-my-bash.sh 
)
_osh_cfg_srcs=$(first_existing_file \
  ~/.config/oh-my-bash/config.sh \
  ~/.local/share/oh-my-bash/custom/config/config.sh \
  /etc/oh-my-bash/config.sh \
  /usr/share/oh-my-bash/custom/config/config.sh
)
_osh_loader_srcs=$(first_existing_file \
  ~/.config/oh-my-bash/loader.sh \
  ~/.local/share/oh-my-bash/custom/config/loader.sh \
  /etc/oh-my-bash/loader.sh \
  /usr/share/oh-my-bash/custom/config/loader.sh
)

# echo SCRIPT_DIR=$SCRIPT_DIR

# Load local config
for src in $_osh_cfg_srcs $_osh_loader_srcs; do
  if [ -f "$src" ]; then
    >&2 echo "INFO: Loading config: $src"
    . "$src"
  fi
done

#export OSH="${_osh_install_src%/*}"
#source "$OSH"/oh-my-bash.sh

#echo "DEBUG PLUGINS=$plugins"
#echo "DEBUG ALIASES=$aliases"
#aliases=(
#  general
#  mrjk_user
#  mrjk_user_dev
#  mrjk_root
#)
#completions=(
#  git
#  composer
#  ssh
#)
#OSH_THEME="font"

#plugins=(
#  git
#  bashmarks
#  home_paths
#  mise
#  direnv
#)



# Load extra config from previously loaded config
_omb_module_require_plugin "${plugins[@]}"
_omb_module_require_alias "${aliases[@]}"
_omb_module_require_completion "${completions[@]}"

