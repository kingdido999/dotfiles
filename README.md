# dotfiles

This repository stores all my software configurations, each placed in its own directory. They can be synced among different machines using [stow](https://www.gnu.org/software/stow/manual/stow.html#Invoking-Stow), the symlink farm manager.

## Prerequisite

- Install [stow](https://www.gnu.org/software/stow/).

## Sync

``` sh
stow <package> ...
```

## Unsync

``` sh
stow -D <package> ...
```

