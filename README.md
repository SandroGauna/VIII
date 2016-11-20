# dockerized-odoo
build docker image for odoo brazil 

1 - Clone the repo 

2 - Execute the script auto_create.sh 

3 - provide the required parameters as shown below

	Example :
	
                  auto_create.sh /opt/odoo-addons ubuntu/odoo:v8_1 odoo_built_1
		  		  
	          
4 - Script will pull a postgres image and create odoo image, then download localization moodules for brazil, 
finally will start the containers 

5 - If Everything went fine , you should be able to access the odoo container with brazil modules from your browser using port 8069

6 -  Script is still under tetsing , if you faced any problmes/bugs please create an issue 

7 - All contributions are more than welcome, if you have somthing to add please start a pull request
