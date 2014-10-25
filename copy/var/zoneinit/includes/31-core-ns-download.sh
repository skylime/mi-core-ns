# Setup cron for downloading ns information

CRON='0,15,30,45 * * * * /opt/core/bin/core-ns-download.py -u "$(mdata-get ns_urls 2>/dev/null)"'
(crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab
