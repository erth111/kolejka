#!/bin/bash

#load config; if no "-f" parameter look in /etc/kolejka/kolejka.conf
def_conf_path=/var/lib/kolejka/1.0/conf/kolejka.conf

########### parse arguments
while getopts "f:" opt; do
  case $opt in
    f)
      echo "-f was triggered! using config file $OPTARG" >&2;
      config=$OPTARG
      ;;
  esac
done

########### verify config file
#check if config file exists and load it
if [[ ! -z $config ]]  && [[ -e $config ]]; then
        echo "using $config config  path, it exists"
        source $config
else
        echo "looking for config file in default location..."
        if [ -e $def_conf_path ]; then
                echo "using default config path, file exists"
        else
                echo "no config found in $def_conf_path, exiting..."
                exit 1
        fi
fi

########## main loop
#pobranie stanu kolejek z WWW do pliku
/usr/bin/curl $url > $dst_path_html
