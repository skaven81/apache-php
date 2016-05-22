FROM eboraas/apache-php
MAINTAINER Paul Krizak <paul.krizak@gmail.com>

RUN mv /etc/apache2/mods-available/userdir.* /etc/apache2/mods-enabled/ && \
        sed -i -e 's~UserDir public_html~UserDir /home/*/public_html~' /etc/apache2/mods-enabled/userdir.conf
RUN mv /etc/apache2/mods-available/autoindex.* /etc/apache2/mods-enabled/
RUN mv /etc/apache2/mods-available/status.* /etc/apache2/mods-enabled/ && \
        sed -i -e 's/Require local/#Require local/' \
               -e 's/#Require ip 192.0.2.0/Require ip 192.168.1.0/' \
               /etc/apache2/mods-enabled/status.conf
RUN sed -i -e 's/^LogLevel.*$/LogLevel info/' /etc/apache2/apache2.conf
