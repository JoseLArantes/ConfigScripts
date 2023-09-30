#!/usr/bin/env bash
set -euo pipefail

log() { echo "$@" 1>&2; }

max_tries=${RETRY_MAX_TRIES:-3}
max_sleep=${RETRY_MAX_SLEEP:-15}
min_sleep=${RETRY_MIN_SLEEP:-5}

# Argument validations
if (( min_sleep >= max_sleep )); then
  log "ERROR: Min sleep must be less than max sleep"
  exit 1
fi
if (( min_sleep <= 0 )); then
  log "ERROR: Min sleep must be greather than 0"
  exit 1
fi

sleep_range=$(( max_sleep - min_sleep + 1 ))

log "Running command with retries (max_tries=$max_tries, min_sleep=$min_sleep, max_sleep=$max_sleep):"
log "$*"
log ""

for attempt_no in $(seq "$max_tries"); do
    log "Attempt ${attempt_no} out of ${max_tries} ..."

    cmd_succeeded="true"
    echo $@
    "$@" || cmd_succeeded="false"

    if ${cmd_succeeded}; then
        log 'Command succeeded'
        break
    else
        log 'Command failed!'

        if [[ ${attempt_no} == "${max_tries}" ]]; then
            log 'Retries exhausted'
            exit 1
        else
            random_sleep_time_in_seconds="$(( ( RANDOM % sleep_range ) + min_sleep ))"
            log "Sleeping ${random_sleep_time_in_seconds} second(s) before retrying ..."
            sleep "${random_sleep_time_in_seconds}"
            log ""
        fi
    fi
done
