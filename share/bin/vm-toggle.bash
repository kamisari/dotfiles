#!/bin/bash
set -eu

service=vboxheadless.service
if ! systemctl --user cat $service &> /dev/null; then
  echo "not found: systemctl --user $service"
  exit 1
fi

# help
unset -f helpmsg
helpmsg() {
  cat >&1 <<END
  toggle vboxeadless.service
  
  -h --help
    show this help
  -s --status
    show status ${service}
  -n --name
    modify target VM name
    $HOME/local/currentvm
END
}
case "${1:-}" in
  "--help"|"-h") helpmsg; exit 0;;
  "--status"|"-s")
    echo "----- STATUS -----"
    systemctl --user status ${service} || true
    echo "----- LIST VMS -----"
    vboxmanage list vms
    cat "$HOME"/local/currentvm
    echo "----- BIND PORTS -----"
    # maybe deprecation, bug: case currentvm=foo=bar
    vboxmanage showvminfo "$(cat "$HOME"/local/currentvm | cut -d "=" -f 2)" | grep NIC
    exit 0;;
  "--name"|"-n")
    shift
    if [ -z "${1:-}" ]; then
      cat "$HOME"/local/currentvm
      exit 0
    fi
    systemctl --user is-active $service 1> /dev/null && exit 2
    if ! vboxmanage list vms | grep "^\"${1}\" "; then
      echo "invalid: $1"
      exit 3
    fi
    echo "currentvm=${1}" > "$HOME"/local/currentvm
    cat "$HOME"/local/currentvm
    exit 0;;
  "");;
  *)  cat <<END
--- invalid argument ---
$*
END
    exit 1;;
esac
unset -f helpmsg

if systemctl --user is-active $service &> /dev/null; then
  echo "please wait for stop VM process"
  which "fortune" &> /dev/null && fortune -a
  systemctl --user stop $service
  echo "inactivate"
else
  systemctl --user start $service
  echo "activate"
  which "fortune" &> /dev/null && fortune -a
fi
# EOF
