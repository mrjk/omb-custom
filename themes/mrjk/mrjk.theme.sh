#! bash oh-my-bash.module

# NON UTF8
# https://github.com/ohmybash/oh-my-bash/blob/63ebf657816a76a9422b2262289bd8eb5eed2c72/lib/omb-prompt-base.sh#L133

# SCM_GIT='git'
# SCM_GIT_CHAR='±'
SCM_GIT_CHAR=''
# SCM_GIT_DETACHED_CHAR='⌿'
# SCM_GIT_AHEAD_CHAR="↑"
# SCM_GIT_BEHIND_CHAR="↓"
# SCM_GIT_UNTRACKED_CHAR="?:"
# SCM_GIT_UNSTAGED_CHAR="U:"
# SCM_GIT_STAGED_CHAR="S:"
# 
# SCM_HG='hg'
# SCM_HG_CHAR='☿'
# 
# SCM_SVN='svn'
# SCM_SVN_CHAR='⑆'
# 
# SCM_NONE='NONE'
# SCM_NONE_CHAR='○'
# 
# # ----
# SCM_THEME_PROMPT_DIRTY=' ✗'
# SCM_THEME_PROMPT_CLEAN=' ✓'
# SCM_THEME_PROMPT_PREFIX=' |'
# SCM_THEME_PROMPT_SUFFIX='|'
# SCM_THEME_BRANCH_PREFIX=''
# SCM_THEME_TAG_PREFIX='tag:'
# SCM_THEME_DETACHED_PREFIX='detached:'
# SCM_THEME_BRANCH_TRACK_PREFIX=' → '
# SCM_THEME_BRANCH_GONE_PREFIX=' ⇢ '
# SCM_THEME_CURRENT_USER_PREFFIX=' ☺︎ '
# SCM_THEME_CURRENT_USER_SUFFIX=''
# SCM_THEME_CHAR_PREFIX=''
# SCM_THEME_CHAR_SUFFIX=''

# Code is ugly, I tried to port as quick as possible

# SCM_THEME_PROMPT_PREFIX=""
# SCM_THEME_PROMPT_SUFFIX=""
# 
# SCM_THEME_PROMPT_DIRTY="\[${_omb_prompt_bold_brown}\]✗\[${_omb_prompt_normal}\]"
SCM_THEME_PROMPT_DIRTY="\[${Yellow}\]!\[${Color_Off}\]"
#SCM_THEME_PROMPT_CLEAN="\[${Green}\]\[✓\]\[${Color_Off}\]"
SCM_THEME_PROMPT_CLEAN=""  # Nothing is displayed when everything is fine
#SCM_THEME_PROMPT_CLEAN="\[${Green}\]=\[${Color_Off}\]"
# #SCM_GIT_CHAR="\[${Cyan}\]±\[${Color_Off}\]"
#SCM_GIT_CHAR="\[±\]"
# SCM_SVN_CHAR="${_omb_prompt_bold_green}⑆${_omb_prompt_normal}"
# SCM_HG_CHAR="${_omb_prompt_bold_brown}☿${_omb_prompt_normal}"

SCM_THEME_PROMPT_PREFIX="\[${Cyan}\]["
SCM_THEME_PROMPT_SUFFIX="\[${Cyan}\]]\[${Color_Off}\]"

#Mysql Prompt
export MYSQL_PS1="(\u@\h) [\d]> "

case $TERM in
xterm*)
  TITLEBAR="\[\033]0;\w\007\]"
  ;;
*)
  TITLEBAR=""
  ;;
esac

PS2="> "
PS3=">> "


### NOT USED ...
# function __my_rvm_ruby_version {
#   local gemset=$(awk -F'@' '{print $2}' <<< "$GEM_HOME")
#   [[ $gemset ]] && gemset=@$gemset
#   local version=$(awk -F'-' '{print $2}' <<< "$MY_RUBY_HOME")
#   local full=$version$gemset
#   [[ $full ]] && _omb_util_print "[$full]"
# }
# 
# function __my_venv_prompt {
#   if [[ $VIRTUAL_ENV ]]; then
#     _omb_util_print "[${_omb_prompt_navy}@${_omb_prompt_normal}${VIRTUAL_ENV##*/}]"
#   fi
# }
# 
# function is_vim_shell {
#   if [[ $VIMRUNTIME ]]; then
#     _omb_util_print "[${_omb_prompt_teal}vim shell${_omb_prompt_normal}]"
#   fi
# }

function modern_scm_prompt {
  local CHAR=$(scm_char)
  if [[ $CHAR == "$SCM_NONE_CHAR" ]]; then
    return
  else
    _omb_util_print "[$(scm_char)][$(scm_prompt_info)]"
  fi
}

SCM_GIT_SHOW_MINIMAL_INFO=true
SCM_GIT_SHOW_MINIMAL_INFO=false
SCM_GIT_SHOW_DETAILS=false

function modern_scm_prompt2 {
  scm
  # scm_prompt_char
  [[ "$SCM" == "NONE" ]] && return
    # OK: working with char non escaped
    #_omb_util_print "\[$Cyan\][\[$(scm_char)\]\[$(scm_prompt_info)\]]\[$Color_Off\]"
    # New test with extended info, reauire escaped char
    #_omb_util_print "\[$Cyan\][$(scm_char)$(scm_prompt_info)\[$Cyan\]]\[$Color_Off\]"
    _omb_util_print "$(scm_char)$(scm_prompt_info)\[$Color_Off\]"


  #local CHAR=$(scm_char)
    #_omb_util_print "[$(scm_char)$(scm_prompt_info)]"
    #_omb_util_print "[\[$(scm_char)\]\[$(scm_prompt_info)\]]"

## OLD

    #echo -e "[\[$(scm_char)$(scm_prompt_info)\]]"
    #echo "[\[$(scm_char)$(scm_prompt_info)\]]"
    #echo -e "[$(scm_char)$(scm_prompt_info)]"
    #echo "[$(scm_char)$(scm_prompt_info)]"

    #echo "[\[$(scm_char)\]\[$(scm_prompt_info)\]]"

    #echo "[$(scm_char)$(scm_prompt_info)]"
    #echo "[$(scm_char)]"
    #echo "[\[$Red\]$SCM_CHAR\[$Color_Off\]]"

   #echo "[\[$Red\]$SCM_CHAR\[$Color_Off\]]"
   #echo "\[$Yellow\][$SCM_CHAR]\[$Color_Off\]"
   #echo -n "\[$Yellow\][$(scm_char)\[$(scm_prompt_info_common)\]]\[$Color_Off\]"

}


################################

##########################
# Func: Global color
##########################

shell_global_color () {
  # Easy
  RED='\[\033[31m\]'
  GREEN='\[\033[32m\]'
  YELLOW='\[\033[33m\]'
  BLUE='\[\033[34m\]'
  PURPLE='\[\033[35m\]'
  CYAN='\[\033[36m\]'
  WHITE='\[\033[37m\]'
  NIL='\[\033[00m\]'

  # Reset
  Color_Off='\e[0m'       # Text Reset

  # Regular Colors
  Black='\e[0;30m'        # Black
  Red='\e[0;31m'          # Red
  Green='\e[0;32m'        # Green
  Yellow='\e[0;33m'       # Yellow
  Blue='\e[0;34m'         # Blue
  Purple='\e[0;35m'       # Purple
  Cyan='\e[0;36m'         # Cyan
  White='\e[0;37m'        # White

  # Bold
  BBlack='\e[1;30m'       # Black
  BRed='\e[1;31m'         # Red
  BGreen='\e[1;32m'       # Green
  BYellow='\e[1;33m'      # Yellow
  BBlue='\e[1;34m'        # Blue
  BPurple='\e[1;35m'      # Purple
  BCyan='\e[1;36m'        # Cyan
  BWhite='\e[1;37m'       # White

  # Underline
  UBlack='\e[4;30m'       # Black
  URed='\e[4;31m'         # Red
  UGreen='\e[4;32m'       # Green
  UYellow='\e[4;33m'      # Yellow
  UBlue='\e[4;34m'        # Blue
  UPurple='\e[4;35m'      # Purple
  UCyan='\e[4;36m'        # Cyan
  UWhite='\e[4;37m'       # White

  # Background
  On_Black='\e[40m'       # Black
  On_Red='\e[41m'         # Red
  On_Green='\e[42m'       # Green
  On_Yellow='\e[43m'      # Yellow
  On_Blue='\e[44m'        # Blue
  On_Purple='\e[45m'      # Purple
  On_Cyan='\e[46m'        # Cyan
  On_White='\e[47m'       # White

  # High Intensity
  IBlack='\e[0;90m'       # Black
  IRed='\e[0;91m'         # Red
  IGreen='\e[0;92m'       # Green
  IYellow='\e[0;93m'      # Yellow
  IBlue='\e[0;94m'        # Blue
  IPurple='\e[0;95m'      # Purple
  ICyan='\e[0;96m'        # Cyan
  IWhite='\e[0;97m'       # White

  # Bold High Intensity
  BIBlack='\e[1;90m'      # Black
  BIRed='\e[1;91m'        # Red
  BIGreen='\e[1;92m'      # Green
  BIYellow='\e[1;93m'     # Yellow
  BIBlue='\e[1;94m'       # Blue
  BIPurple='\e[1;95m'     # Purple
  BICyan='\e[1;96m'       # Cyan
  BIWhite='\e[1;97m'      # White

  # High Intensity backgrounds
  On_IBlack='\e[0;100m'   # Black
  On_IRed='\e[0;101m'     # Red
  On_IGreen='\e[0;102m'   # Green
  On_IYellow='\e[0;103m'  # Yellow
  On_IBlue='\e[0;104m'    # Blue
  On_IPurple='\e[0;105m'  # Purple
  On_ICyan='\e[0;106m'    # Cyan
  On_IWhite='\e[0;107m'   # White
}


shell_ps1_advanced () {
  PS1_HOST_COLOR=${PS1_HOST_COLOR:-Green}

	# Define dynamic prompt variables (Fucking bashisms :-()
	local PS1_RETURN="\$(
		PS1_EXIT=\$?; 
		[[ \$PS1_EXIT == 0 ]] || {
			echo  \"\[$Red\]\${PS1_EXIT}\[${Color_Off}\] \"
		}
	)"
	
	local PS1_PATH="\$(
		if [ -s \"\${PWD}\" ] ; then
		#	PS1_DF=\$(command df -P \"\${PWD}\" | grep -E -o '[0-9]{1,3}%' | grep -E -o '[0-9]{1,3}');
			PS1_DF=\$(command timeout 1s df -P \"\${PWD}\" | awk 'END {print \$5} {sub(/%/,\"\")}');

			if [ \"\${PS1_DF:-0}\" -gt 95 ]; then
				PS1_PATH=\"\[$Red\]:\"
			elif [ \"\${PS1_DF:-0}\" -gt 90 ]; then
				PS1_PATH=\"\[$Yellow\]:\"
			else
				PS1_PATH=\"\[$White\]:\"
			fi
		else
			# Current directory is size '0' (like /proc, /sys etc).
			PS1_PATH=\"\[$Yellow\]:\";
		fi
		if [ -w \"\${PWD}\" ] ; then
			PS1_PATH=\"\${PS1_PATH}\[$Blue\]\w\"
		else
			# No 'write' privilege in the current directory.
			PS1_PATH=\"\${PS1_PATH}\[$Yellow\]\w\"
		fi

		echo -e \"\${PS1_PATH}\"
	)"

	# Get jobs
	local PS1_JOBS="\$(
		PS1_JOBS='';
		PS1_JOBS_RUNNING=\$(jobs -r | wc -l);
		PS1_JOBS_STOPPED=\$(jobs -s | wc -l);
		if [ \${PS1_JOBS_RUNNING} -gt 0 ] || [ \${PS1_JOBS_STOPPED} -gt 0 ]
		then
			if [ \${PS1_JOBS_RUNNING:-0} -gt 0 ]; then
				PS1_JOBS_RUNNING=\"\[$Green\]\${PS1_JOBS_RUNNING}\[$Color_Off\]\"
			else
				PS1_JOBS_RUNNING=''
			fi

			if [ \${PS1_JOBS_STOPPED:-0} -gt 0 ]; then
				PS1_JOBS_STOPPED=\"\[$Yellow\]\${PS1_JOBS_STOPPED}\[$Color_Off\]\"
			else
				PS1_JOBS_STOPPED=''
			fi
			PS1_JOBS=\"\${PS1_JOBS_RUNNING}:\${PS1_JOBS_STOPPED} \";
		else
			PS1_JOBS=''
		fi
		echo -e \"\${PS1_JOBS}\";
	)"

	# Time execution checker

	# Maximal time to consider prompt as slow in ms
	local PS1_MAX_EXEC_TIME=500
	# Number of time needed before swithing to basic prompt
	local PS1_MAX_TIME=3
	# Time windows to check
	local PS1_MAX_EXEC_DELAY=60
	# Time before reloading full PS1 after showing simple prompt
	local PS1_DELAY_RELOAD=300

	# Debug
#	local PS1_MAX_EXEC_TIME=5
#	local PS1_MAX_TIME=3
#	local PS1_MAX_EXEC_DELAY=60
#	local PS1_DELAY_RELOAD=30
	
	local PS1_TMP_FILE=/tmp/.load-$(whoami)
	chown $(whoami):$(whoami) ${PS1_TMP_FILE} 2>/dev/null
	local PS1_START="\$(
		if [ -f ${PS1_TMP_FILE} ] && [ \"\$(cat ${PS1_TMP_FILE} | grep -E -o '^reset')\" = \"reset\" ]
		then
			echo '\u@\h:\[\033[01;34m\]\w\[\033[00m\]\\$ '
			if [ \$((\$(date +%s) - \$(stat -c %Y ${PS1_TMP_FILE}) )) -gt ${PS1_DELAY_RELOAD} ]
			then
				echo -n \"Shell: full prompt reactivated.\n\"
				> ${PS1_TMP_FILE};
			fi
		else
			ts=\$(date +%s%N); 
			echo -e \""
	local PS1_STOP="\"; 
			tt=\$(((\$(date +%s%N) - \${ts})/1000000));
			if [ \${tt} -gt ${PS1_MAX_EXEC_TIME} ]
			then
				echo 1 >> ${PS1_TMP_FILE};
					if [ \$((\$(date +%s) - \$(stat -c %Y ${PS1_TMP_FILE}) )) -gt ${PS1_MAX_EXEC_DELAY} ] || [ \$(wc -l ${PS1_TMP_FILE} | grep -E -o '^[0-9]{1,3}') -gt ${PS1_MAX_TIME} ]
					then
						echo "reset" > ${PS1_TMP_FILE};
						echo -n \"Shell: prompt is taking more than ${PS1_MAX_EXEC_TIME}ms to anwser. Normal prompt will be reactivated in ${PS1_DELAY_RELOAD}s. Execute 'rm ${PS1_TMP_FILE}' to force.\n\" ;
					fi
			fi 
		fi
	)"

	# Define static prompt variables
	local PS1_ACOUNT="\[$White\]\\$ "
	local PS1_CHROOT_DEB="${debian_chroot:+($debian_chroot)}"

	# Set variable identifying the chroot you work in (used in the prompt below)
  local debian_chroot=
	if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	    debian_chroot=$(cat /etc/debian_chroot)
	fi
  # Define SCM prompt
  local PS1_SCM="$(modern_scm_prompt2)"

  # Define sudo detection
  local PS1_SUDO="\[$Color_Off\]@"
  if [ ! -z "${SUDO_USER-}" ]; then
    PS1_SUDO="\[$Cyan\]@\[$Color_Off\]"
  fi

	# Define prompt depending user
  local PS1_USER="\u"
	if [ $(id -u) -eq 0 ];
	then # you are root, make the prompt red
		# Are you root ?
		PS1_USER="\[$Yellow\]\u"
		# In green
    if [ -z "${SUDO_USER-}" ]; then
      PS1_SUDO="\[$Red\]@\[$Color_Off\]"
    fi
	elif [ -n "$(cat /etc/passwd  | grep $(whoami)  | grep -E -v ':/bin/(ba|z|t)?sh')" ]; then
		# The you are a no login user ...
		PS1_USER="\[$Red\]\u"
		# In red
	elif [ $(id -u) -lt 1000 ]; then
		# Are you a system user ?
		PS1_USER="\[$White\]\u"
		# In orange
	elif [ $(id -u) -ge 1000 ]; then
		# Are you a regular user ?
		PS1_USER="\[$Cyan\]\u"
		# In white
	fi

	# Detect serial connection (virtualisation, ttySx)
  local PS1_HOST="$PS1_SUDO\[${!PS1_HOST_COLOR}\]\h"
	if [ $(ps ax | grep $$ | awk '{ print $2 }' | grep 'ttyS.' | wc -l ) -gt 0 ]; then
		PS1_HOST="$PS1_SUDO\[$Red\]\h"
	fi

	# Set the prompt depending the shell
	if [ "${CURRENT_SHELL}" = "bash" ]; then
		#PS1="\[$Color_Off\]${PS1_RETURN}${PS1_START}${PS1_JOBS}${PS1_USER}${PS1_HOST}${PS1_PATH}${PS1_ACOUNT}\[$Color_Off\]${PS1_STOP}"
		#PS1="\[$Color_Off\]${PS1_RETURN}${PS1_START}${PS1_JOBS}${PS1_USER}${PS1_HOST}${PS1_PATH}\[$Color_Off\]$(modern_scm_prompt2)${PS1_ACOUNT}\[$Color_Off\]${PS1_STOP}"
		PS1="\[$Color_Off\]${PS1_RETURN}${PS1_START}${PS1_JOBS}${PS1_USER}${PS1_HOST}${PS1_PATH}${PS1_SCM}${PS1_ACOUNT}\[$Color_Off\]${PS1_STOP}"
	elif [ "${CURRENT_SHELL}" = "dash" ] ; then
		PS1='$USER@$HOSTNAME:$PWD\$ '
	else
		PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	fi
}


###############################

function _omb_theme_PROMPT_COMMAND {

  case $(readlink -f $SHELL) in
    */zsh)·
      CURRENT_SHELL="zsh"
      ;;
    */bash)
      CURRENT_SHELL="bash";
      ;;
    */dash)
      CURRENT_SHELL="dash";
      ;;
    *)
      # assume something else
      CURRENT_SHELL="none"
  esac
  

  shell_global_color
  shell_ps1_advanced
}


_omb_util_add_prompt_command _omb_theme_PROMPT_COMMAND
