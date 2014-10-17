# Setup cron for downloading ns information

CRON='0,15,30,45 * * * * if mdata-get ns_urls 1>/dev/null 2>&1; then /opt/core/bin/core-ns-download.py $(mdata-get ns_urls) fi'
(crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab
