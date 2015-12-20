#!/usr/bin/env bash

pyenv_setup() {


#This is here because pip was not available by default until 2.7.9+
#many systems still use older versions of python
if [ $os = 'linux' ]; then
which pip &>/dev/null
	if [ $? != 0 ]; then
		echo "Cannot detect PIP installed; pyenv will not be fully functional."
		echo "install pip [y/n]: "
		read confirm 
		case $confirm in
		y|Y)
			sudo get-pip.py
			;;
		esac
	fi
fi

pyenv="$HOME/.pyenv"
if [ ! -d $pyenv ]; then
	git clone https://github.com/yyuu/pyenv.git $pyenv
else
	echo "not replacing current $pyenv with fresh git copy"
fi

pyenvvenv="$HOME/.pyenv/plugins/pyenv-virtualenv"
if [ ! -d $pyenvvenv ]; then
	git clone https://github.com/yyuu/pyenv-virtualenv.git $pyenvvenv 
else
	echo "not replacing current $pyenvvenv with fresh git copy"
fi


if [[ -z `cat $bashprofile | grep 'export PATH="$HOME/.pyenv/bin:$PATH'` ]]; then
	echo "inserting rbenv path to front of PATH env var into $bashprofile"
	echo '#rbenv requires knoweldge of installed path location' >> $bashprofile
	echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> $bashprofile
fi

if [[ -z `cat $bashprofile | grep 'eval "$(pyenv init -)"'` ]]; then
	echo "inserting eval rbenv init - to get command expansion into $bashprofile"
	echo '#rbenv evaluate profile for cmd expansion' >> $bashprofile
	echo 'eval "$(pyenv init -)"' >> $bashprofile
fi
}

rbenv_setup() {
#rubymine does not work if rbenv home is not default yet
#https://www.jetbrains.com/ruby/help/rbenv-support.html

#retreive rbenv
if [ $os = 'linux' ]; then
	sudo yum -y install rubygems
fi
#let the user install at the rbenv lvl
#sudo gem install bundler -v 1.10.6

rbenv="$HOME/.rbenv"
if [ ! -d $rbenv ]; then
	git clone https://github.com/sstephenson/rbenv.git $rbenv
else
	echo "not replacing current $rbenv with fresh git copy"
fi
	
rbbuild="$HOME/.rbenv/plugins/ruby-build"
if [ ! -d $rbbuild ]; then
	git clone https://github.com/sstephenson/ruby-build.git $rbbuild
else
	echo "not replacing current $rbbuild with fresh git copy"
fi

rbgemset="$HOME/.rbenv/plugins/rbenv-gemset"
if [ ! -d $rbgemset ]; then
	git clone https://github.com/jf/rbenv-gemset.git  $rbgemset
else
	echo "not replacing current $rbbuild with fresh git copy"
fi

if [[ -z `cat $bashprofile | grep 'export PATH="$HOME/.rbenv/bin:$PATH'` ]]; then
	echo "inserting rbenv path to front of PATH env var into $bashprofile"
	echo '#rbenv requires knoweldge of installed path location' >> $bashprofile
	echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $bashprofile
fi

if [[ -z `cat $bashprofile | grep 'eval "$(rbenv init -)"'` ]]; then
	echo "inserting eval rbenv init - to get command expansion into $bashprofile"
	echo '#rbenv evaluate profile for cmd expansion' >> $bashprofile
	echo 'eval "$(rbenv init -)"' >> $bashprofile
fi
}

preflight_check() {
#pre-requisites

if [ ! -f $bashprofile ]; then
	echo "cannot find $bashprofile"
	exit
fi

#suports osx
if [  $os = 'darwin' ]; then

	#ensure xcode is installed
	if [ ! -f /usr/bin/xcode-select ]; then
		echo "install xcode then run xcode-select --install"
		exit
	fi

	#ensure brew is installed
	if [ ! -f /usr/local/bin/brew ]; then
		echo "install brew"
		echo "http://brew.sh/"
		echo 'install brew by typing --> ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
		exit
	fi

	brew install openssl libyaml libffi
	brew tap homebrew/dupes && brew install apple-gcc42

fi

}

post_check () {
echo; echo "source profile is last step"
echo "#source $bashprofile"
}

set_os () {
os=`uname -s | tr '[:upper:]' '[:lower:]'`
}


#start
bashprofile="$HOME/.bash_profile"
set_os
preflight_check
pyenv_setup
rbenv_setup
post_check

