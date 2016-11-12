#!/bin/bash
#################Commented code############################################
#above code are commented and commands are executed in other places
#however its kept here for legacy purpose and review
#upon stable run of the containers these code should be cleaned out
#cd /opt
# Clone odoo 8 repo
#git clone https://www.github.com/odoo/odoo --depth 1 --branch 8.0 --single-branch
#mkdir -p /opt/odoo/extra-addons
#cd /opt/odoo/extra-addons
# Clone required repos for Brazilian localization
#oca/ln10-brazil
#git clone https://github.com/OCA/l10n-brazil.git --branch 8.0
#oca/server-tools
#git clone https://github.com/OCA/server-tools.git --branch 8.0
#oca/account-fiscal-rules
#git clone https://github.com/OCA/account-fiscal-rule.git --branch 8.0
#odoo-brazil-electronic-documents
#git clone https://github.com/odoo-brazil/odoo-brazil-eletronic-documents.git
#odoo-brazil-sped
#git clone https://github.com/odoo-brazil/odoo-brazil-sped.git
#Boleto :
#git clone https://github.com/OCA/bank-payment.git --branch 8.0
#git clone https://github.com/OCA/bank-statement-import.git --branch 8.0
#git clone https://github.com/OCA/account-payment.git --branch 8.0
#git clone https://github.com/OCA/bank-statement-reconcile.git --branch 8.0
#git clone https://github.com/Trust-Code/odoo-brazil-banking.git
# Install Dependencies
#pip install pyOpenSSL==0.14 geraldo
#Instalar libxml
#wget ftp://xmlsoft.org/libxml2/libxml2-sources-2.7.8.tar.gz
#tar xvzf libxml2-sources-2.7.8.tar.gz
#cd libxml2-2.7.8/python
#python setup.py install
#Instalar pyxmlsec
#De acordo com o Aristildes Caldeira [1], há um bug na biblioteca PyXMLSec versão 64 bits. Uma solução é instalar o xmlsec na mão com o patch indicado [2].
#[1] - https://groups.google.com/group/pynfe/browse_thread/thread/43bdb756d8252bf5
#[2] - http://pastebin.com/4QwzC1jX
#wget http://labs.libre-entreprise.org/download.php/430/pyxmlsec-0.3.0.tar.gz
#tar xvzf pyxmlsec-0.3.0.tar.gz
#cd pyxmlsec-0.3.0
#python setup.py install
#Instalar PySPED-NFe
#git clone https://github.com/proge/PySPED-NFe.git
#cd PySPED-NFe
#python setup.py install
#Install Boleto dependencies
#pip install https://github.com/Trust-Code/pyboleto/archive/master.zip
#pip install https://github.com/Trust-Code/PyCNAB/archive/master.zip
##############################################################################################

pip install wheel
pip install pyserial==2.7
pip install psycogreen==1.0
pip install pyusb==1.0.0b1
pip install qrcode==5.0.1
pip install Pillow
pip install boto==2.38.0
pip install oerplib==0.8.4
pip install jcconv==0.2.3
pip install pytz

### Install deps repos
mkdir -p /opt/depslibs;
cd /opt/depslibs;

git clone https://github.com/ahmedgenina/pyxmlsec-0.3.1.git;
cd pyxmlsec-0.3.1;
python setup.py install;

cd /opt/depslibs;

git clone https://github.com/ahmedgenina/geraldo.git;
cd geraldo;
python setup.py install;

cd /opt/depslibs;
git clone https://github.com/ahmedgenina/PySPED.git;
cd PySPED;
python setup.py install;

cd /opt/depslibs;

git clone https://github.com/ahmedgenina/pyboleto.git;
cd PyCNAB;
python setup.py install;

cd /opt/depslibs;

git clone https://github.com/ahmedgenina/PyCNAB.git;
cd PyCNAB;
python setup.py install;

#git clone https://github.com/odoo-brazil/pyxmlsec --branch master
#cd pyxmlsec
#sudo python setup.py install