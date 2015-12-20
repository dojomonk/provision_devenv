Tips and tricks before moving forward
-
* When you see [working_path]; I work in a git repo where the Vagrantfile resides; this path is also where the Vagrant VM mounts /vagrant as a share.  I do all my work from /vagrant and this greatly simplifies getting code in and out much faster via GIT, but the choice is up to you.

Operating system isolation with VAGRANT / (Docker in future)
---------------
##### * Skip to next section if not interested in OS isolation
 
#####Requirements - tested on following versions
install virtualbox 4.3.14 ( http://download.virtualbox.org/virtualbox/ )

install vagrant 1.6.3 (https://www.vagrantup.com)

After installing vagrant install vagrant-vbguest

    vagrant plugin install vagrant-vbguest

If you already have box skip adding same box

    vagrant box add https://atlas.hashicorp.com/bento/boxes/centos-6.7

else    

    cd [working_path]
    git clone https://github.com/legoblocks/py_ruby_isoenv_scripts.git 
    mv py_ruby_isoenv_scripts provision; rm -rf provision/.git; cp provision/Vagrantfile .
    
#####File you may want to edit prior to running vagrant up (to build enviroment)

* Vagrantfile - common settings for building and setting host values

VagrantFile configs | Default settings| notes
------------|--------|----------
config.vm.box = | bento/centos-6.7 | edit for your Vagrant Box
config-vm.provision | :shell, :path => "provision/provision.sh" | edit for your provisioning needs
config.vm.hostname = | "defaultname" | hostname set on Vagrant server
config.vm.network | "private_network", ip: "10.0.0.10" | by default commented out

*  provision/dev_env_postsetup.sh - installs rbenv/pyenv versions

language | default versions | notes
------------|--------|----------
ruby | 2.1.2 | to change, edit line 'for rbenv_ver in 2.1.2; do'
python | 2.6.6 & 2.7.10 | to change, edit line 'for pyenv_ver in 2.6.6 2.7.10; do'

    cd [working_path]
    vagrant up

Language isolation
-
#####* If going through my Vagrant workflow skip this portion as it is called as Vagrant builds 
#####* This portion is Vagrant independent and supports my OSX Yosemite and Linux
-
* Common
 * will clone git repos to $HOME/.rbenv and $HOME/.pyenv
 * will pre-append those paths to PATH env in .bash_profile  (change this to whatever shell profile you like)

* OSX specific
 * attempts to install brew
 * check if xcode is installed and ask user to install if not available
 * brew install openssl libyaml libffi apple-gcc2

* Linux specific
 * Look for pip and if not exist install via get-pip.py
 * install rubygems via yum

#####Setup dev Enviroment 

    git clone https://github.com/legoblocks/py_ruby_isoenv_scripts
    cd py_ruby_isoenv_scripts
    ./dev_env_setup.sh
    source .bash_profile

#####Install your language versions 

    rbenv install x.x.x || version --list (by default installs to ~/.rbenv/versions)
    pyenv install x.x.x || version --list (by default installs to ~/.pyenv/versions)
 
Package isolation
-
#####Ruby  (https://github.com/jf/rbenv-gemset) - please note rbenv-gemset already installed
    
    cd [working_path]
    echo './gems' > .rbenv-gemsets

#####Python (https://github.com/yyuu/pyenv-virtualenv) - please note that pyenv-virtualenv already installed

create isolated package requires installed language version arg follow by name of your package instance
    
    pyenv virtualenv 2.6.6 [my_projects_required_packages]

By changing to project directory then executing pyenv local;  this effectively redirects python to version 2.6.6 and package 'my_projects_required_packages' within this directory

    cd [working_path]
    pyenv local [version] [project]
 
Package management
-

#####Ruby gemsets & Bundler

Install same bundler version across all env

    gem install bundler -v 1.10.6

You can install gems from a given Gemfile
    
    bundle install 
    
Create Gemfile template (to manually add gems in)

    bundle init

to create Gemfile.lock file; which is generated from Gemfile

    bundle lock

#####Python PIP 

Install list of packages from source file

    pip install -r [file_of_packages_to_install]

Create package list from currently installed packages

    pip freeze > [filename]


####BUG####
-
Quick fix - https://github.com/mitchellh/vagrant/issues/3341

vagrant plugin install vagrant-vbguest

Long fix

Problem trying to resolve;  if vagrant box is not powered down properly sometimes mount.vboxsf is not found. This causes vagrant vm to come up without the /vagrant mount.  below is the message vagrant presents to the user...

 Failed to mount folders in Linux guest. This is usually because
 the "vboxsf" file system is not available. Please verify that
 the guest additions are properly installed in the guest and
 can work properly. The command attempted was:

 mount -t vboxsf -o uid=`id -u vagrant`,gid=`getent group vagrant | cut -d: -f3` vagrant /vagrant

 mount -t vboxsf -o uid=`id -u vagrant`,gid=`id -g vagrant` vagrant /vagrant

 The error output from the last command was:

 /sbin/mount.vboxsf: mounting failed with the error: No such device

Fix:  Power down VM, then from  Virtualbox APP select the VM
* Select 'settings' -> 'storage'
* add optical drive and choose Virtualbox guestadditions ISO
* vagrant up server (or interact directly from virtualbox)
* vagrant ssh default (or interact directly from virtualbox)
* sudo mount -t iso9660 /dev/cdrom1 /media/; sudo /media/VBoxLinuxAdditions.run 
* exit vagrant instance
* vagrant up (vagrant should come up with /vagrant mounted)

####NOTES

My Vagrant structure tree
* $HOME/.vagrant -> location of vagrant boxes 
* $HOME/[path_vagrantprojects] -> where created box configs resides
* $HOME/VirtualBox -> location of virtual box VMs 

