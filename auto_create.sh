#!/bin/bash
#collect required user data
#echo "please choose path to save extra addons"
#read addons_path
#echo "please choose Docker image name"
#read docker_image
#echo "please choose Docker container name"
#read docker_container 

echo "USAGE auto_create.sh $extra_addons_path $2_name $3_name"


#build the image
sudo docker build -t $2 .

#create directory to save localization repos
mkdir -p $1
cd $1

# Clone required repos for Brazilian localization

#oca/ln10-brazil
git clone https://github.com/OCA/l10n-brazil.git --branch 8.0

#oca/server-tools
git clone https://github.com/OCA/server-tools.git --branch 8.0

#oca/account-fiscal-rules
git clone https://github.com/OCA/account-fiscal-rule.git --branch 8.0

#odoo-brazil-electronic-documents
git clone https://github.com/odoo-brazil/odoo-brazil-eletronic-documents.git

#odoo-brazil-sped
git clone https://github.com/odoo-brazil/odoo-brazil-sped.git

#Boleto : 
git clone https://github.com/OCA/bank-payment.git --branch 8.0

git clone https://github.com/OCA/bank-statement-import.git --branch 8.0

git clone https://github.com/OCA/account-payment.git --branch 8.0

git clone https://github.com/OCA/bank-statement-reconcile.git --branch 8.0

git clone https://github.com/Trust-Code/odoo-brazil-banking.git 

# Download postgres official container , and expose port 5432 to 5433 
sudo docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo -p 5433:5432 --name db postgres:9.4
sudo docker start db
# Create a container from our built odoo image with params : 
#mount extra addons directory from the host machine 
#export port 8069
#link to database container
sudo docker run -v $1:/mnt/extra-addons -p 8069:8069 --name $3 --link db:db -t $2
# Start odoo container
sudo docker start $3





