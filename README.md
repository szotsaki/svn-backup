# SVN backup
Lightweight script for SVN backup

This script creates complete SVN dumps of all repositories within `$repo_dir` to `$backup_dir`.
Backup is only made when the repo revision is greater than the one of the previous backup.

Only one backup of a repo is kept.

The script implies that the repository names are "prefix codes", i.e. none of
their names begin with an other repo name (eg. "test" and "test-2")

Compression is made with XZ (LZMA 2).
