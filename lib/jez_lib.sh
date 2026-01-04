


# Check if path is in $PATH
function in_path () {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        return 1
    fi
    return 0
}

# Add path to PATH if not already present
function path_add () {
    if ! in_path "$1"; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

# Add into path only if dest exists
function path_add_if_exists () {
    if [ -d "$1" ] && ! in_path "$1"; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

# Return true if command exists
function command_exists ()
{
  command -v "$1" 2>&1 >/dev/null
}


export PROMPT_COMMAND

