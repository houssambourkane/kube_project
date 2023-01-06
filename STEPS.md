## build triolanguage image
docker build -t triolanguage:1.0 .

## login to dockerhub
cat ./registry_password.txt | docker login --username triolanguage --password-stdin

## tag and push the image
docker tag triolanguage:1.0 triolanguage/webapp:1.0 
docker push triolanguage/webapp:1.0

## CHECK DIR EXIST
[ -d "/app/triolanguage" ] && git pull
 
## OR
[ ! -d "/app/triolanguage" ] && git clone https://github.com/houssambourkane/triolanguage.git /app/

## Create our own nginx image and own mariadb image
docker build -t my-nginx ./nginx/
docker build -t my-mariadb ./mariadb/


## Create docker registry secret
kubectl create secret docker-registry registry-cred --docker-server=https://index.docker.io/v1/ --docker-username=triolanguage --docker-password=Triolanguage-123 --docker-email=triolanguage123@gmail.com

## Create a configmap for environment variables
kubectl create configmap env-vars --from-env-file=.env

## To run docker environment in minikube's, we run
```
eval $(minikube -p minikube docker-env)
```
## create the resources
```
kubectl apply -f pv.yaml
kubectl apply -f pvc.yaml
kubectl apply -f trio.yaml
```
## Expose the app
```
kubectl expose deployment triolanguage --type=NodePort
```
## Get the URL accessible from outside the cluster
```
minikube service triolanguage --url
```
## Clear the cluster
```
kubectl delete deploy triolanguage
kubectl delete svc triolanguage
kubectl delete pvc trio-pvc
kubectl delete pv trio-storage-volume
```
## build cluster
```
kubectl apply -f pv.yaml
kubectl apply -f pvc.yaml
kubectl apply -f trio.yaml
kubectl expose deployment triolanguage --type=NodePort
```
## Run the whole cluster using makefile
```
make clusterUP
```
## Down the whole cluster using makefile
```
make clusterDOWN
```
## Get the url using makefile
```
make getURL
```
