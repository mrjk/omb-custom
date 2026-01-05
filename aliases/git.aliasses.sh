
# Set git user/email environment vars
# Usage:
#   git_user mrjk mrjk.78@gmail.com
#   git_user
#   git_user -

git_user () {
  local user=${1:-}
  local email=${2:-}

  if [ -z "$user" ]; then
    echo "GIT_AUTHOR_NAME=$GIT_AUTHOR_NAME"
    echo "GIT_AUTHOR_EMAIL=$GIT_AUTHOR_EMAIL"
    echo "GIT_COMMITTER_NAME=$GIT_COMMITTER_NAME"
    echo "GIT_COMMITTER_EMAIL=$GIT_COMMITTER_EMAIL"
    return
  elif [ "$user" == - ]; then
    unset GIT_AUTHOR_NAME
    unset GIT_AUTHOR_EMAIL
    unset GIT_COMMITTER_NAME
    unset GIT_COMMITTER_EMAIL
    echo "INFO: Git enviroment reset to default"
    return
  fi

  export GIT_AUTHOR_NAME=$user
  export GIT_AUTHOR_EMAIL=$email
  export GIT_COMMITTER_NAME=$user
  export GIT_COMMITTER_EMAIL=$email
  echo "INFO: Git enviroment set to $user <$email>"
}

# Return a list of commit per years to know how project is living
git_hist() {
  git log --date=format:'%Y' --pretty=format:'%ad' | sort | uniq -c | awk '{print $2 ": " $1}'
}
