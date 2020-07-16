# Emacs
In this repo you will find my Emacs configuration files.

# Prerequisits
Since I primarily develop in Python, there are several packages in `init.el` that require Python packages to be installed. So first, I will go through my preferred way to set up Python on a machine. Then we will go through the Emacs installation.

## Python
There are some packages in `init.el` that depend on certain Python packages being installed (e.g. Jedi). This brings us onto the wider topic of setting up Python properly. One potential source of problems with Python is the presence of different versions. This can lead to issues like packages being installed in the wrong version and not in the one you want. The simplest way to deal with this is to use [`pyenv`](https://github.com/pyenv/pyenv). Let's set this up before starting up emacs.

### pyenv
#### On Ubuntu
* Install Python build dependencies:
```
sudo apt-get update
sudo apt-get install --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
```

* Install pyenv
1. Run these commands:
```
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc
```
2. Now restart your shell
3. Install the version of Python you want to use, e.g. `pyenv install 3.8.3`
4. We can now set this as the global Python version to use on our machine: `pyenv global 3.8.3`

### virtualenv
It is a good idea at this point to set up a way to manage Python virtual environments, since you don't want to have to install all packages needed for all projects globally; this could end up with package conflicts and messy dependencies. Also it may be that you need to use different versions of Python for different projects. To solve this we will use `virtualenv`. Note: Python now comes bundled with `venv` for this purpose, but it is not as powerful as `virtualenv`, e.g. it does not support use of multiple Python versions, therefore we will use `virtualenv` instead.

Now you have set up your version of Python with `pyenv` we can install `virtualenv` with `pip`. If you run `pip --version` you should see that the Python version is that set by `pyenv`. Before installing `virtualenv` let's make sure `pip` is at the latest version:

```
pip install --upgrade pip
```

Now we can install `virtualenv`:

```
pip install virtualenv
```

We will come back to how to use this at the end. For now we will stay in the global environment, since we should install the Python packages that Emacs will use there.

### Python packages required by Emacs setup
#### Jedi
In addition to `virtualenv` (install if haven't already), you also need to install `jedi` and `epc`:

```
pip install jedi epc
```

#### Linting
To get linting working nicely, you will need to install these Python packages, which are picked up by emacs by the `pychecker.sh` script (not currently used):

```
pip install pyflakes
pip install pep8
```

# Installation
To install the latest version of Emacs (26.3) do the following:

## Remove older emacs versions (optional)
On Ubuntu 18.04 (Bionic), first uninstall any older versions of Emacs:
`sudo apt-get remove emacs`

If that returns "Package 'emacs' is not installed, so not removed", try:
`sudo apt-get remove emacs25`

## Install emacs26
To get emacs26 follow [these instructions](http://ubuntuhandbook.org/index.php/2019/02/install-gnu-emacs-26-1-ubuntu-18-04-16-04-18-10/):

```
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt update
sudo apt install emacs26
```

# Setup

* Navigate to git_tree: `cd ~/git_tree`
* Clone down repo: `git clone git@github.com:ojsquire/emacs.git`
* Set up symoblic link to `init.el`: `ln -s ~/git_tree/emacs/init.el ~/.emacs.d/init.el`
