#!/usr/bin/env bash

PLUGINS=`curl -sS https://api.github.com/orgs/jenkinsci/repos | jq -r .[].name | grep -- -plugin`
URL='https://raw.githubusercontent.com/jenkinsci'
URI='master/README.md'

read -r -d '' TEMPLATE << EOM
---
layout: project
title: "Plugins"
section: projects
tags:
- plugins
---

== Plugins
EOM

for plugin in $PLUGINS; do
  TEMPLATE="$TEMPLATE\n\n=== $plugin\n$(curl "$URL/$plugin/$URI" | head -n5 | tail -n +2)"
done

echo -e "$TEMPLATE" > content/projects/infrastructure/plugins.adoc
