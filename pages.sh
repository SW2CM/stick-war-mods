#!/bin/sh
#
# pages.sh: dynamically creates a directory suitable for deployment on the web.
cd app
lime clean html5
lime build html5 -final
cd ..
git checkout gh-pages
git rm --cached -r .
git restore --source master mods/
git restore --source master fusion.sh
find ./ -type f -name "*.swf" -delete;
./fusion.sh
mv index.json mods/
git restore --source master app/build/openfl/html5/bin
find ./app/build/openfl/html5/bin/ -type f -exec mv '{}' ./ \;
git add mods
git commit -m "Automatically generated from the master branch"
git checkout master