ssh root@host01 "apt-get -y update"
ssh root@host01 "apt-get install software-properties-common"
ssh root@host01 "apt-add-repository ppa:ansible/ansible"
ssh root@host01 "apt -y update"
ssh root@host01 "apt-get install ansible"
ssh root@host01 "apt install -y git"
ssh root@host01 "cd /home/scrapbook/tutorial"
ssh root@host01 "mkdir shared_volume"
ssh root@host01 "docker pull virtuant/ansible-node:v2"
ssh root@host01 "docker pull ubuntu:14.04"
ssh root@host01 "docker network create mynetwork"
ssh root@host01 "cd shared_volume"
ssh root@host01 "docker run -d --name ansible --rm --network mynetwork -v $(pwd):/shared_volume virtuant/ansible-node:v2 bash -c 'while true; do sleep 60; echo keepalive; done'"
ssh root@host01 "docker run -d --name target -p 8080 --rm --network mynetwork -v $(pwd):/shared_volume ubuntu:14.04 bash -c 'apt-get update; apt-get install -y openssh-server;service ssh start; while true; do sleep 60; echo keepalive; done'"
