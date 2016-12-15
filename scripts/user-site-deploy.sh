#!/usr/bin/env bash

# if there is no remote gh-pages
if git ls-remote --exit-code --heads origin gh-pages; then
  echo Found origin/gh-pages...
  git checkout -B gh-pages origin/gh-pages || exit 1
else
  if git show-ref --verify --quiet refs/heads/gh-pages; then
    echo There is a local gh-pages branch but no origin/gh-pages.
    echo Delete the local gh-pages and try deploy again.
    exit 1
  else
    git checkout --orphan gh-pages || exit 1
  fi
fi


git --work-tree build/_site/ add --all . &&
  git commit -m 'Publish user site to gh-pages' &&
  git push origin gh-pages

RESULT=$?

git reset --hard && git checkout - || exit 1

exit $RESULT