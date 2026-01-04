#!/bin/bash

# This tool manage oh-my-bash and custom installation

### Lib
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
 
### Installers
OSH_SYSTEM_DIR='/usr/share/oh-my-bash'
OSH_SCAN_FILES="\
  ~/.oh-my-bash/oh-my-bash.sh  \
  ~/.local/share/oh-my-bash/dist/oh-my-bash.sh  \
  ~/opt/oh-my-bash/oh-my-bash.sh \
  ~/.local/share/oh-my-bash/oh-my-bash.sh \
  /usr/share/oh-my-bash/oh-my-bash.sh
"

install_omb (){

  current=$(detect_omb)
  if [ -n "$current" ]; then
    echo "INFO: oh-my-bash is already installed in: $current"
    return
  fi

  local install_prefix=$HOME/.local
  if [ $(id -u) = 0 ]; then
    install_prefix=/usr
    if ! [ -w "$install_prefix" ]; then
      install_prefix=$HOME/.local
    fi
    if ! [ -w "$install_prefix/share/oh-my-bash" ]; then
      install_prefix=$HOME/.local
    fi
  fi
  echo "INFO: installing oh-my-bash in ${install_prefix}/share/oh-my-bash"
  set +x
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended ${install_prefix:+--prefix=$install_prefix}

  export OSH_SYSTEM_DIR="$install_prefix/share/oh-my-bash"
}

REMOTE_URL=https://github.com/mrjk/omb-custom

update_git_repo () {
  local dir=$1
  (
    cd "$dir"
    git pull
  )
}

install_omb_custom () {
  local install_dest=${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-bash/custom

  # System wide install is not supported since OSH_CUSTOM only look by default in user directory
  #local install_prefix=$OSH_SYSTEM_DIR/custom

  ## Detect omb-custom installation
  #if [ -f "$install_prefix/README.md" ]; then
  #  if [ -w "$install_prefix" ] ; then
  #    update_git_repo "$install_prefix"
  #    echo "INFO: oh-my-bash-mrjk has been updated in: $install_prefix"
  #  else
  #    echo "INFO: oh-my-bash-mrjk is already installed in: $install_prefix"
  #  fi
  #  return
  #fi

  ## Install in user paths
  #if ! [ -w "$install_prefix" ]; then
  #  install_prefix=$HOME/.local/share/oh-my-bash/custom
  #fi

  install_prefix=$HOME/.local/share/oh-my-bash/custom
  if ! mkdir -p "$install_prefix"; then
      echo "ERROR: oh-my-bash-mrjk can't find writable path in $install_prefix"
      return
  fi
  
  if [ -f "$install_prefix/README.md" ]; then
    if [ -w "$install_prefix" ] ; then
      update_git_repo "$install_prefix"
      echo "INFO: oh-my-bash-mrjk has been updated in: $install_prefix"
    else
      echo "INFO: oh-my-bash-mrjk is already installed in: $install_prefix"
    fi
    return
  fi

  # Run installation
  echo "INFO: Installing oh-my-bash-mrjk in: $install_prefix"
  if [ -f "$install_prefix/example.sh" ]; then
     rm -rf  "$install_prefix"
  fi
  git clone $REMOTE_URL "$install_prefix"
  echo "INFO: oh-my-bash-mrjk has been installed in: $install_prefix"
  
}

# Function to detect where is currently installed oh-my-bash
detect_omb (){
  #local current_install=${OSH:-}
  #if [ -z "${OSH:-}" ]; then
    current_install=$(first_existing_file ${OSH:-} $OSH_SCAN_FILES)
  #fi
  echo "$current_install"
}

install_bashrc() {
  # Patch .bashrc
  if grep -q "oh-my-bash.sh" ~/.bashrc &>/dev/null; then
    echo "INFO: oh-my-bash is already installed into .bashrc"
  
  else
    echo "INFO: Installing oh-my-bash into .bashrc"
    cat << EOF >> ~/.bashrc

# Load oh-my-bash
export OSH="$OSH_SYSTEM_DIR"
if [ -d "\$OSH" ]; then
  # >&2 echo "INFO: loading oh-my-bash \$OSH"
  source "\$OSH"/oh-my-bash.sh
fi
EOF

  fi
}


install_omb
install_omb_custom
install_bashrc


if [ -z "${OSH:-}" ]; then
  echo "INFO: Run '. ~/.bashrc' to activate"
fi


