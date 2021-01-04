# MongoDB
sudo docker pull mongo
sudo docker run -itd -p 27017:27017 mongo

# Cuckoo
sudo docker run -itd --privileged \
-p 8080:8080 -p 5900:5900 \
-v /root/images:/vms \
byamao1/cuckoo:1.0 web
