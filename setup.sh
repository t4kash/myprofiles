#!/bin/sh

spath=$(cd $(dirname $0);pwd)
cd ~

ln -s ${spath}/vimrc .vimrc
ln -s ${spath}/vimshrc .vimshrc
ln -s ${spath}/gvimrc .gvimrc
ln -s ${spath}/zlogin .zlogin
ln -s ${spath}/zshrc .zshrc

if [ -d /Applications/MacVim.app/Contents/Resources/vim ]; then
    cd /Applications/MacVim.app/Contents/Resources/vim
    ln -s ${spath}/vimrc_local.vim
    ln -s ${spath}/gvimrc_local.vim
fi

