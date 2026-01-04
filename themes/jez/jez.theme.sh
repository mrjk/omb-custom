# Full function wrapper
shell_ps1 () {
	shell_ps1_advanced
	#shell_ps1_simple
}

# PS1 shell reset (in case of emergency)
shell_ps1_simple () {
	PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	#PS1='$USER@$(hostname):$PWD\$ '
}

# Full function
shell_ps1_advanced () {
  PS1_HOST_COLOR=${PS1_HOST_COLOR:-Green}

	# Define dynamic prompt variables (Fucking bashisms :-()
	local PS1_RETURN="\$(
		PS1_EXIT=\$?; 
		[[ \$PS1_EXIT == 0 ]] ||  echo -n \"\[$Red\]\${PS1_EXIT}\[${Color_Off}\] \"
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
		PS1="\[$Color_Off\]${PS1_RETURN}${PS1_START}${PS1_JOBS}${PS1_USER}${PS1_HOST}${PS1_PATH}${PS1_ACOUNT}\[$Color_Off\]${PS1_STOP}"
	elif [ "${CURRENT_SHELL}" = "dash" ] ; then
		PS1='$USER@$HOSTNAME:$PWD\$ '
	else
		PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	fi
}


shell_ps1_advanced
