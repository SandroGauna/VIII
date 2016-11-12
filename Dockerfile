FROM ubuntu:latest
MAINTAINER Datashow LTDA <Ahmed-Genina>

### Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends \
        ca-certificates \
	    curl \
	    node-less \
	    node-clean-css \
	    python-pyinotify \
	    python-renderpm \
		software-properties-common\
	    python-pip \
        python-setuptools \
        python-openssl \
        python-dev \
	    python-dateutil python-decorator \
		python-docutils python-feedparser python-gdata python-gevent \
		python-imaging python-jinja2 python-ldap python-libxslt1 python-lxml \
		python-mako python-mock python-openid python-passlib python-psutil \
		python-psycopg2 python-pybabel python-pychart python-pydot \
		python-pyparsing python-pypdf python-reportlab python-requests \
		python-simplejson python-tz python-unittest2 python-vatnumber \
		build-essential autoconf libtool pkg-config python-opengl python-imaging \
		python-pyrex python-pyside.qtopengl idle-python2.7 qt4-dev-tools qt4-designer \
		libqtgui4 libqtcore4 libqt4-xml libqt4-test libqt4-script libqt4-network libqt4-dbus python-qt4 \
		python-qt4-gl libgle3 python-vobject python-werkzeug python-xlwt python-yaml wkhtmltopdf git vim nano

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

# Mount /var/lib/odoo to allow restoring filestore and /mnt/extra-addons for users addons
RUN mkdir -p /mnt/extra-addons \
&& chown -R odoo /mnt/extra-addons
VOLUME ["/var/lib/odoo", "/mnt/extra-addons"]

# Expose Odoo services ports
EXPOSE 8069 8071

### update and change owner
RUN apt-get update 
RUN chown -R odoo:odoo /opt/odoo

# Add required Locale
RUN echo "en_US ISO-8859-1" >> /etc/locale.gen
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "pt_BR ISO-8859-1" >> /etc/locale.gen
RUN echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen

# Set default user when running the container

#USER odoo
#ENTRYPOINT ["/entrypoint.sh"]

