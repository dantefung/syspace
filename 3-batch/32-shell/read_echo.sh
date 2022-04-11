#!/bin/bash

Usage(){
    echo "USAGE: /bin/bash /home/yanta/read_echo.sh"
    echo "USAGE: This script is to test reading input arguments"
}

Read(){
    echo -ne "Please input your name: "
    read name
    echo "Your name is $name"
}

main(){
    [ $# -ne 0 ] && {
        Usage
        exit -1
    }

    Read
}

main $*