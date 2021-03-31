This project is based on [strm/cuckoo](https://hub.docker.com/r/strm/cuckoo).   
When I ran [strm/cuckoo](https://hub.docker.com/r/strm/cuckoo), I found it exsiting many errors. So I decided to rebuild it.  
Change items as following:

|                   | strm/cuckoo                           | byamao1/cuckoo                               |
| ----------------- | ------------------------------------- | -------------------------------------------- |
| Cuckoo version    | 2.0.1                                 | 2.0.7                                        |
| Snapshot          | Making snapshots when starting docker | Importing snapshots when making docker image |
| Cuckoo Signatures | No                                    | Yes                                          |

# Architecture
```
.
│  run.sh    Run docker
│
└─docker
    │  build.sh                     Make docker image
    │  community-master.tar.gz
    │  cuckoo.conf
    │  CuckooSandbox-Windows8.1.xml
    │  Dockerfile
    │  kvm.conf
    │  main.sh
    │  reporting.conf
    │
    ├─.pip
    │
    └─snapshot      Snapshot configurations of qemu virtual machine
        
```
- `run.sh` is the script for running docker
- Directory `docker` contains files for making docker image

**Note**

`reporting.conf`:
```
[mongodb]
enabled = yes
host = 172.17.0.1   # This host ip is my docker host. You can set it as your mongoDB ip.
port = 27017
db = cuckoo
store_memdump = yes
```

# How to use
1.Pull docker
```
docker pull byamao1/cuckoo
```

2.Download windows images  
I had uploaded the windows images to Baidu pan:  
> [win7,win8.1](https://pan.baidu.com/s/1nc7paKWhCsaPEK-5rY_J1Q)  
Extraction code: ded8 

You can download *.7z at path (I use `/root/work/docker-cuckoo/vms`), then unzip them.
> Original image site: https://msdn.itellyou.cn/  
[win7]  
>ed2k://|file|en_windows_7_enterprise_x64_dvd_X15-70749.iso|3121215488|CB90BE6D74E6E661F8663BD7E17AD2FF|/  
[win8.1]  
>ed2k://|file|cn_windows_8.1_pro_vl_with_update_x64_dvd_6050873.iso|4317507584|B0888275B5BD40E67D3F178B84B9A874|/

3.Run docker
```
./run.sh
```
In `run.sh`, You can use other host path as image path:  
```
# Cuckoo
sudo docker run -itd --privileged \
    -p 8080:8080 -p 8090:8090 -p 5900:5900 \
    -v /root/work/cuckoo-docker/vms:/vms \  # You can replace /root/work/cuckoo-docker/vms with other path
    byamao1/cuckoo:1.0 web
```