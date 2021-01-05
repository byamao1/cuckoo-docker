FROM strm/cuckoo

LABEL maintainer="Tom"

RUN mkdir /root/.pip
COPY .pip/pip.conf /root/.pip
RUN echo "nameserver 223.5.5.5" >> /etc/resolv.conf && \
    apt-get update && pip install --upgrade pip setuptools

# Modify cpu config
COPY CuckooSandbox-Windows8.1.xml /etc/libvirt/qemu  
COPY reporting.conf /cuckoo/conf
# Add dsn; Modify ips for visiting internet
COPY kvm.conf /cuckoo/conf

RUN apt-get install -y swig
RUN pip install -U pyOpenSSL && \
    pip uninstall -y yara && pip install yara-python==3.6.3
RUN pip install m2crypto==0.24.0
RUN pip install cuckoo==2.0.7

COPY cuckoo.conf /cuckoo/conf
COPY community-master.tar.gz /data
RUN cuckoo --cwd /cuckoo community --file /data/community-master.tar.gz
RUN mv /cuckoo /root/.cuckoo
COPY snapshot /var/lib/libvirt/qemu/snapshot/

EXPOSE 5900
EXPOSE 8080
EXPOSE 8090
VOLUME /vms

COPY main.sh /

ENTRYPOINT ["/main.sh"]
CMD ["default"]
