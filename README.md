# Emacs
In this repo you will find my Emacs configuration files.

# Prerequisites
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
pip install pyflakes pep8
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
* Now, if everything above has been done, opening `emacs` for the first time should install all the packages successfully. To do this simply run `emacs` on the terminal.

## Starting a Python virtual environment
For development of Python projects for the reasons listed above it makes sense to always develop in a Python virtual environment. This is something you should set up as soon as you start developing.

### Add virtualenv dir to `.gitignore`
When you do this, it will create a directory in your git repo (assuming you are using git) with hundred of files in it (essentially all the packages you need installed). You don't want this in git (!), so make sure you add this dir to your `.gitignore` file (normally I call this dir `.venv` so I add `.venv` to my `.gitignore`).

### Finding the Python version
When we create the environment, we can specify the version of Python it should use. For this we need to find the path were the version we want is installed. With `pyenv` you can find the path by running `pyenv which python`. Note: this will run it for the current active version of Python. If you want the path of a different version you must first switch to that version (e.g. with `pyenv global <PYTHON VERSION>`). Example output is: `~/.pyenv/versions/3.8.3/bin/python`

### Creating the virtual environment
Now, to create the new virtual environment with this version of Python, navigate to the root directory of you project (git repo) and run:
```
virtualenv --python=/path/to/python/version .venv
```

This creates your virtual environment in a directory called `.venv`. Calling the dir you want your virtual environment to live `.venv` is a convention, but you can call it anything.

### Activating the virtual environment
You are not yet using your virtual env. You must first activate it. To do so run:
```
source .venv/bin/activate
```

If this works you should see your command prompt change to the name `(.venv)`. Now when you install any Python packages they will _only_ be installed in your virtual env and only be available to this project. Make sure to deactivate your env when you are not working on this project with `deactivate`, and make sure to reactivate you virtual env again when you start working on the project again with the `source` command as above!

### Installing Python libs in virtual environment
Since your virtual env points to a clean Python installation, you will need to install all of the previous packages into this environment before using emacs:

```
pip install --upgrade pip
pip install virtualenv epc jedi pyflakes pep8
```

### Installing environment from another config
If you have already created a virtualenv on another machine, or the repo you are cloning already has one specified in a `requirements.txt`, you can run the following instead:

```
virtualenv --python=/path/to/python/version .venv
source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
```

This will ensure all the same modules are installed as required by the software. If you want to create a `requirements.txt` to be used to "save" your virtual environment without commiting it to git, you can run (from root dir):

```
pip freeze > requirements.txt
```
