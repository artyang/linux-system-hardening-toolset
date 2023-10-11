#!/bin/sh
curl --request GET \
  --url 'https://www.tenable.com/downloads/api/v2/pages/nessus/files/Nessus-10.6.1-ubuntu1404_amd64.deb' \
  --output 'Nessus-10.6.1-ubuntu1404_amd64.deb'
sudo dpkg -i ./Nessus-10.6.1-ubuntu1404_amd64.deb 
# You can start Nessus Scanner by typing /bin/systemctl start nessusd.service
/bin/systemctl start nessusd.service
# Then go to https://kali:8834/ to configure your scanner

