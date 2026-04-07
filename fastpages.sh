#!/bin/sh
#
# fastpages.sh: pages.sh but no lime build.
echo Generating page...
git checkout gh-pages
git rm --cached -r .
git restore --source master mods/
git restore --source master fusion.sh
find ./ -type f -name "*.swf" -delete;
./fusion.sh
git rm --cached fusion.sh
mv index.json mods/
echo Pushing...
git commit -m "Automatically generated from the master branch"
git push
git checkout master --force
echo Done!