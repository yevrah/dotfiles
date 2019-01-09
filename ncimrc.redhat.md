
Building Neovim on Redhat 6
===========================

This process works for Neovim 0.32

  # Requirements
  $ sudo yum -y install libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip
  $ git clone https://github.com/neovim/neovim.git
  $ make CMAKE_BUILD_TYPE=Release
  $ sudo make install

Install IUS Community Packages
==============================
IUS is a community project that provides RPM packages for newer versions of
select software for Enterprise Linux distributions.

  $ curl 'https://setup.ius.io/' -o setup-ius.sh

Additional, add the python bindings   - python2

  $ sudo yum install epel-release                 # Extra Packages for Enterprise Linux)
  $ sudo yum upgrade python-setuptools
  $ sudo yum install python-pip python-wheel
  $ pip install neovim

Add python 3

  $ sudo yum install python-devel
  $ sudo yum install epel-release
  $ sudo yum install python3 python3-wheel
  $ pip install neovim
