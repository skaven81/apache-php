FROM eboraas/apache-php
MAINTAINER Paul Krizak <paul.krizak@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive LANG=en_US.UTF-8 LC_ALL=C.UTF-8 LANGUAGE=en_US.UTF-8
RUN apt-get -q update && \
    apt-get install -qy php5-gd && \
    apt-get clean && \
    rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mv /etc/apache2/mods-available/userdir.* /etc/apache2/mods-enabled/ && \
        sed -i -e 's~UserDir public_html~UserDir /home/*/public_html~' /etc/apache2/mods-enabled/userdir.conf
RUN mv /etc/apache2/mods-available/autoindex.* /etc/apache2/mods-enabled/
RUN mv /etc/apache2/mods-available/status.* /etc/apache2/mods-enabled/ && \
        sed -i -e 's/Require local/#Require local/' \
               -e 's/#Require ip 192.0.2.0/Require ip 192.168.1.0/' \
               /etc/apache2/mods-enabled/status.conf
RUN sed -i -e 's/^LogLevel.*$/LogLevel info/' /etc/apache2/apache2.conf
RUN echo "ServerName geofront.dyndns.info" >> /etc/apache2/apache2.conf

ADD run.sh /run.sh

ENTRYPOINT [ "/run.sh" ]
CMD [ "-D", "FOREGROUND" ]
