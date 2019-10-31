# Changelog

## 18.4.1

### New

* Update cronjob to download netmgt information every 5 minutes. [Thomas Merkel]
* Refresh image and use latest core-base release. [Thomas Merkel]

## 18.4.0

### New

* Version bump to 18.4.0. [Thomas Merkel]

## 17.1.1

### Fix

* Fix naming of nsd munin plugins. [Thomas Merkel]
* Change default pid file location to solve permission issue. [Thomas Merkel]

## 17.1.0

### New

* Enable check-log cronjob for nsd. [Thomas Merkel]

### Fix

* Add workaround for check-log script. [Thomas Merkel]

## 16.4.0

### New

* Version bump to 16.4.0. [Thomas Merkel]

## 16.2.0

### New

* Version bump to 16.2.0 and munin plugin fix. [Thomas Merkel]
* Provide new manifest.json file. [Thomas Merkel]

### Other

* Remove nsd.xml because provided by pkgsrc, support dhcp listen. [Thomas Merkel]

## 15.1.0

### New

* Version bump to new core-base. [Thomas Merkel]

	Modify customize script to use default nsd from pkgsrc. Remove no
	onger required SMF manifest becaut it's in the pkgsrc now. Change
	and update LICENSE file

* Full path is required if you run commands like nsd-config/-control. [Thomas Merkel]

### Fix

* Nsd.xml manifest still required for 2015Q1. [Thomas Merkel]

## 14.2.3

### Fix

* Add script that read out sdc:nic ip information to generate nsd_listen.conf file. [Thomas Merkel]

    If we could read the information from sdc:nic and parse it we listen
    on that ip addresses. If not the nsd_listen.conf is cleaned to we try
    to listen on all interface (which moslty result in the bug).  We're
    also sure we listen on localhost ipv4 and ipv6.

* Create an extra file that is included for ip address binding. [Thomas Merkel]

    This is required to fix the bug we're running into:
    https://www.nlnetlabs.nl/bugs-script/show_bug.cgi?id=618

## 14.2.2

### New

* update base image. [Thomas Merkel]

### Fix

* output of python script on success. [Thomas Merkel]

### Other

* version bump. [Thomas Merkel]

## 14.2.1

### Other

* reconfig is required to read zone list. [Thomas Merkel]
* Update to new nsd version, remove no longer required file. [Thomas Merkel]
* Merge branch 'master' of github.com:skylime/mi-core-ns. [Thomas Merkel]
* use star for nsd include files. [Thomas Merkel]
* update nsd directory. [Thomas Merkel]
* import subprocess. [Thomas Merkel]

## 14.2.0

### Other

* Fix typo for cronjob. [Thomas Merkel]
* Folder not required during customize script. [Thomas Merkel]
* nsd require include file to be present. [Thomas Merkel]
* Add cron script for download ns files. [Thomas Merkel]
* Fix path for the downloaded zone files. [Thomas Merkel]
* Fix deps for python script. [Thomas Merkel]
* Fix path for the downloaded zip content. [Thomas Merkel]
* Add our awesome core-ns download script. [Thomas Merkel]
* Add unzip for the later required bash script. [Thomas Merkel]
* Enable nsd smf manifest by default, add munin configuration for nsd. [Thomas Merkel]
* Add zoneinit script to configure nsd-control and enable the service. [Thomas Merkel]
* We would like to have a nice NSD SMF manifest. [Thomas Merkel]
* Fix permissions and create core folder for zone imports and files. [Thomas Merkel]
* Add NSD minimal configuration file. [Thomas Merkel]
* Fix broken permissions and missing folder for default config file. [Thomas Merkel]
* Install the awesome nsd pkg. [Thomas Merkel]
* First commit with mostly empty files. [Thomas Merkel]
