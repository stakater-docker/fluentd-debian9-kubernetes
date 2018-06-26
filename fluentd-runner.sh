
#!/bin/bash
##############################################################
# This script kills all processes that are related to the passed `process name` 
# runit will start them up again with the new configuration
#
# Argument 1: Part of process name, or string that should be present in the process names
##############################################################
process_name=$1

if [ -z "$process_name" ];
then
    echo "Usage: $(basename $0) <process name> (String that must be included in the process names)"
    exit 1;
fi

pids=$(ps -aux | grep "$process_name" | grep -v "grep" | grep -v "entrypoint.sh" | grep -v "fluentd-runner" | awk '{print $2}');
if [ ! -z "$pids" ];
then
    echo "Killing $process_name processess with Process IDs: ${pids}"
    kill -KILL ${pids}
fi

fluentd -c /fluentd/etc/${FLUENTD_CONF} -p /fluentd/plugins --gemfile /fluentd/Gemfile ${FLUENTD_OPT} &