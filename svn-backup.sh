#!/usr/bin/env bash

# Creates complete SVN dumps of all repositories within $repo_dir to $backup_dir.
# Backup is only made when the repo revision is greater than the one of the previous backup.
#
# Only one backup of a repo is kept.
#
# The script implies that the repository names are "prefix codes", i.e. none of
# their names begin with an other repo name (eg. "test" and "test-2")
#
# Compression is made with XZ (LZMA 2).

set -e

repo_dir="/srv/svn/repositories"
backup_dir="/srv/backup/SVN"

svnadmin="/usr/bin/svnadmin"
svnlook="/usr/bin/svnlook"

for repo in "$repo_dir"/*; do
    name=$(basename "$repo")
    revision=$($svnlook youngest "$repo")
    target="$backup_dir/$name-$revision.xz"
    if [ ! -e "$target" ]; then
        rm -f "$backup_dir/$name-*.xz"
        nice $svnadmin dump --deltas --quiet "$repo" | xz --compress --stdout -9 --extreme > "$target"
    fi
done
