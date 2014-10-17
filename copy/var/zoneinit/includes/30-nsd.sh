# Configure nsd-control

# Run it as nsd user to have correct permissions
# OpenSSL require rnd file in home temporary
sudo -u nsd HOME=/opt/local/etc/nsd nsd-control-setup
rm /opt/local/etc/nsd/.rnd

# Enable nsd service
svcadm enable svc:/network/nsd:default
