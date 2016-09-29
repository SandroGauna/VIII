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
	        python-dateutil python-decorator \
		python-docutils python-feedparser python-gdata python-gevent \
		python-imaging python-jinja2 python-ldap python-libxslt1 python-lxml \
		python-mako python-mock python-openid python-passlib python-psutil \
		python-psycopg2 python-pybabel python-pychart python-pydot \
		python-pyparsing python-pypdf python-reportlab python-requests \
		python-simplejson python-tz python-unittest2 python-vatnumber \
		python-vobject python-werkzeug python-xlwt python-yaml wkhtmltopdf git vim nano 

### add user "odoo" which will be used to run odoo
RUN useradd -ms /bin/bash odoo	&& chown -R odoo /opt && chown -R odoo /var

### Clone Odoo Repo     
RUN set -x; \
	cd /opt \
#	&& apt-get update \
#       && apt-get install -y git \
        && git clone https://www.github.com/odoo/odoo --depth 1 --branch 8.0 --single-branch
    

###Copy entrypoint script and Odoo configuration file
COPY ./entrypoint.sh /
COPY ./openerp-server.conf /etc/odoo/ \
&& chown odoo /etc/odoo/openerp-server.conf \
### Install deps repos
RUN set -x; \
    mkdir -p /opt/depslibs \
      && cd /opt/depslibs \
      && git clone https://github.com/ahmedgenina/pyxmlsec-0.3.1.git \
      && cd pyxmlsec-0.3.1 \
      && python setup.py install \
      && cd /opt/depslibs \
      && git clone https://github.com/ahmedgenina/geraldo.git \
      && cd geraldo \
      && python setup.py install \
      && cd /opt/depslibs \
      && git clone https://github.com/ahmedgenina/PySPED.git \
      && cd PySPED \
      && python setup.py install \
      && cd /opt/depslibs \
      && git clone https://github.com/ahmedgenina/pyboleto.git \
      && cd PyCNAB \
      && python setup.py install \
      && cd /opt/depslibs \
      && git clone https://github.com/ahmedgenina/PyCNAB.git \
      && cd PyCNAB \
      && python setup.py install \
        
# Mount /var/lib/odoo to allow restoring filestore and /mnt/extra-addons for users addons
RUN mkdir -p /mnt/extra-addons \
&& chown -R odoo /mnt/extra-addons
VOLUME ["/var/lib/odoo", "/mnt/extra-addons"]

# Expose Odoo services ports
EXPOSE 8069 8071

### update and change owner
RUN apt-get update 
RUN chown -R odoo:odoo /opt/odoo

# Set default user when running the container
USER odoo
ENTRYPOINT ["/entrypoint.sh"]

