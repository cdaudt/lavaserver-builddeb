#!/bin/bash -e
# Generate lava-server deb file
# Requires docker installed

PKG_REPO=${1:-"https://github.com/cdaudt/pkg-lava-server.git"}
PKG_BRANCH=${2:-master}
SRC_REPO=${3:-"https://github.com/cdaudt/lava-server.git"}
SRC_BRANCH=${4:-master}

echo "Using ${PKG_REPO}:${PKG_BRANCH} for packaging and ${SRC_REPO}:${SRC_BRANCH} for sources"

if [ -d build ]
then
  echo "build directory is in the way. remove it first"
  exit 1
fi

# Start by building docker
docker build -t build-lava-on-debian dock

mkdir -p build
pushd build
  # clone the necessary repos
  if [ ! -d pkg ]
  then
    git clone -b ${PKG_BRANCH} ${PKG_REPO} pkg
  fi
  if [ ! -d src ]
  then
    git clone -b ${SRC_BRANCH} ${SRC_REPO} src
  fi
  pushd src
    tar cfz ../lavapdu_0.0.5.orig.tar.gz . >/dev/null
    mv ../pkg/debian debian 
  popd
popd

# Run docker to build it
docker run \
 -it \
 --rm \
 --volume $PWD/build:/package \
 build-lava-on-debian \
 /bin/bash -e -c \
 "cd /package/src; \
  dpkg-buildpackage -us -uc"

# Delete docker

