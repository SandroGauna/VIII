FROM ubuntu:latest
MAINTAINER Datashow LTDA <Ahmed-Genina>

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
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
#	        python-support \
	        python-dateutil python-decorator \
		python-docutils python-feedparser python-gdata python-gevent \
		python-imaging python-jinja2 python-ldap python-libxslt1 python-lxml \
		python-mako python-mock python-openid python-passlib python-psutil \
		python-psycopg2 python-pybabel python-pychart python-pydot \
		python-pyparsing python-pypdf python-reportlab python-requests \
		python-simplejson python-tz python-unittest2 python-vatnumber \
		python-vobject python-werkzeug python-xlwt python-yaml wkhtmltopdf git vim nano 
#RUN  curl -o wkhtmltox.deb -SL http://nightly.odoo.com/extra/wkhtmltox-0.12.1.2_linux-jessie-amd64.deb \
#	        && echo '40e8b906de658a2221b15e4e8cd82565a47d7ee8 wkhtmltox.deb' | sha1sum -c - \
#	        && dpkg --force-depends -i wkhtmltox.deb \
#	        && apt-get -y install -f --no-install-recommends \
#	        && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false npm \
#	        && rm -rf /var/lib/apt/lists/* wkhtmltox.deb
RUN useradd -ms /bin/bash odoo	&& chown -R odoo /opt && chown -R odoo /var
# Install Odoo
#ENV ODOO_VERSION 8.0
#ENV ODOO_RELEASE 20160726
        #curl -o odoo.deb -SL http://nightly.odoo.com/${ODOO_VERSION}/nightly/deb/odoo_${ODOO_VERSION}.${ODOO_RELEASE}_all.deb \
        #&& echo '6679fad48c761cf8587faa243afcfc17f5a9eb73 odoo.deb' | sha1sum -c - \
        #&& dpkg --force-depends -i odoo.deb \
        #&& apt-get update \
        #&& apt-get -y install -f --no-install-recommends \
        #&& rm -rf /var/lib/apt/lists/* odoo.deb
        # WORKDIR "/opt/"
RUN set -x; \
cd /opt && git clone https://www.github.com/odoo/odoo --depth 1 --branch 8.0 --single-branch
        # Copy entrypoint script and Odoo configuration file
COPY ./entrypoint.sh /
COPY ./openerp-server.conf /etc/odoo/
RUN chown odoo /etc/odoo/openerp-server.conf

# Mount /var/lib/odoo to allow restoring filestore and /mnt/extra-addons for users addons
RUN mkdir -p /mnt/extra-addons \
        && chown -R odoo /mnt/extra-addons
VOLUME ["/var/lib/odoo", "/mnt/extra-addons"]

# Expose Odoo services
EXPOSE 8069 8071

# Set the default config file
ENV OPENERP_SERVER /etc/odoo/openerp-server.conf
RUN apt-get update
# Set default user when running the container
USER odoo
ENTRYPOINT ["/entrypoint.sh"]
#CMD ["openerp-server"]

