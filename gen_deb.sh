#!/bin/bash -e
# Generate lava-server deb file
# Requires docker installed

PKG_REPO=${1:-"https://github.com/cdaudt/pkg-lava-server.git"}
SRC_REPO=${2:-"https://github.com/cdaudt/lava-server.git"}
CLEAN=${3:-'no'}

echo "Using ${PKG_REPO} for packaging and ${SRC_REPO} for sources"

if [ ${CLEAN} = "yes" ]
then
  echo "Cleaning out old tree"
  rm -rf build
fi

# Start by building docker
docker build -t build-lava-on-debian dock

mkdir -p build
pushd build
  # clone the necessary repos
  # TODO: add branch/tag for each
  if [ ! -d pkg ]
  then
    git clone ${PKG_REPO} pkg
  fi
  if [ ! -d src ]
  then
    git clone ${SRC_REPO} src
  fi
  pushd src
    tar cfz ../lava-server_2016.11.orig.tar.gz . >/dev/null
    mv ../pkg/debian debian 
  popd
popd

# Run docker to build it
docker run -it --rm -v$PWD/build:/package build-lava-on-debian /bin/bash -c "cd /package/src;dpkg-buildpackage -us -uc "

# Delete docker

