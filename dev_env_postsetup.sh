#!/usr/bin/env bash

rb_env () {
	num=0
	rbenv_exec="$HOME/.rbenv/bin/rbenv"

	#add version for more language versions aka.. x.x.x x.x.x; do ...
	for rbenv_ver in 2.1.2; do  
		for ver in $rbenv_ver; do
			if [ ! `$rbenv_exec versions|egrep "($ver\d*$)"` ]; then
				$rbenv_exec install $rbenv_ver 
			else
				echo "rbenv ruby $ver is already installed"
			fi			
		done
		num=$(($num+1))
	done

}

py_env () {
	num=0
	pyenv_exec="$HOME/.pyenv/bin/pyenv"

	#add version for more language versions aka.. x.x.x x.x.x; do ...
	for pyenv_ver in 2.6.6 2.7.10; do  
		for ver in $pyenv_ver; do
			if [ ! `$pyenv_exec versions|egrep "($ver\d*$)"` ]; then
				PYTHON_CONFIGURE_OPTS="--enable-unicode=ucs4" $pyenv_exec  install $pyenv_ver 
			else
				echo "pyenv python $ver is already installed"
			fi			
		done
		num=$(($num+1))
	done
}

rb_env
py_env
