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
		source $def_conf_path
        else
                echo "no config found in $def_conf_path, exiting..."
                exit 1
        fi
fi
########### main loop

#convert html to CSV (semicolon separated)
grep -e 'bold">.*<\/span>' $dst_path_html -e '<td style="font-weight: bold">' -e '<td>' | awk 'match($0,/bold">.*<\/span>/) {print "LOC:" substr($0,RSTART+6,RLENGTH-13)}; match($0,/Ostatnia aktualizacja .*<\/p>/) {print "TIMESTAMP" substr($0,RSTART+21,RLENGTH-25)}; match($0,/td>.*<\/td/) {print substr($0,RSTART+3,RLENGTH-7)};' | awk 'BEGIN {}; /LOC/ {loc=$0; next}; /TIMESTAMP/ {time=$0;next}{line=loc ";" time ";" $0; getline; line=line ";" $0; getline;line=line ";" $0; getline;line=line ";" $0; print line; next; next; next; next}' | sed 's/TIMESTAMP //g' | sed 's/^ //' >> $dst_path_csv

rm $dst_path_html
