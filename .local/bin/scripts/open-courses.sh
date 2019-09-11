cd /opt/webwork/webwork2
sudo chgrp -R wwdata DATA ../courses htdocs/tmp htdocs/applets logs tmp /opt/webwork/pg/lib/chromatic
sudo chmod -R g+w DATA ../courses htdocs/tmp htdocs/applets logs tmp /opt/webwork/pg/lib/chromatic
sudo find DATA/ ../courses/ htdocs/tmp logs/ tmp/ -type d -a -exec chmod g+s {} \;
