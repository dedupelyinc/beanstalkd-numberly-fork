#!/bin/bash

_term() {
  echo "Caught TERM signal, sending to pid $child!"
  kill -TERM "$child"
}

_hup() {
  echo "Caught HUP signal, sending to pid $child!"
  kill -HUP "$child"
}

_usr1() {
  echo "Caught USR1 signal, sending to pid $child!"
  kill -USR1 "$child"
}

# Terminate
trap _term SIGTERM

# Same
trap _hup SIGHUP

# Drain mode
trap _usr1 SIGUSR1

./beanstalkd/beanstalkd -b /var/beanstalkd -z 300000 -n &

child=$!
wait "$child"