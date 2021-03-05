#!/usr/bin/env bash

set -e
ver=`/usr/bin/env python -c "from __future__ import print_function;import sys;print(sys.version[0])"`
if [ $? -ne 0 ];then
	echo "Could find any python installation."
	exit 1
fi
pyexe=`which python`
if [ $ver -ne 3 ]; then
	which python3 1>/dev/null 2>&1
	if [ $? -ne 0 ];then
		echo "Could not find any python3 installation."
		exit 1
	fi
	pyexe=`which python3`
fi

install_path="/usr/local/bin/"

cp promptly $install_path
if [ $? -ne 0 ];then
	echo "Unable to copy files to "$install_path\
			 ". Try running the script as sudo e.g. > sudo ./install.sh"
	exit 1
fi

echo "promptly installed in "$install_path

