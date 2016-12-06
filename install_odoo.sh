#!/usr/bin/env bash

sudo apt-get update;


echo "en_US ISO-8859-1" >> /etc/locale.gen;
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen;
echo "pt_BR ISO-8859-1" >> /etc/locale.gen;
echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen;
locale-gen;

sudo apt-get install -y --no-install-recommends autoconf build-essential ca-certificates curl fontconfig fontconfig-config git idle-python2.7 libexpat1 libfontconfig1 libfontenc1 libfreetype6 libgle3 \
libjbig0 libjpeg8-dev libpng12-0 libqt4-dbus libqt4-network libssl1.0.0 libtool libx11-6 libx11-data libxau6 libxcb1 libxdmcp6 libxext6 libxfont1 libxml2-dev libxmlsec1-dev libxrender1 nano node-clean-css \
node-less nodejs npm qt4-designer qt4-dev-tools ttf-dejavu-core ucf unixodbc vim x11-common xfonts-75dpi xfonts-base xfonts-encodings xfonts-utils pkg-config libqt4-test libqt4-xml libqtcore4 libqtgui4 \
software-properties-common libqt4-script \
python-argparse python-babel python-cups python-dateutil python-decorator python-dev python-docutils  python-feedparser python-gdata python-gevent python-greenlet python-imaging python-jinja2 python-ldap python-libxslt1 python-lxml python-mako python-markupsafe python-zsi \
python-mock python-oerplib python-opengl python-openid python-openssl python-passlib  python-pil python-pip python-psutil python-psycopg2 python-pybabel python-pychart python-pydot python-pyinotify python-pyodbc python-pyparsing python-pypdf python-pyrex python-xlwt \
python-pyside.qtopengl python-qt4 python-qt4-gl python-renderpm python-reportlab python-requests python-setuptools python-simplejson python-six python-tz python-unittest2 python-vatnumber python-vobject python-webdav python-werkzeug python-wsgiref python-yaml;

sudo adduser odoo;


cd /tmp
wget http://download.gna.org/wkhtmltopdf/0.12/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb /opt/depslibs/wkhtmltox.deb
dpkg -i wkhtmltox.deb


git clone https://www.github.com/odoo/odoo --depth 1 --branch 8.0 --single-branch;
# localization files
cd odoo;
mkdir brasil;
cd brasil;
git clone https://github.com/OCA/l10n-brazil.git --branch 8.0;
#oca/server-tools
git clone https://github.com/OCA/server-tools.git --branch 8.0;
#oca/account-fiscal-rules
git clone https://github.com/OCA/account-fiscal-rule.git --branch 8.0;
#odoo-brazil-electronic-documents
git clone https://github.com/odoo-brazil/odoo-brazil-eletronic-documents.git --branch 8.0;
#odoo-brazil-sped
git clone https://github.com/odoo-brazil/odoo-brazil-sped.git --branch 8.0;
#Boleto :
git clone https://github.com/OCA/bank-payment.git --branch 8.0;
git clone https://github.com/OCA/bank-statement-import.git --branch 8.0;
git clone https://github.com/OCA/account-payment.git --branch 8.0;
git clone https://github.com/OCA/bank-statement-reconcile.git --branch 8.0;
git clone https://github.com/Trust-Code/odoo-brazil-banking.git --branch 8.0;




sudo pip install boto==2.38.0;
sudo pip install jcconv==0.2.3;
sudo pip install num2words;
sudo pip install odoorpc;
sudo pip install oerplib==0.8.4;
sudo pip install openpyxl==2.4.0-b1;
sudo pip install Pillow;
sudo pip install psycogreen==1.0;
sudo pip install pyserial==2.7;
sudo pip install pytz;
sudo pip install pyusb==1.0.0b1;
sudo pip install qrcode==5.0.1;
sudo pip install suds;
sudo pip install suds_requests;
sudo pip install unidecode==0.04.19;
sudo pip install wheel;



mkdir -p /opt/depslibs;

# 1 - pyxmlsec-0.3.1
cd /opt/depslibs;
git clone https://github.com/ahmedgenina/pyxmlsec-0.3.1.git;
cd pyxmlsec-0.3.1;
python setup.py install;

# 2 - geraldo
cd /opt/depslibs;
git clone https://github.com/ahmedgenina/geraldo.git;
cd geraldo;
python setup.py install;

# 3 - PySPED
cd /opt/depslibs;
git clone https://github.com/Trust-Code/PySPED.git pysped;
cd pysped;
python setup.py install;


cd /opt/depslibs;
git clone https://github.com/Trust-Code/pyboleto.git
cd pyboleto;
python setup.py install;

cd /opt/depslibs;
git clone https://github.com/Trust-Code/PyCNAB.git
cd PyCNAB;
python setup.py install;

#database installation
sudo apt-get install postgresql
sudo su - postgres
createuser --createdb --username postgres --no-createrole --no-superuser --pwprompt odoo

