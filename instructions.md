# проект
export GOOGLE_PROJECT=keen-phalanx-223413

# создание
docker-machine create --driver google \
    --google-machine-image https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts \
    --google-machine-type n1-standard-1 \
    --google-zone europe-west1-b \
    --google-disk-size=50 \
    docker-host

# переколючение
eval $(docker-machine env docker-host)


# docker url
DOCKER_URL=$(docker-machine ls --format "{{.URL}}" --filter name=docker-host)
DOCKER_IP=${DOCKER_URL:6:-5}
echo $DOCKER_IP


# ip-address to persistent
gcloud compute addresses create [ADDRESS_NAME] \
  --addresses [IP_ADDRESS] --region [REGION]
where:

[ADDRESS_NAME] is the name you want to call this address.
[IP_ADDRESS] is the IP address you want to promote.
[REGION] is the region the IP address belongs to.

example:

gcloud compute addresses create docker-host \
  --addresses $DOCKER_IP \
  --region europe-west1

## delete OLD adress
gcloud compute addresses delete docker-host --region europe-west1


# traefik
docker run -d -p 8080:8080 -p 80:80 -v $PWD/traefik.toml:/etc/traefik/traefik.toml -v /var/run/docker.sock:/var/run/docker.sock traefik

`file should be on server! by path  /opt/traefik/traefik.toml`
docker run -d -p 8080:8080 -p 80:80 -v /opt/traefik/traefik.toml:/etc/traefik/traefik.toml -v /var/run/docker.sock:/var/run/docker.sock traefik


# firewall
WEB:
gcloud compute --project=keen-phalanx-223413 firewall-rules create allow-80-8080 --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80,tcp:8080 --source-ranges=0.0.0.0/0 --target-tags=docker-machine
SSH:
gcloud compute --project=keen-phalanx-223413 firewall-rules create allow-22 --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:22 --source-ranges=0.0.0.0/0 --target-tags=docker-machine

# test nginx
docker run --name nginx -d nginx


# connect
ssh -i ~/.ssh/docker-host docker-user@$DOCKER_IP

# ansible
maked config file
check: `ansible -i inventory docker -a "free"`
sudo apt install python-pip
sudo pip install docker-py

