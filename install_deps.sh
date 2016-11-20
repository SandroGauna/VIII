#!/bin/bash
pip install boto==2.38.0
pip install jcconv==0.2.3
pip install num2words
pip install odoorpc
pip install oerplib==0.8.4
pip install openpyxl==2.4.0-b1
pip install Pillow
pip install psycogreen==1.0
pip install pyserial==2.7
pip install pytz
pip install pyusb==1.0.0b1
pip install qrcode==5.0.1
pip install suds
pip install suds_requests
pip install unidecode==0.04.19
pip install wheel

### Install deps repos
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

# 4 - pyboleto
cd /opt/depslibs;
git clone https://github.com/Trust-Code/pyboleto.git;
cd pyboleto;
python setup.py install;

# 5 - PyCNAB
cd /opt/depslibs;
git clone https://github.com/Trust-Code/PyCNAB.git pycnab;
cd pycnab;
python setup.py install;



