dotfiles
========

Installation
------------

```
cd ~
git clone https://github.com/kevinhughes27/dotfiles
cd dotfiles
./install.sh
```

Afterwards I need to update the remote to use ssh: `git remote set-url origin git@github.com:kevinhughes27/dotfiles`


.localrc
--------

My setup will read a `.localrc` for any system specific settings. This lets me maintain one set of common dotfiles while still having flexability. It is pretty common for programs to manually add config to your dotfiles and when that happens I will see the changes and git and usually move the new code to localrc. 

Here is an example of what I have for my OSX machine which has some specific settings for work:

```
export GOPATH="$HOME/clio/Go"
export PATH="$GOPATH/bin:$PATH"

source $HOME/.clio_profile
```


References
----------

I've been collecting bits and pieces for a while and unfortunately I haven't always done a great job of keeping track of references so I can't effectively credit all those deserving. Big thanks to everyone whose ever written about or shared their dotfiles!

* https://github.com/ohmyzsh/ohmyzsh
* https://thoughtbot.com/blog/powerful-git-macros-for-automating-everyday-workflows
