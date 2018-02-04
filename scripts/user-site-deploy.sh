#!/usr/bin/env bash

if [ -z "$1" ] ; then
  echo Missing branch name.
  exit 1
fi

BRANCH=$1

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
    echo "Creating new gh-pages brach"
    git checkout --orphan gh-pages || exit 1
    git rm -rf . || exit 1
  fi
fi

mkdir -p build/_gh-pages &&
  cp -r build/_site build/_gh-pages/"${BRANCH}"
  git --work-tree build/_gh-pages/ add --all -- "${BRANCH}" &&
  git commit -m "Publish site for ${BRANCH} branch to gh-pages" &&
  git push origin gh-pages

RESULT=$?
rm -rf build/_gh-pages
rm -rf "${BRANCH}"
git reset --hard && git checkout - || exit 1

exit $RESULT
