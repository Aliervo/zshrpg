#!/usr/env zsh
###
### zshrpg
###
### A wrapper that fully integrates rpg-cli with zsh!
###
### Source: https://github.com/aliervo/zshrpg
### License: ISC
### rpg-cli source: https://github.com/facundoolano/rpg-cli
###

# Set $RPG as follows:
# - If already set, use it
# - If rpg-cli exists in $PATH, use that
# - Else, download the binary from github and use that
if [ $RPG ]
then
  RPG="$RPG"
elif which rpg-cli > /dev/null 2>&1
then
  RPG="$(which rpg-cli)"
else
  curl -L https://github.com/facundoolano/rpg-cli/releases/download/1.0.1/rpg-cli-1.0.1-linux > rpg-cli
  chmod +x ./rpg-cli
  RPG="$(pwd)/rpg-cli"
fi

# "rpg" is used to complete non fs related tasks such as print status and
# buy items.
rpg () {
  case "$@" in
    shop) # A semantic name for viewing the shop
      $RPG buy
      ;;
    quests | q) # A semantic name and shortened version
      $RPG todo
      ;;
    *)
      $RPG "$@"
      sync_rpg
      ;;
  esac
}

# Try to move the hero to the given destination, then match shell directory
# to that of the hero's location. Possible results:
# - the one supplied as parameter, if there weren't any battles
# - the one where the battle took place, if the hero wins
# - the home dir, if the hero dies
cd () {
  rpg cd "$@" && rpg ls
  sync_rpg
}

# Generate dungeon levels on the fly and look for treasures while moving down.
#  Will start by creating dungeon/1 at the current directory, and /2, /3, etc.
#  on subsequent runs.
dgn () {
  current=$(basename $PWD)
  number_re='^[0-9]+$'

  if [[ $current =~ $number_re ]]; then
    next=$(($current + 1))
    command mkdir -p $next && cd $next && rpg ls
  elif [[ -d 1 ]] ; then
    cd 1 && rpg ls
  else
    command mkdir -p dungeon/1 && cd dungeon/1 && rpg ls
  fi
}

# This helper is used to make the pwd match the tracked internally by the game
sync_rpg () {
  builtin cd "$($RPG pwd)"
}

# Jump to a folder without initiating battles at each step
teleport () {
  rpg cd --force "$@"
  sync_rpg
  rpg battle
}

# Only allow fs manipulation after a successful battle
# TODO: Put these into a var so users can override which
# commands have a chance to initiate a battle.
for cmd in rm rmdir mkdir touch mv cp chown chmod; alias $cmd="rpg battle && $cmd"

# Aliases for added convenience
alias quests="rpg todo"
alias shop="rpg buy"
alias tp="teleport"
