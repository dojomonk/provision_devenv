Tips and tricks before moving forward
-
* When you see [working_path]; I work in a git repo where the Vagrantfile resides; this path is also where the Vagrant VM mounts /vagrant as a share.  I do all my work from /vagrant and this greatly simplifies getting code in and out much faster via GIT, but the choice is up to you.


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

    git clone https://github.com/legoblocks/provision_devenv.git
    cd [clone_repo]

*  edit dev_env_postsetup.sh to change, add versions

language | default versions | notes
------------|--------|----------
ruby | 2.1.2 | to change, edit line 'for rbenv_ver in 2.1.2; do'
python | 2.6.6 & 2.7.10 | to change, edit line 'for pyenv_ver in 2.6.6 2.7.10; do'


    ./dev_env_setup.sh
    ./dev_env_postsetup.sh
    source .bash_profile

##### OR Manually install your language versions 

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


