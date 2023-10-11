#!/bin/sh
curl --request GET \
  --url 'https://www.tenable.com/downloads/api/v2/pages/nessus/files/Nessus-10.6.1-x64.msi' \
  --output 'Nessus-10.6.1-x64.msi'
