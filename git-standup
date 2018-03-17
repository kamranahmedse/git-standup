#!/usr/bin/env bash

# Shows the usage
function usage() {
  cat <<EOS
Usage:
  git standup [-a <author name>] [-w <weekstart-weekend>] [-d <since-days-ago>] [-u <until-days-ago>] [-m <max-dir-depth>] [-g] [-h] [-f]

  -a      - Specify author to restrict search to
  -w      - Specify weekday range to limit search to
  -m      - Specify the depth of recursive directory search
  -L      - Toggle inclusion of symbolic links in recursive directory search
  -d      - Specify the number of days back to include
  -u      - Specify the number of days back until this day
  -D      - Specify the date format for "git log" (default: relative)
  -h      - Display this help screen
  -g      - Show if commit is GPG signed (G) or not (N)
  -f      - Fetch the latest commits beforehand
  -s      - Silences the no activity message (useful when running in a directory having many repositories)
  -r      - Generate a file with the report

Examples:
  git standup -a "John Doe" -w "MON-FRI" -m 3
EOS
}

# Sets up the colored output
function colored() {
  RED=$(tput setaf 1)
  GREEN=$(tput setaf 2)
  YELLOW=$(tput setaf 3)
  BLUE=$(tput setaf 4)
  BOLD=$(tput bold)
  UNDERLINE=$(tput smul)
  NORMAL=$(tput sgr0)
  GIT_PRETTY_FORMAT='%Cred%h%Creset - %s %Cgreen(%cd) %C(bold blue)<%an>%Creset'
  COLOR=always

  if [[ $option_g ]] ; then
    GIT_PRETTY_FORMAT="$GIT_PRETTY_FORMAT %C(yellow)gpg: %G?%Creset"
  fi
}

# Sets up the uncolored output
function uncolored() {
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  UNDERLINE=""
  NORMAL=""
  GIT_PRETTY_FORMAT='%h - %s (%cd) <%an>'
  COLOR=never

  if [[ $option_g ]] ; then
    GIT_PRETTY_FORMAT="$GIT_PRETTY_FORMAT gpg: %G?\n"
  else
    GIT_PRETTY_FORMAT="$GIT_PRETTY_FORMAT \n"
  fi
}

function writeFile() {
  echo -e $1 >> "${REPORT_FILE_PATH}"
}

function runStandup() {
  # Fetch the latest commits, if required
  if [[ $option_f ]]; then
    echo "${BOLD}${GREEN}Fetching commits in ${YELLOW}${UNDERLINE}${BOLD}${BASENAME}${NORMAL}"
    git fetch --all > /dev/null 2>&1
  fi

  {
    GITOUT=$(eval ${GIT_LOG_COMMAND} 2>/dev/null )
  } || {
    GITOUT=""
  }

  # If `r` option was given then no output, just write the report
  if [[ ! -z $option_r ]] ; then
    echo "Generating report for: ${CUR_DIR}"

    if [[ ! -z "$GITOUT" ]] ; then
      writeFile "${CUR_DIR}\n $GITOUT"
    elif [[ -z $option_s ]] ; then
      writeFile "${CUR_DIR}\n No activity found!\n"
    fi
  else
    ## Only output if there is some activity
    if [[ ! -z "$GITOUT" ]] ;  then
      echo "${BOLD}${UNDERLINE}${YELLOW}$CUR_DIR${NORMAL}"
      echo "$GITOUT"
    elif [[ -z $option_s ]] ; then  ## Show the no activity message only if the `s` flag is not there
      echo "${BOLD}${UNDERLINE}${YELLOW}$CUR_DIR${NORMAL}"
      if [[ ${AUTHOR} = '.*' ]] ; then
        echo "${YELLOW}Seems like no one did anything!${NORMAL}"
      else
        echo "${YELLOW}Seems like $AUTHOR did nothing!${NORMAL}"
      fi
    fi
  fi
}

while getopts "hgfsd:u:a:w:m:D:Lr" opt; do
  case $opt in
    h|d|u|a|w|m|g|D|f|s|L|r)
      declare "option_$opt=${OPTARG:-0}"
      ;;
    \?)
      echo >&2 "Use 'git standup -h' to see usage info"
      exit 1
      ;;
  esac
done

shift $((OPTIND-1))

if [[ $# -gt 0 ]]; then
  echo >&2 "Invalid arguments: $@"
  echo >&2 "Use 'git standup -h' to see usage info"
  exit 1
fi

# Main script
if [[ $option_h ]]; then
  usage
  exit 0
fi

# Use colors, but only if connected to a terminal, and that terminal supports them.
if [[ -t 1 ]] && [[ -n "$TERM" ]] && which tput &>/dev/null && tput colors &>/dev/null; then
  ncolors=$(tput colors)
  if [[ -n "$ncolors" ]] && [[ "$ncolors" -ge 8 ]] && [[ -z "$option_r" ]] ; then
    colored
  else
    uncolored
  fi
else
  uncolored
fi

## Set the necessary variables for standup
AUTHOR=`git config user.name`
SINCE="yesterday"
MAXDEPTH=2
INCLUDE_LINKS=
RAN_FROM_DIR=`pwd`
REPORT_FILE_PATH="${RAN_FROM_DIR}/git-standup-report.txt"

# If report is to be generated, remove the existing report file if any
if [[ ! -z $option_r ]] ; then
   rm -rf ${REPORT_FILE_PATH}
fi

if [[ $option_a ]] ; then
  # In case the parameter
  if [[ $option_a = 'all' ]] ; then
    AUTHOR=".*"
  else
    AUTHOR="$option_a"
  fi
fi

if [[ $option_m ]] ; then
  MAXDEPTH="$(($option_m + 1))"
fi

if [[ $option_L ]] ; then
  INCLUDE_LINKS="-L"
fi

## If -d flag is there, use its value for the since
if [[ $option_d ]] && [[ $option_d -ne 0 ]] ; then
  SINCE="$option_d days ago"
else
  ## -d flag is not there, go on with the normal processing
  WEEKSTART="$( cut -d '-' -f 1 <<< "$option_w" )";
  WEEKSTART=${WEEKSTART:="Mon"}

  WEEKEND="$( cut -d '-' -f 2 <<< "$option_w" )";
  WEEKEND=${WEEKEND:="Fri"}

  ## In case it is the start of week, we need to
  ## show the commits since the last weekend
  shopt -s nocasematch
  if [[ ${WEEKSTART} == "$(date +%a)" ]] ; then
    SINCE="last $WEEKEND";
  fi
fi

## If -u flag is there, use its value for the until
if [[ $option_u ]] && [[ $option_u -ne 0 ]] ; then
  UNTIL_OPT="--until=\"$option_u days ago\""
fi

GIT_DATE_FORMAT=${option_D:-relative}

GIT_LOG_COMMAND="git --no-pager log \
    --all
    --no-merges
    --since=\"$SINCE\"
    ${UNTIL_OPT}
    --author=\"$AUTHOR\"
    --abbrev-commit
    --oneline
    --pretty=format:'$GIT_PRETTY_FORMAT'
    --date='$GIT_DATE_FORMAT'
    --color=$COLOR"

## For when the command has been run in a non-repo directory
if [[ ! -d ".git" || -f ".git" ]]; then
  BASE_DIR=`pwd`
  ## Set delimiter to newline for the loop
  IFS=$'\n'

  if [[ -f ".git-standup-whitelist" ]]; then
      SEARCH_PATH=`cat .git-standup-whitelist`
  else
      SEARCH_PATH=.
  fi

  ## Recursively search for git repositories
  PROJECT_DIRS=`find ${INCLUDE_LINKS} ${SEARCH_PATH} -maxdepth ${MAXDEPTH} -mindepth 0 -name .git`
elif [[ -f ".git" || -d ".git" ]]; then
  PROJECT_DIRS=("`pwd`/.git")
fi

## if project directories is still empty
## we might be sitting inside a git repo
if [[ -z ${PROJECT_DIRS} ]]; then
  ROOT_DIR_COMMAND="git rev-parse --show-toplevel"
  PROJECT_ROOT=$(eval ${ROOT_DIR_COMMAND} 2>/dev/null )

  if [[ -z ${PROJECT_ROOT} ]]; then
    echo "${YELLOW}You must be inside a git repository!${NORMAL}"
    exit 0
  fi

  PROJECT_DIRS=("${PROJECT_ROOT}/.git")
fi

# Foreach of the project directories, run the standup
for DIR in ${PROJECT_DIRS}; do
  cd "`dirname $DIR`"
  CUR_DIR=`pwd`
  BASENAME=`basename "$CUR_DIR"`

  # continue if not a git directory
  if [[ ! -d ".git" || -f ".git" ]] ; then
    cd ${BASE_DIR}
    continue
  fi

  runStandup

  cd ${BASE_DIR}
done
