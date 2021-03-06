#!/bin/bash
# Save current git diff, log, status to output directory.
#
# Example usage:
#   ./save_git_info.sh /path/to/output/directory/
#   ./save_git_info.sh /path/to/output/directory/ /path/to/git/repo/
#
# Writes the following files to output_dir:
#
# git-status.txt: Output of git status -sb.
# git-log.txt: Output of
#     git log --graph --pretty='format:%h -%d %s (%cd) <%an>'
# git-diff.patch: Output of git diff --patch --color=never
# git-head.txt: Output of git rev-parse HEAD

function usage {
    echo "Usage: "
    echo "$0 <output_directory> [<git_dir>]"
}

if [[ "$#" != 1 ]] && [[ "$#" != 2 ]] ; then
    echo "Incorrect usage."
    usage
    exit 1
fi

OUTPUT_DIR=$(readlink -f "$1")
mkdir -p ${OUTPUT_DIR}

if [[ "$#" == 2 ]] ; then
    cd "$2"
fi

git diff --patch --color=never > "${OUTPUT_DIR}/git-diff.patch"
git log --graph --pretty='format:%h -%d %s (%cd) <%an>' \
    > "${OUTPUT_DIR}/git-log.txt"
git rev-parse HEAD > "${OUTPUT_DIR}/git-head.txt"
git status -sb > "${OUTPUT_DIR}/git-status.txt"
