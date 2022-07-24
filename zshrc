alias diff='diff -u --color'
alias ed='ed -p"eddie > "'
alias irc='ssh irc'
alias info='info --vi-keys'
alias ls='ls --color=auto -A'
alias sc='grim -g "$(slurp)"'
alias updgpgtty='gpg-connect-agent updatestartuptty /bye'
alias vi='vim'

bindkey -v
PROMPT='%B%F{cyan}%n%f%F{green}@%f%m%b - %B%F{blue}%~%f%b %# > '

export MOZ_ENABLE_WAYLAND=1
export PATH="$PATH:/opt/bin"
export EDITOR='vim'

dsleep(){
	if pgrep Xorg &>/dev/null; then
		sleep 1;xset dpms force off
	else
                sleep 1;pkill -USR1 swayidle
	fi
}
emulate ksh -c 'powerstat()
{
	for bat in /sys/class/power_supply/BAT*;do
		if [ $bat = "/sys/class/power_supply/BAT*" ];then
			printf "No batteries found!\nACPI error?\n"
			return
		fi
		printf "$(basename $bat)"
		grep -q "Charging" $bat/status && printf "(Charging)"
		printf ":\n"
		cat $bat/capacity
	done
}'
tm(){
	[ ! $# = "0" ] &&  { tmux "$@"; return $? }
	tmux a &>/dev/null || tmux
}
wgq(){
        setopt -x
	local _DEFAULT="wg-cipvpn"
	[[ -z $1 || ! $1 =~ "(up|down)" ]] && return 1
	[[ -n $2  && $2 = "full" ]] && _DEFAULT="$_DEFAULT-full"
        doas wg-quick $1 $_DEFAULT
        setopt +x
}
starttmux() {
	[[ -z $TMUX ]] || return 0
	printf "Start tmux? [y/N]\n"
	# read -e is a zsh extension
	if [[ $(read -e) =~ "^Y|y([[:space:]])*$" ]]; then
		tm
	fi
}
#Tmuxify and make way for transient sessions
_setsocket() {
	[[ $1 = "sway" ]] &&
	for _SWAYSOCKET in /run/user/$(id -u)/sway-ipc*;do
		export SWAYSOCK=$_SWAYSOCKET
		export I3SOCK=$_SWAYSOCKET
		return
	done
	[[ $1 = "i3" ]] &&
	for _SWAYSOCKET in /run/user/$(id -u)/i3/ipc-socket.*;do
		export I3SOCK=$_SWAYSOCKET
		return
	done
	printf "Usage:\n$0 sway|i3\n"
}

gpg-agent --daemon &> /dev/null
unset SSH_AGENT_PID
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
printf "Attempto!\n"
starttmux
return 0
