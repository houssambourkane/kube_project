# Triolanguage K8s mini cluster
This project aims to create a mini cluster with minikube node running inside it, and deploying an application pulled from a private repository on DockerHub.
The Webserver used is NGINX latest version
The Database used is Mariadb
PHP-FPM to which nginx forward the requests regarding .php extension in order to process the php web pages

### 1 - In order to test this cluster you would need to download Minikube on your computer 

> https://kubernetes.io/fr/docs/tasks/tools/install-minikube/

### 2 - To start minikube run the command
```
minikube start
```
### 3 - If you want to run the commands manually you can follow the STEPS file, on the other hand, to run the whole cluster with a single command use
```
make clusterUP
```
this command will build all the images needed, and apply some YAML files that will spin a multi-container pod which will include three containers :
- A container running triolanguage/webapp:1.0 image (this is a private image located in dockerhub registry) with php-fpm running inside it
- A container running my-nginx built image which is based on nginx:latest
- A container running my-mariadb built image which is based on mariadb:latest

### 4 - To get the URLs use the command
```
make getURL
```
### 5 - To down the cluster use the command
```
make clusterDOWN
```
