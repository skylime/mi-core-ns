#!/usr/bin/env python
# core-ns-download
# Check and download zip archive with zone information but only
# if required.

import requests
import subprocess, os, zipfile
import json
import argparse
from io import BytesIO
from zipfile import ZipFile

# Parse arguments
parser = argparse.ArgumentParser(description='Download multible zip archives with zone information for NSD.')
parser.add_argument('--url', '-u', metavar='urls', required=True, help='URLs with the ZIP archive (whitespace seperated)')
args = parser.parse_args()

# Cache file
cfile = '/tmp/core-ns-cache.json'
# Nameserver directory
nsdir = '/opt/local/etc/nsd/'

# Read cache information if available
cache = {}
try:
	with open(cfile) as cache_file:
		cache = json.load(cache_file)
except:
	pass

# Get all information
for url in args.url.split():
	header = {}
	if url in cache:
		header['If-None-Match'] = cache[url]

	try:
		req = requests.get(url, headers=header, timeout=10)
		req.raise_for_status()
		if req.status_code != 200:
			continue

		ZipFile(BytesIO(req.content)).extractall(nsdir)

		subprocess.check_output(['nsd-control', 'reconfig'])
		subprocess.check_output(['nsd-control', 'reload'])
		cache[url] = req.headers.get('etag')
	except Exception as e:
		print(url + ' failed: ' + str(e))

# Write cache information
try:
	with open(cfile, 'w') as cache_file:
		json.dump(cache, cache_file)
except Exception as e:
	print('Writing etag-cache failed: ' + str(e))
