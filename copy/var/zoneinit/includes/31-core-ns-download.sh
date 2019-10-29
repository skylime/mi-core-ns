# Setup cron for downloading ns information

CRON='0,5,10,15,20,25,30,35,40,45,50,55 * * * * /opt/core/bin/core-ns-download.py -u "$(mdata-get ns_urls 2>/dev/null)"'
(crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab
