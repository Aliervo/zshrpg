# ZshRPG

[![ISC License](https://img.shields.io/badge/license-ISC-green.svg)](/LICENSE)

> A wrapper that fully integrates
> [rpg-cli](https://github.com/facundoolano/rpg-cli) with zsh!

`rpg-cli` turns your filesystem into a dungeon crawling RPG, zshrpg integrates
it into your shell so you can play while you go about your normal zsh tasks.

## Installation
```zsh
# clone the repo
git clone https://github.com/aliervo/zshrpg ~/.config/zsh/plugins/zshrpg

# source zshrpg in your .zshrc
source ~/.config/zsh/plugins/zshrpg/rpg.plugin.zsh
```

Or install with your favorite plugin manager.

The script will use `rpg-cli` if it is in your $PATH, or it will download it
for you! (linux only for now)

## Usage

zshrpg wraps the rpg-cli program in the `rpg` function, saving you four
keystrokes for anything you can do with `rpg-cli`. Additionally, it overrides
`cd` with a version that plays the game while you move around your filesystem.
If your hero encounters an enemy en route, you will be placed in that folder to
see the fight, or you'll be sent back home if your hero should fall.  If this
behavior is undesirable (sometimes the work just *has* to get done), a
`teleport` command has been provided to jump you to a folder without the chance
of encounters along the way. Finally, a `dgn` command that let's your hero
generate and explore new dungeons in your current directory has been provided
to allow you to quickly and easily descend in search of treasure and monsters.

