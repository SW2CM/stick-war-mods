#!/bin/sh
#
# pages.sh: dynamically creates a directory suitable for deployment on the web.
git checkout gh-pages
git rm --cached -r .
git restore --source master mods/
git restore --source master fusion.sh
find ./ -type f -name "*.swf" -delete;
./fusion.sh
mv index.json mods/
git add mods
git commit -m "Automatically generated from the master branch"
# git checkout master --force