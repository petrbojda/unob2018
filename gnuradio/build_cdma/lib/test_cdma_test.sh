#!/bin/sh
export VOLK_GENERIC=1
export GR_DONT_LOAD_PREFS=1
export srcdir=/home/petr/Projects/Bajer/gnuradio/gr-cdma/lib
export GR_CONF_CONTROLPORT_ON=False
export PATH=/home/petr/Projects/Bajer/gnuradio/build_cdma/lib:$PATH
export LD_LIBRARY_PATH=/home/petr/Projects/Bajer/gnuradio/build_cdma/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$PYTHONPATH
test-cdma 
