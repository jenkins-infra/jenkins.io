#!/usr/bin/env bash

if [ -z "$1" ] ; then
  echo Missing branch name.
  exit 1
fi

BRANCH=$1
GHP_PATH=./build/_gh-pages

if [ ! -f "${GHP_PATH}/.git" ]; then
  echo "Setting up user-site work tree under ${GHP_PATH}"
  rm -rf "${GHP_PATH}"
  git worktree prune -v
  git worktree add --no-checkout "${GHP_PATH}" HEAD || exit 1
fi

pushd "${GHP_PATH}" || exit 1
rm -rf ./"${BRANCH}"

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

cp -r ../_site ./"${BRANCH}" &&
  git add --all -- "${BRANCH}" &&
  git commit -m "Publish site for ${BRANCH} branch to gh-pages" &&
  git push origin gh-pages

RESULT=$?
popd

exit $RESULT
