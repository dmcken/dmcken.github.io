#!/bin/bash

git config --global --add safe.directory /srv/jekyll

bundle

bundle exec jekyll serve --host 0.0.0.0 --drafts
