#os is linux or sunos
os=`uname -s | awk '{print tolower($0)}'`
hostf=`hostname |awk -F- '{print$2}' | sed 's/[0-9]*//g'`
instance=`hostname | awk -F- '{print$1}'`
site=`hostname | awk -F- '{print$4}' | awk -F. '{print$1}'`

#env to unbind locking
export env LOCKPRG=/tmp

#screen -t Main
alias ll='ls -lF'

if [ `which vim` ]; then
	alias vi='vim'
fi

alias inv='/home/sfdc/current/dca-inventory-action/dca-inventory-action/inventory-action.pl'
alias pyinstall='sudo yum -y install autopods-python27-2.7.5-2.x86_64'
alias naguser='cat /etc/nagios/resource.cfg|grep USER | grep -v ^#'
alias svns="svn status"
alias svnsn="svn status --no-ignore"

alias godb='ssh ${instance}-dbmgt1-1-${site}.ops.sfdc.net'
alias gomc='ssh ${instance}-mcnc1-1-${site}.ops.sfdc.net'
alias gorel='ssh ${instance}-release1-1-${site}.ops.sfdc.net'

if [ $site ]; then
	if  [ $site == 'dfw' ] || [ $site == 'phx' ] || [ $site == 'frf' ] || [ $site == 'lon' ]; then 
		alias gonet='ssh ${instance}-netmgt1-1-${site}.ops.sfdc.net'
		alias goorc='ssh ops0-orch1-1-${site}.ops.sfdc.net'
		alias goinst='ssh ops0-inst1-1-${site}.ops.sfdc.net'
		alias goppm='ssh ops0-ppm1-1-${site}.ops.sfdc.net'
		alias gomon='ssh ops0-monitor1-1-${site}.ops.sfdc.net'
	else
		alias gonet='ssh ${instance}-netmgt3-1-${site}.ops.sfdc.net'
		alias goorc='ssh ${instance}-orch1-1-${site}.ops.sfdc.net'
		alias goinst='ssh ${instance}-inst1-1-${site}.ops.sfdc.net'
		alias goppm='ssh ops0-ppm1-1-${site}.ops.sfdc.net'
		alias gomon='ssh ops0-ppm1-1-${site}.ops.sfdc.net'
	fi
fi

 
alias diga='dig any +noall +answer'
alias cdzone='cd /home/jho/subversion/dns/auth/bind/zones'
alias cddhcp3='cd /home/jho/subversion/jumpstart/dhcp3'
alias cdks='cd /home/jho/subversion/jumpstart/kickstart'
alias workonans='export PYTHONPATH=usr/lib/python2.6/site-packages'
#SVN config locations no tools
#jump
alias svn_up_jump='         svn co https://vc-commit/subversion/jumpstart ~/subversion/jumpstart/'
alias svn_up_dhcp='         svn co https://vc-commit/subversion/jumpstart/dhcp3 /home/jho/subversion/jumpstart/dhcp3'
alias svn_up_common='       svn co https://vc-commit/subversion/jumpstart/common ~/subversion/jumpstart/common/'
alias svn_up_ks='           svn co https://vc-commit/subversion/jumpstart/kickstart /home/jho/subversion/jumpstart/kickstart'
alias svn_up_zones='        svn co https://vc-commit/subversion/dns/auth/bind/zones /home/jho/subversion/dns/auth/bind/zones'
alias svn_up_nagios='       svn co https://vc-commit/subversion/monitoring/nagios/ ~/subversion/monitoring/nagios/'

set -o ignoreeof

PATH=$PATH:$HOME/stuff-svn/personal:$HOME/stuff-svn/go:$HOME/stuff-svn:$HOME/stuff-svn/misc:/bin:/sbin:/usr/sbin:/usr/local/sbin:/opt/bin:$HOME/codebin/capacity/podsible/usr/bin:$HOME/Documents/Dropbox/sfdc/quick_scripts/
TERM=xterm
export EDITOR=vi


cp /dev/null ~/.ssh/config

if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
fi

if [ ! -d ~/.vim ]; then
    mkdir ~/.vim
fi

echo "Host *" >> ~/.ssh/config
echo "StrictHostKeyChecking no" >> ~/.ssh/config

txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

os_type=`uname -s`
#PS1="\n\\u@\\h:\w ? "
#PS1="[$os_type $bldpur\u $bldred\h \[\e[m\] $bldylw\w $txtrst]\n$bldwht>>> $txtrst" 


if [ $hostf ]; then
	if [ $hostf == 'bastion' ]; then
		PS1="[$os_type $bldpur\u $bldred\h \[\e[m\] $bldylw\w $txtrst]\n: " 

	elif [[ $hostf == 'release' || $hostf == 'orch' ]]; then
		PS1="[$os_type $bldpur\u $bldgrn\h \[\e[m\] $bldylw\w $txtrst]\n: " 

	elif [ $hostf == 'inst' ]; then
		PS1="[$os_type $bldpur\u $bldcyan\h \[\e[m\] $bldylw\w $txtrst]\n: " 

	elif [[ $hostf == 'mcnc' ]]; then
		PS1="[$os_type $bldpur\u $bldylw\h \[\e[m\] $bldylw\w $txtrst]\n: " 

	elif [ $hostf == 'netmgt' ]; then
		PS1="[$os_type $bldpur\u $bldwht\h \[\e[m\] $bldylw\w $txtrst]\n: " 

	else  #default
		PS1="[$os_type $bldpur\u $txtwht\h \[\e[m\] $bldylw\w $txtrst]\n: " 
	fi
fi

alias dm='docker-machine'
alias vag='vagrant global-status'
alias cdgh="cd $HOME/Documents/Dropbox/GITHUB/"
export re="$HOME/.rbenv/versions"
export pe="$HOME/.pyenv/versions"

#rbenv requires knoweldge of installed path location
export PATH="$HOME/.pyenv/bin:$PATH"
#rbenv evaluate profile for cmd expansion
eval "$(pyenv init -)"
#rbenv requires knoweldge of installed path location
export PATH="$HOME/.rbenv/bin:$PATH"
#rbenv evaluate profile for cmd expansion
eval "$(rbenv init -)"
