# Nate Cavanaugh

This repository inclues my dotfiles for unix enviroments

# Install

To install, you can copy and paste this line into your terminal and press enter:

	git clone git://github.com:natecavanaugh/dotfiles.git && ./dotfiles/install.sh

Once that's done, you can type `source ~/.bash_profile` or just close and reopen the terminal window, and it will kick into effect.

## Details
The install script loops over the files/dirs in the dotfiles directory and creates a symlink in your `$HOME` directory to a file with a dot in front of it eg. if you have `bash_profile` in the dotfiles directory, it will become `.bash_profile`.

### Protecting your privacy
If you have a file that ends with "_private" this will be used in addition to the "public" form of the file, and they'll be merged together into a file with "_build" at the end.
So, with the following files:
gitconfig
gitconfig_private

`install.sh` will create a `gitconfig_build` that combines both files, and the symlink in your home directory will be linked to the build file, something like this:
`~/.gitconfig -> dotfiles/gitconfig_build`.
Any files with "_build" or "_private" at the end of the name are part of the .gitignore file, so you don't need to worry about committing them.

The purpose of this is to be able to share parts of files, but without exposing either sensitive or non-essential pieces of these files.

Also, to keep a set of scripts from being shared, you can create a bin_private in your $HOME directory and place them in there (this directory, if it exists is added to the $PATH).

### Install options
You can pass a couple of options to the install script to suit your needs. Run `./install.sh -h` to see what they are.