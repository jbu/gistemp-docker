# get docker machine https://docs.docker.com/machine/
docker-machine create --driver virtualbox gt
#docker-machine create --driver google --google-zone=europe-west1-d --google-machine-type=n1-highmem-8 --google-project=xxxxxxxxxxxxx --google-scopes "https://www.googleapis.com/auth/devstorage.full_control,https://www.googleapis.com/auth/logging.write"  gt
#docker-machine start gt
$(docker-machine env gt)
docker $(docker-machine config gt) build -t gistemp gistemp/ 
docker $(docker-machine config gt) run -it gistemp bash 
#docker-machine stop gt
#docker-machine rm gt
