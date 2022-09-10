#!/bin/sh

# Script by Persian Prince for https://github.com/OpenVisionE2
# You're not allowed to remove my copyright or reuse this script without putting this header.

for d in *.zip
do
  dir=./${d%%.zip}
  unzip -d "$dir" "$d"
done

rm -rf *.zip

rename -f 's/ [^ ]*$//' */
rename -f 's/@/a/' */
rename -f 's/,/./' */
rename -f 's/,/./' */
rename -f 's/,/./' */
rename -f 's/,/./' */
rename -f 's/,/./' */
rename -f 's/,/./' */
rename -f 's/\s/_/g' */
rename -f 's/23E/23.5E/' */

find . -name '*.xml*' -type f | xargs rm -f
find . -name '*.url*' -type f | xargs rm -f
find . -name '*_org*' -type f | xargs rm -f
find . -name '*.org*' -type f | xargs rm -f
find . -name '*_bak*' -type f | xargs rm -f
find . -name '*.bak*' -type f | xargs rm -f

setup_git() {
  git config --global user.email "bot@openvision.tech"
  git config --global user.name "Open Vision settings bot"
}

commit_files() {
  git checkout master
  git add -u
  git add *
  git commit --message "Fix Predrag settings."
  ./CI/chmod.sh
  ./CI/dos2unix.sh
}

upload_files() {
  git remote add upstream https://${GITHUB_TOKEN}@github.com/OpenVisionE2/Predrag-settings.git > /dev/null 2>&1
  git push --quiet upstream master || echo "failed to push with error $?"
}

setup_git
commit_files
upload_files
