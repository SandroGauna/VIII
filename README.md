# dockerized-odoo
build docker image for odoo brazil 

1 - Clone the repo 
2 - Execute the script auto_create.sh 
3 - Answer the questions 
	Example : 
                  please choose path to save extra addons
		  /opt/odoo-addons
		  please choose Docker image name
		  ubuntu/odoo:v8_1
		  please choose Docker container name
	          odoo_built_1
4 - Script will pull a postgres image and create odoo image, then download localization moodules for brazil, 
finally will start the containers 
5 - If Everything went fine , you should be able to access a dockarized odoo container with brazil modules from your browser using port 8069
6 -  Script is still under tetsing , if you faced any problmes/bugs please create an issue 
7 - All contributions are more than welcome, if you have somthing to add please start a pull request
