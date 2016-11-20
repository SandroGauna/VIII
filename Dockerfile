FROM ubuntu:latest
MAINTAINER Datashow LTDA <Ahmed-Genina>

### Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN set -x; \
apt-get update \
&& apt-get install -y --no-install-recommends \
autoconf build-essential ca-certificates curl fontconfig fontconfig-config git idle-python2.7 libexpat1 libfontconfig1 libfontenc1 libfreetype6 libgle3 libjbig0 libjpeg8-dev libpng12-0 libqt4-dbus libqt4-network \
libssl1.0.0 libtool libx11-6 libx11-data libxau6 libxcb1 libxdmcp6 libxext6 libxfont1 libxml2-dev libxmlsec1-dev libxrender1 nano node-clean-css node-less nodejs npm qt4-designer qt4-dev-tools \
ttf-dejavu-core ucf unixodbc vim x11-common xfonts-75dpi xfonts-base xfonts-encodings xfonts-utils pkg-config libqt4-test libqt4-xml libqtcore4 libqtgui4 software-properties-common libqt4-script \
python-argparse python-babel python-cups python-dateutil python-decorator python-dev python-docutils  python-feedparser python-gdata python-gevent python-greenlet python-imaging python-jinja2 python-ldap python-libxslt1 python-lxml python-mako python-markupsafe python-zsi \
python-mock python-oerplib python-opengl python-openid python-openssl python-passlib  python-pil python-pip python-psutil python-psycopg2 python-pybabel python-pychart python-pydot python-pyinotify python-pyodbc python-pyparsing python-pypdf python-pyrex python-xlwt \
python-pyside.qtopengl python-qt4 python-qt4-gl python-renderpm python-reportlab python-requests python-setuptools python-simplejson python-six python-tz python-unittest2 python-vatnumber python-vobject python-webdav python-werkzeug python-wsgiref python-yaml



### add user "odoo" which will be used to run odoo
RUN useradd -ms /bin/bash odoo	&& chown -R odoo /opt && chown -R odoo /var &&  mkdir -p /etc/odoo && chmod 777 /etc/odoo

### Clone Odoo Repo
RUN set -x; \
	cd /opt \
    && git clone https://www.github.com/odoo/odoo --depth 1 --branch 8.0 --single-branch
    
###Copy entrypoint script and Odoo configuration file
COPY ./entrypoint.sh /
COPY ./install_deps.sh /opt/
COPY ./openerp-server.conf /etc/odoo/ 
RUN chown odoo /etc/odoo/openerp-server.conf
RUN chmod +x /opt/install_deps.sh
RUN /opt/install_deps.sh


# Install wkhtmltopdf specific version (required to print pdf files in odoo)
ADD http://download.gna.org/wkhtmltopdf/0.12/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb /opt/depslibs/wkhtmltox.deb
WORKDIR /opt/depslibs/
RUN dpkg -i wkhtmltox.deb

# Mount /var/lib/odoo to allow restoring filestore and /mnt/extra-addons for users addons
RUN mkdir -p /mnt/extra-addons
WORKDIR /mnt/extra-addons
RUN git clone -b 8.0 http://github.com/Trust-Code/odoo-brazil-eletronic-documents.git eletronic-docs
RUN git clone -b 8.0 http://github.com/Trust-Code/l10n-brazil.git l10n-brazil
RUN git clone -b 8.0 http://github.com/Trust-Code/account-fiscal-rule.git fiscal-rule
RUN git clone -b 8.0 http://github.com/Trust-Code/trust-addons.git trust-addons
RUN git clone -b 8.0 http://github.com/Trust-Code/server-tools.git server-tools
RUN git clone -b 8.0 https://github.com/Trust-Code/account-payment.git
RUN git clone -b 8.0 https://github.com/Trust-Code/account-invoicing.git
RUN git clone -b 8.0 https://github.com/Trust-Code/odoo-brazil-banking.git
RUN git clone -b 8.0 https://github.com/Trust-Code/trust-themes.git
RUN git clone -b 8.0 http://github.com/OCA/sale-workflow.git
RUN git clone -b 8.0 https://github.com/OCA/bank-statement-import.git
RUN git clone -b 8.0 https://github.com/OCA/bank-statement-reconcile.git
RUN git clone -b 8.0 http://github.com/OCA/bank-payment.git
RUN git clone -b 8.0 https://github.com/OCA/web.git
RUN git clone -b 8.0 https://github.com/OCA/project.git
RUN git clone -b master https://github.com/Trust-Code/odoo-project_scrum.git scrum

RUN mkdir private

RUN chown -R odoo /mnt/extra-addons
VOLUME ["/var/lib/odoo", "/mnt/extra-addons"]

# Expose Odoo services ports
EXPOSE 8069 8071

### update and change owner
#RUN apt-get update
RUN chown -R odoo:odoo /opt/odoo

# Add required Locale
RUN echo "en_US ISO-8859-1" >> /etc/locale.gen
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "pt_BR ISO-8859-1" >> /etc/locale.gen
RUN echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen

# Set default user when running the container

USER odoo
ENTRYPOINT ["/entrypoint.sh"]

