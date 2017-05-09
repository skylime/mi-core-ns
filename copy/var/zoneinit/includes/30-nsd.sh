# Configure nsd-control

# Run it as nsd user to have correct permissions
# OpenSSL require rnd file in home temporary
sudo -u nsd HOME=/opt/local/etc/nsd nsd-control-setup
rm /opt/local/etc/nsd/.rnd

# Create nsd_listen.conf file with all ip addresses managed
# by vmadm sdc:nics / mdata
NSD_LISTEN_CONF='/opt/local/etc/nsd/nsd_listen.conf'
echo > ${NSD_LISTEN_CONF}
if mdata-get sdc:nics 1>/dev/null 2>&1; then
	ips=$(mdata-get sdc:nics | json -e 'this.ips = this.ips ? this.ips.join("\n") : ""' -a ips)

	if [[ "${ips}" =~ "dhcp" ]]; then
		echo "ip-address: 0.0.0.0" > ${NSD_LISTEN_CONF}
	else
		echo "ip-address: 127.0.0.1" >  ${NSD_LISTEN_CONF}
		echo "ip-address: ::1"       >> ${NSD_LISTEN_CONF}
		for ip in ${ips}; do
			echo "ip-address: ${ip%/*}" >> ${NSD_LISTEN_CONF}
		done
	fi
fi

# Enable nsd service
svcadm enable svc:/pkgsrc/nsd:default

# Setup simple log monitoring for errors cron
CRON='0,15,30,45 * * * * /opt/core/bin/check-log "/var/svc/log/pkgsrc-nsd:default.log"'
(crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab
