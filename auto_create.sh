echo "please choose path to save extra addons"
read addons_path
echo "please choose Docker image name"
read docker_image
echo "please choose Docker container name"
read docker_container 
mkdir -p $addons_path
cd $addons_path
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

sudo docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo -p 5433:5432 --name db postgres:9.4
sudo docker start db
sudo docker build -t $docker_image .
sudo docker run -v /opt/odoodocker/addons:/mnt/extra-addons -p 8069:8069 --name $docker_container --link db:db -t $docker_image
sudo docker start $docker_container





