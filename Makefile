# Color
BLACK = \e[30m
RED = \e[31;52m
RED_BOLD = \e[1;31m
GREEN = \e[32m
GREEN_BOLD = \e[1;32m
YELLOW = \e[33m
YELLOW_UNDERLINE = \e[4;33m
BLUE = \e[34m
BLUE_BOLD = \e[1;34m
MAGENTI = \e[35m
MAGENTI_BOLD = \e[1;35m
CYAN = \e[36m
WHITE = \e[37m
RESET= \e[0m

# Variables
REGISTRY_CRED_NAME = registry-cred
ENV_CM_NAME = env-vars
REGISTRY_SERVER = https://index.docker.io/v1/
REGISTRY_USER = triolanguage
REGISTRY_PASSWORD = Triolanguage-123
REGISTRY_EMAIL = triolanguage123@gmail.com
ENV_FILE = .env
DEPLOYMENT_NAME = triolanguage

# Rules
clusterUP: setClusterEnv
	@printf "$(WHITE)Building cluster...$(RESET)\n"
	@kubectl create secret docker-registry ${REGISTRY_CRED_NAME} --docker-server=${REGISTRY_SERVER} --docker-username=${REGISTRY_USER} --docker-password=${REGISTRY_PASSWORD} --docker-email=${REGISTRY_EMAIL}
	@kubectl create configmap ${ENV_CM_NAME} --from-env-file=${ENV_FILE}
	@kubectl apply -f pv.yaml
	@kubectl apply -f pvc.yaml
	@kubectl apply -f trio.yaml
	@kubectl expose deployment ${DEPLOYMENT_NAME} --type=NodePort
	@printf "✅ $(GREEN_BOLD)Cluster UP!$(RESET)\n"

getURL:
	@minikube service ${DEPLOYMENT_NAME} --url

setClusterEnv:
	@eval $(minikube -p minikube docker-env)
	@docker build -t my-nginx ./nginx/
	@docker build -t my-mariadb ./mariadb/

clusterDOWN:
	@printf "$(WHITE)Clearing cluster...$(RESET)\n"
	@kubectl delete deploy ${DEPLOYMENT_NAME}
	@kubectl delete svc ${DEPLOYMENT_NAME}
	@kubectl delete pvc trio-pvc
	@kubectl delete pv trio-storage-volume
	@kubectl delete cm ${ENV_CM_NAME}
	@kubectl delete secret ${REGISTRY_CRED_NAME}
	@printf "✅ $(GREEN_BOLD)Cluster DOWN!$(RESET)\n"

