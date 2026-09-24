# Poor man's cron
# Jobs are registered in dotfiles/cron (and optional dotfiles/cron.local):
#   cronjob <interval> <command> [condition]
# Intervals: 12h, 7d  (h=hours, d=days)
#
# At shell startup, bin/cron-check sources those files and offers due jobs.
# Manually: cron-check --force

"$MY_ZCOMET/bin/cron-check"
