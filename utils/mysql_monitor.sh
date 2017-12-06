#!/bin/bash
#
# Monitor MySQL queries
# @author Colin Mollenhour

set -e

file=$(mysql -sN performance_schema -e 'SELECT Variable_Value FROM global_variables WHERE Variable_Name = "general_log_file"')
if ! [[ -f $file ]]; then
  datadir=$(mysql -sN performance_schema -e 'SELECT Variable_Value FROM global_variables WHERE Variable_Name = "datadir"')
  if ! [[ -f $datadir/$file ]]; then
    echo "Could not locate general log file $file in $datadir."
    exit 1
  fi
  file=$(realpath $datadir/$file)
fi

sudo=''
[[ -w $file ]] || sudo=sudo
$sudo bash -c ">$file"
mysql -e "SET GLOBAL general_log = 'ON'"

tailPid=0
function cleanExit {
  kill -TERM $tailPid >/dev/null 2>&1
  mysql -e "SET GLOBAL general_log = 'OFF'"
  echo -e "\n$file"
}

trap cleanExit SIGINT SIGTERM
$sudo tail -f $file &
tailPid=$!
wait

mysql -e "SET GLOBAL general_log = 'OFF'"
echo -e "\n$file"
