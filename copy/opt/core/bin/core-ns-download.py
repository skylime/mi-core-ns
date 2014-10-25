#!/usr/bin/env python
# core-ns-download
# Check and download zip archive with zone information but only
# if required.

import requests
import subprocess, os, zipfile
import argparse
from io import BytesIO
import json

# Parse arguments
parser = argparse.ArgumentParser(description='Download multible zip archives with zone information for NSD.')
parser.add_argument('url', metavar='url', nargs='+', help='URLs with the ZIP archive')
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
for url in args.url:
	header = {}
	if cache.get(url):
		header = {
			'If-None-Match': cache.get(url)
		}
	try:
		req = requests.get(url, headers=header)
		req.raise_for_status()
	except Exception as e:
		print('Problem: ' + str(e))
		continue
	cache[url] = req.headers.get('etag')
	if req.ok and req.status_code == 200:
		try:
			z = zipfile.ZipFile(BytesIO(req.content))
			z.extractall(nsdir)
			subprocess.call(['nsd-control', 'reload'])
		except Exception as e:
			print(str(e))

# Write cache information
try:
	with open(cfile, 'w+') as cache_file:
		json.dump(cache, cache_file)
except Exception as e:
	print(str(e))
