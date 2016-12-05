FROM debian:jessie-backports

RUN \
 apt-get update && \
 apt-get upgrade -y

RUN \
 DEBIAN_FRONTEND=noninteractive apt-get -t jessie-backports install -y \
  build-essential \
  debhelper \
  dh-python \
  node-uglify  \
  libjs-excanvas \
  libjs-jquery-cookie \
  libjs-jquery \
  libjs-jquery-watermark \
  libjs-jquery-flot  \
  libjs-jquery-ui \
  python-all-dev \
  python-sphinx \
  python-sphinx-bootstrap-theme \
  po-debconf \
  python-mocker \
  python-setuptools \
  python-yaml \
  git \
  docbook-xsl \
  xsltproc
