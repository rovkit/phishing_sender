FROM centos:7



MAINTAINER "European Environment Agency (EEA): IDM2 A-Team" <eea-edw-a-team-alerts@googlegroups.com>

EXPOSE 25

VOLUME ["/var/log", "/var/spool/postfix"]

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    yum updateinfo -y && \
    yum update -y glibc && \
    yum install -y python3 vim telnet postfix cyrus-sasl cyrus-sasl-plain mailx && \
    yum clean all

RUN python3 -m pip install chaperone

RUN mkdir -p /etc/chaperone.d
COPY chaperone.conf /etc/chaperone.d/chaperone.conf


COPY docker-setup.sh /docker-setup.sh


RUN chmod +x /docker-setup.sh

RUN rm /etc/postfix/transport
COPY etc_transport /etc/postfix/transport
RUN cat /etc/postfix/transport


RUN echo "transport_maps = hash:/etc/postfix/transport" >>  /etc/postfix/main.cf
#RUN postmap /etc/postfix/transport
#RUN  postfix reload

ENTRYPOINT ["/usr/local/bin/chaperone"]

