# emacs
Emacs configuration files. Currently this requires emacs 25.1. On Ubuntu 16.04 (Xenial) You can install this as follows:

```
sudo apt-add-repository -y ppa:adrozdoff/emacs
sudo apt update
sudo apt install emacs25
```

## Setup

* Navigate to git_tree: `cd ~/git_tree`
* Clone down repo: `git clone git@github.com:ojsquire/emacs.git`
* Set up symoblic link to `init.el`: `ln -s ~/git_tree/emacs/init.el ~/.emacs.d/init.el`

## Python linting
To get linting working nicely, you will need to install these Python packages, which are picked up by emacs by the `pychecker.sh` script:

```
pip3 install pyflakes
pip3 install pep8
```

## Jedi
To get jedi to work, you first need to install the following python packages:

* virtualenv
* jedi
* epc

Then it should install just fine.
