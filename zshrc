alias dsleep='sleep 1;xset dpms force off'
alias sc='grim -g "$(slurp)"'
alias irc='ssh irc'
alias diff='diff -u --color'
alias ls='ls --color=auto -A'
alias updgpgtty='gpg-connect-agent updatestartuptty /bye'
alias vi='vim'

PROMPT='%B%F{cyan}%n%f%F{green}@%f%m%b - %B%F{blue}%~%f%b %# > '
# Emulate bash
emulate ksh
export MOZ_ENABLE_WAYLAND=1
export PATH="$PATH:/opt/bin"
powerstat()
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
}
tm(){
	[ $# = "1" ] &&  { tmux $1; return $? }
	tmux a &>/dev/null || tmux
}
wgq(){
	local _DEFAULT="wg-cipvpn"
	[[ -z $1 || ! $1 =~ "(up|down)" ]] && return 1
	[[ -n $2  && $2 = "full" ]] && _DEFAULT="$_DEFAULT-full"
	wg-quick $1 $_DEFAULT
}
starttmux() {
	[[ -z $TMUX ]] || return 0
	printf "Start tmux? [y/N]\n"
	# read -e is a zsh extension
	if [[ $(read -e) =~ "^Y|y([[:space:]])*$" ]]; then
		tm
	fi
}

gpg-agent --daemon
unset SSH_AGENT_PID
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
emulate zsh
export LANG=fr_FR.utf8
export LC_TIME=fr_FR.UTF8
export EDITOR='vim'
. /usr/share/fzf/completion.zsh
. /usr/share/fzf/key-bindings.zsh
starttmux
return 0
