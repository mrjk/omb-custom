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
OSH_SCAN_DIRS="\
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
  else
    if [ $(id -u) = 0 ]; then
      install_prefix=/usr
    fi
    echo "INFO: installing oh-my-bash in $install_prefix"
    #export OSH="$install_prefix"
    set +x
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended --prefix=$install_prefix
  fi

}

REMOTE_URL=https://github.com/mrjk/omb-custom

install_omb_custom () {
  local install_dest=${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-bash/custom
  local root_install=false
  local install_prefix=$install_dest
  if [ $(id -u) = 0 ]; then
    root_install=true
    install_prefix=/usr/share/oh-my-bash/custom
  fi
  
  if ! [ -f "$install_prefix/README.md" ]; then
    echo "INFO: Installing oh-my-bash-mrjk in: $install_prefix"
    if $root_install; then
      if [ -f "$install_prefix/example.sh" ]; then
        echo "INFO: Removing oh-my-bash examples dir: $install_prefix"
        rm -rf  "$install_prefix"
      fi
    else
      if [ -f "$install_prefix/example.sh" ]; then
        echo "WARN: Please remove any files in $install_prefix to continue installation"
        return 0
      fi
    fi
    git clone $REMOTE_URL "$install_prefix"
  else
    echo "INFO: oh-my-bash-mrjk is already installed in: $install_prefix"
    return 
  fi
  echo "INFO: oh-my-bash-mrjk has been installed in: $install_prefix"
  
}

# Function to detect where is currently installed oh-my-bash
detect_omb (){
  local current_install=${OSH:-}
  if [ -z "${OSH:-}" ]; then
    current_install=$(first_existing_file $OSH_SCAN_DIRS)
  fi
  echo "$current_install"
}

install_bashrc() {
  # Patch .bashrc
  if grep -q "oh-my-bash" ~/.bashrc &>/dev/null; then
    echo "INFO: oh-my-bash is already installed into .bashrc"
  
  else
    echo "INFO: Installing oh-my-bash into .bashrc"
    cat << 'EOF' >> ~/.bashrc

# Load oh-my-bash
export OSH="/usr/share/oh-my-bash"
if [ -d "$OSH" ]; then
  >&2 echo "INFO: loading oh-my-bash $OSH"
  source "$OSH"/oh-my-bash.sh
fi
EOF

  fi
}


install_omb
install_omb_custom
install_bashrc


if [ -z "${OSH:-}" ]; then
  echo "INFO: Run '. ~/.bashrc to activate'"
fi


