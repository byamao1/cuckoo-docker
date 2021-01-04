#!/bin/bash

function main(){
local task=$1
if [ -z "$task" ]
then
    task='default'
fi

if [ "$task" == "default" ]
then
    bash
    return 0
fi

if [ "$task" == "web" ]
then
    service libvirtd start
    virsh net-start default  

    nohup cuckoo web runserver 0.0.0.0:8080&
    nohup cuckoo api --host 0.0.0.0 --port 8090&
    cuckoo -d
    #nohup cuckoo --cwd /cuckoo web  runserver 0.0.0.0:8080&
    #cuckoo --cwd /cuckoo -d

    return 0
fi

if [ "$task" == "debug" ]
then
    service libvirtd start
    virsh net-start default
    echo '[+] Starting Cuckoo Sandbox Virtual Machine'
    virsh start CuckooSandbox
    echo '[+] Virtual Machine is booting'
    while true
    do
        sleep 5
        echo '[+] VM is up'
    done
    return 0
fi

echo '[-] Command not found '$task
return -1

}

main $@
