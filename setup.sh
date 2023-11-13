#!/bin/sh

NAME=$(git ls-remote --get-url origin | cut -d'/' -f2 | sed -e 's/\.git//')
MODULE=$(echo "$NAME" | sed -e 's/\.nvim//')

mv lua/neovim-plugin-template lua/$MODULE
mv plugin/neovim-plugin-template.lua plugin/$MODULE.lua

PASCAL_CASE=$(echo "$MODULE" | sed -r 's/(^|-)([a-z])/\U\2/g')
SNAKE_CASE=$(echo "$MODULE" | sed -e 's/-/_/g')

grep -rl "NeovimPluginTemplate" lua/ | xargs sed -i -e "s/NeovimPluginTemplate/$PASCAL_CASE/g"
grep -rl "neovim-plugin-template" lua/ | xargs sed -i -e "s/neovim-plugin-template/$MODULE/g"
grep -rl "neovim-plugin-template" README.md | xargs sed -i -e "s/neovim-plugin-template/$NAME/g"
grep -rl "neovim_plugin_template" plugin/ | xargs sed -i -e "s/neovim_plugin_template/$SNAKE_CASE/g"

rm setup.sh
rm Makefile

if ! git config --get user.email; then
  read -p "Github email: " EMAIL
  git config user.email "$EMAIL"
fi
if ! git config --get user.name; then
  read -p "Github name: " USERNAME
  git config user.name "$USERNAME"
fi

git add .
git commit -m "chore: initialise repository"
