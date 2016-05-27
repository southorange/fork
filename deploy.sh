#!/bin/bash
set -e

#dependencies
sudo apt-get update
sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
sudo apt-get install --no-install-recommends libboost-all-dev
sudo apt-get install python-dev
sudo apt-get install ffmpeg

wget https://google-glog.googlecode.com/files/glog-0.3.3.tar.gz
tar zxvf glog-0.3.3.tar.gz
cd glog-0.3.3
./configure
make && make install

wget https://github.com/schuhschuh/gflags/archive/master.zip
unzip master.zip
cd gflags-master
mkdir build && cd build
export CXXFLAGS="-fPIC" && cmake .. && make VERBOSE=1
make && make install

git clone https://github.com/LMDB/lmdb
cd lmdb/libraries/liblmdb
make && make install

git clone https://github.com/BVLC/caffe.git
cd caffe
cp Makefile.config.example Makefile.config
make all
make test
make runtest


#actual usage
git clone https://github.com/kesara/deepdreamer.git
cd deepdreamer
wget https://github.com/BVLC/caffe/blob/master/models/bvlc_googlenet/deploy.prototxt
echo force_backward: true >> deploy.prototxt
wget https://github.com/BVLC/caffe/tree/master/models/bvlc_googlenet
python deepdreamer.py




