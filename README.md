# dockerized-odoo
build docker image for odoo brazil 

1 - Clone the repo 

2 - Execute the script auto_create.sh 

3 - provide the required parameters as shown below

    Usage auto_create.sh addons_path_on_host docker_image_name docker_container_name

	Example :
	
    auto_create.sh /opt/odoo-addons ubuntu/odoo:v8 odoo8_br
		  		  
	          
4 - Script will pull a postgres image and create odoo image, then download localization modules for brazil, 
finally will start the containers 

5 - If Everything went fine , you should be able to access the odoo container with brazil modules from your browser using port 8069

6 -  Script is still under testing , if you faced any problems/bugs please create an issue 

7 - All contributions are more than welcome, if you have something to add please start a pull request
