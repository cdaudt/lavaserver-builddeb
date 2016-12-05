### Deb generator for lavapdu-daemon
This is a simple script that uses docker to generate the deb files for lavapdu
It starts from 2 git repos, one for the sources and one for the package info

### Usage
As a pre-requisite, you need docker installed and running, and a user that has access to it
Once you have that, you can invoke the script as follows:

> $ ./gen_deb.sh <pkg-url\> <pkg-branch\> <src-url\> <src-branch\>

For example, to build from the linaro sources in github:
> $ ./gen_deb.sh https://github.com/linaro/pkg-lava-server.git master https://github.com/linaro/lava-server.git master

This will generate the following deb files in the *build* subdirectory:
````
lavapdu-client_0.0.5-2_all.de
lavapdu-daemon_0.0.5-2_all.de
````
Please note that it leaves files strewn around with root ownership as a side-effect of the build, so you need sudo access to clear it out.

### TODO
 - Generates a hardcoded version number at the moment
