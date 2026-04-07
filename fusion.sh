#!/bin/sh
#
# fusion.sh: dynamically creates an index.json file for all the mods' description.json files.

printf '{\n\t"mods": [\n' > index.json
find ./mods/ -type f -name 'description.json' -printf '\t\t"https://sw2cm.github.io/stick-war-mods/mods/%P",\n' >> index.json
truncate -s-2 index.json
printf '\n\t]\n}' >> index.json