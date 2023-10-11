#!/bin/sh
curl --request GET \
  --url 'https://www.tenable.com/downloads/api/v2/pages/nessus/files/Nessus-10.6.1-ubuntu1404_amd64.deb' \
  --output 'Nessus-10.6.1-ubuntu1404_amd64.deb'
sudo dpkg -i ./Nessus-10.6.1-ubuntu1404_amd64.deb 
