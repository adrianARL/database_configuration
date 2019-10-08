#!/bin/bash

sudo service mongodb start

wget -O service_catalog.json http://raw.githubusercontent.com/adrianARL/database_configuration/master/service_catalog.json
mongoimport --db=globalDB --collection=service_catalog --file=service_catalog.json
rm service_catalog.json


echo '{"_id":"nodeID","seq":0}' > seq.json
mongoimport --db=globalDB --collection=nodes --file=seq.json
rm seq.json

wget -O configure_cloud_agent.py http://raw.githubusercontent.com/adrianARL/database_configuration/master/configure_cloud_agent.py
python3 configure_cloud_agent.py
mongoimport --db=globalDB --collection=nodes --file=device.config
mv device.config /etc/agent/config/
rm configure_cloud_agent.py
