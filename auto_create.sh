#!/bin/bash
#collect required user data
echo "Usage auto_create.sh  docker_image_name docker_container_name"

#build the image
sudo docker build -t $1 .

# Download postgres official container , and expose port 5432 to 5433 
sudo docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo -p 5433:5432 --name db postgres:9.4
sudo docker start db
# Create a container from our built odoo image with params : 
#mount extra addons directory from the host machine 
#export port 8069
#link to database container
# Trust version clone the repos from the docker file to the container so the volume mount would not be necessary anymore
#sudo docker run -v $1:/mnt/extra-addons -p 8069:8069 --name $2 --link db:db -t $1
sudo docker run -p 8069:8069 --name $2 --link db:db -t $1
# Start odoo container
sudo docker start $2





