# emacs
Emacs configuration files.

## Installation
To install the latest version of Emacs (26.3) do the following:

### Remove older emacs versions (optional)
On Ubuntu 18.04 (Bionic), first uninstall any older versions of Emacs:
`sudo apt-get remove emacs`

If that returns "Package 'emacs' is not installed, so not removed", try:
`sudo apt-get remove emacs25`

### Install emacs26
To get emacs26 follow [these instructions](http://ubuntuhandbook.org/index.php/2019/02/install-gnu-emacs-26-1-ubuntu-18-04-16-04-18-10/):

```
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt update
sudo apt install emacs26
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
