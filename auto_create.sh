#!/bin/bash
#collect required user data
echo "Usage auto_create.sh  docker_image_name docker_container_name"

#build the image
sudo docker build -t $1 .

# Trust version clone the repos from the docker file to the container
#create directory to save localization repos
#mkdir -p $1
#cd $1
# Clone required repos for Brazilian localization
#oca/ln10-brazil
#git clone https://github.com/OCA/l10n-brazil.git --branch 8.0
#oca/server-tools
#git clone https://github.com/OCA/server-tools.git --branch 8.0
#oca/account-fiscal-rules
#git clone https://github.com/OCA/account-fiscal-rule.git --branch 8.0
#odoo-brazil-electronic-documents
#git clone https://github.com/odoo-brazil/odoo-brazil-eletronic-documents.git
#odoo-brazil-sped
#git clone https://github.com/odoo-brazil/odoo-brazil-sped.git
#Boleto :
#git clone https://github.com/OCA/bank-payment.git --branch 8.0
#git clone https://github.com/OCA/bank-statement-import.git --branch 8.0
#git clone https://github.com/OCA/account-payment.git --branch 8.0
#git clone https://github.com/OCA/bank-statement-reconcile.git --branch 8.0
#git clone https://github.com/Trust-Code/odoo-brazil-banking.git

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





