# MongoDB
mongo_image=$(sudo docker images |grep "mongo"|awk '{print $1}')
if [ -z ${mongo_image} ]; then
    sudo docker pull mongo
    if [ $? -eq 0 ]; then
        echo "Pull mongo successfully."
    else
        echo "Pull mongo fail."
    fi
else
    echo "Already pull mongo: ${mongo_image}"
fi

mongo_proc=$(sudo docker ps |grep "mongo"|awk '{print $1}')
if [ -z ${mongo_proc} ]; then
    sudo docker run -itd -p 27017:27017 mongo
    if [ $? -eq 0 ]; then
        echo "Run container mongo successfully."
    else
        echo "Run container mongo fail."
    fi
else
    echo "Already run mongo: ${mongo_proc}"
fi

# Cuckoo
sudo docker run -itd --privileged \
    -p 8080:8080 -p 8090:8090 -p 5900:5900 \
    -v /root/images:/vms \
    byamao1/cuckoo:latest web

if [ $? -eq 0 ]; then
    echo "Run container cuckoo successfully."
else
    echo "Run container cuckoo fail."
fi