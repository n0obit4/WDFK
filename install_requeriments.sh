#!/bin/bash
#Install requeriments for WDFK

#Colors
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
transparent="\e[0m"

#Verify Binary

which iwlist &> /dev/null
if [ "$?" -eq "1" ];then
    echo -e "$yellow""[""$red""*""$yellow""] iwlist"
    echo -e "Installing..."
    apt -y install iwlist &> /dev/null
    echo -e "$green""OK"
else
    echo -e "$yellow""[""$green""*""$yellow""] iwlist"
fi

which mdk4 &> /dev/null
if [ "$?" -eq "1" ];then
    echo -e "$yellow""[""$red""*""$yellow""] mdk4"
    echo -e "Installing..."
    apt -y install mdk4 &> /dev/null
    echo -e "$green""OK"
else
    echo -e "$yellow""[""$green""*""$yellow""] mdk4"
fi

which xterm &> /dev/null
if [ "$?" -eq "1" ];then
    echo -e "$yellow""[""$red""*""$yellow""] xterm"
    echo -e "Installing..."
    apt -y install xterm &> /dev/null
    echo -e "$green""OK"
else
    echo -e "$yellow""[""$green""*""$yellow""] xterm"
fi

which macchanger &> /dev/null
if [ "$?" -eq "1" ];then
    echo -e "$yellow""[""$red""*""$yellow""] macchanger"
    echo -e "Installing..."
    apt -y install macchanger &> /dev/null
    echo -e "$green""OK"
else
    echo -e "$yellow""[""$green""*""$yellow""] macchanger"
fi
which aircrack-ng &> /dev/null
if [ "$?" -eq "1" ];then
    echo -e "$yellow""[""$red""*""$yellow""] aircrack-ng"
    echo -e "Installing..."
    apt -y install aircrack-ng &> /dev/null
    echo -e "$green""OK"
else
    echo -e "$yellow""[""$green""*""$yellow""] aircrack-ng"
    exit 1
fi

echo -e "$green""All requeriments were installed"