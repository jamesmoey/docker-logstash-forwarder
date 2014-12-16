FROM digitalwonderland/base

ENV GOPATH /var/lib/golang
ENV PATH $GOPATH/bin:$PATH

RUN mkdir $GOPATH

RUN yum install -y epel-release \
 && yum install -y hg git golang \
 && go get github.com/elasticsearch/logstash-forwarder \
 && go get github.com/tools/godep \
 && godep get github.com/digital-wonderland/docker-logstash-forwarder \
 && yum erase -y hg git golang perl cpp gcc glibc-devel glibc-headers kernel-headers libgnome-keyring openssh rsync \
 && yum clean all

ENTRYPOINT ["/var/lib/golang/bin/docker-logstash-forwarder"]
