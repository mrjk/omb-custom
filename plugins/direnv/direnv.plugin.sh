
_omb_module_require_lib mrjk_lib


if command_exists direnv ; then
  _omb_util_print "Enabling direnv ..."

_direnv_hook() {
  local previous_exit_status=$?;
  trap -- '' SIGINT;
  eval "$("direnv" export bash)";
  trap - SIGINT;
  return $previous_exit_status;
};


  #eval "$(direnv hook bash)"

# USe _omb_util_prompt_command INSTEAD
if [[ ";${PROMPT_COMMAND:-};" != *";_direnv_hook;"* ]]; then
  #PROMPT_COMMAND="_direnv_hook${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
  PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND;}_direnv_hook"
fi


fi

