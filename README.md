# Vi IMproved Configuration

This repository includes my personal configurations for `vim`.

## Requirements

By default, this is a macOS-centric setup. These are the expectations:

- `ctags` is installed (easily done via [Homebrew](https://brew.sh)), and accessible via the user's `$PATH`.
- The font [Input Mono](https://input.djr.com), patched with [Nerd Fonts](https://www.nerdfonts.com/), is installed in the system.

## Setup

Once cloned, it is necessary to initialize the submodules:

    git submodule update --init --recursive

Furthermore, the configuration files are meant to be symlinked in the home dir:

    cd
    ln -s ./path/to/config-vim/vimrc .vimrc
    ln -s ./path/to/config-vim/vim .vim

## Neovim

A basic Neovim configuration has been added for compatibility and testing of exclusive features and plugins. It still depends fully on the `.vimrc` in this repo.

To activate:

    cd
    ln -s ./path/to/config-vim/nvim ~/.config/
    nvim --headless +Lazy! sync +qa
