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
	echo "ip-address: 127.0.0.1" >  ${NSD_LISTEN_CONF}
	echo "ip-address: ::1"       >> ${NSD_LISTEN_CONF}
	for ip in $(mdata-get sdc:nics | json -a ip); do
		echo "ip-address: ${ip%/*}" >> ${NSD_LISTEN_CONF}
	done
fi

# Enable nsd service
svcadm enable svc:/network/nsd:default
