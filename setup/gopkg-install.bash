#!/bin/bash
set -eu

# set variable
goget="go get"
options="-v"
pkglist="$HOME/dotfiles/setup/gopkg.list"

function split () {
  echo "------- $1 -------"
}

# confirm $1=msg return bool
function confirm () {
  local key=""
  local counter=0
  while [ $counter -lt 3 ]; do
    counter=`expr $counter + 1`
    echo -n "$1 [yes:no]?>"
    read -t 60 key || return 1
    case "$key" in
      "no"|"n") return 1;;
      "yes"|"y") return 0;;
    esac
  done
  return 1
}

# help
function helpmsg () {
  cat >&1 <<END
go pkg install scripts

  help --help -h
    show help message
  update --update -u
    add flag -u for go get
  file --file -f
    specify path to gopkg.list(default: $pkglist)
END
}
while [ -n "${1:-}" ]; do
  case "$1" in
   help|--help|-h) helpmsg; exit 0;;
   update|--update|-u) options="-v -u";;
   file|--file|-f) shift; pkglist="$1";;
   "");;
  esac
  shift
done
unset -f helpmsg

# check
split "require"
type go
type gawk
if  [ ! -r "$pkglist" ] || [ ! -f "$pkglist" ]; then
  echo "can't read $pkglist"
  exit 1
fi

# parse
awkout=$(gawk '/^[^#].*/ { print $0 }' "$pkglist")

# info && confirm
split "go env"
go version
go env
sleep 1
split "install list"
for x in $awkout; do
  echo "$x"
done
split "confirm"
confirm "install packages? Run: ${goget} ${options}"

# install && update
echo "Run: $goget $options pkg"
for x in $awkout; do
  $goget $options $x
done
echo "...finish"
# EOF
