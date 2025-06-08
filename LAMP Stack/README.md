# Deploying LAMP Stack on AWS Cloud

A LAMP stack is used in deploying web applications. It stands for Linux, Apache, MySql and PhP

Linux: The operating system and backbone of the LAMP stack

Apache: Web server which processes requests via HTTP to the internet

MySQL: used in creating and managing relational databases

PHP: represents the programming language

## Create EC2 Instances
Log on to the AWS console and create an EC2 Ubuntu VM instance. 

![Alt text](imgs/image1.png)


Connect to the machine using

```ssh -i <private_keyfile.pem> username@ip-address```

## Setting up Apache Web Server

We need to install apache to deploy the web application

```
$ sudo apt update

$ sudo apt install apache2
```
![Alt text](imgs/image2.png)

![Alt text](imgs/image3.png)

```
#starting apache2 Server
$ systemctl start apache2

#ensuring apache2 starts automatically on system boot
$ systemctl enable apache2

#checking status
$ systemctl status apache2
```
![Alt text](imgs/image4.png)

## Configure Security Group

When we initially created our instance a default TCP rule on port 22 was opened. This is what we used for the ssh connection. We would need to open TCP port 80 in order for us to have a connection to the internet

![Alt text](imgs/image5.png)

We can check our web application

![Alt text](imgs/image6.png)

## Installing MySQL and PHP

![Alt text](imgs/image7.png)

![Alt text](imgs/image8.png)

Check PHP version

![Alt text](imgs/image9.png)

Here we create a new directory called projectlampstack inside the /var/www/ directory.
sudo mkdir /var/www/projectstack

The we change permissions of the projectstack directory to the current user system

sudo chown -R $USER:$USER /var/www/projectstack

![Alt text](imgs/image9.png)


The projectstack directory represents the directory which will contains files related to our website. In order to spin up this server block we need to configure it by creating a .conf file.

sudo vi /etc/apache2/sites-available/projectstack.conf

The following represents the configuration needed to spin up the server block.

![Alt text](imgs/image10.png)

Run the following to activate the server

```
sudo a2ensite projectlampstack
sudo a2dissite 000-default # to deactivate the default webserver

sudo systemctl reload apache2
```
![Alt text](imgs/image11.png)

Create an index.html file inside the /var/www/projectstack

Go to the browser and open the webpage ```http://<public_ip_address>:80```

![Alt text](imgs/image12.png)

