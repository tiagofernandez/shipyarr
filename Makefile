# This Makefile is designed to be included in app-specific Makefiles.

.DEFAULT_GOAL := help
.PHONY: help

help: # https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-z0-9A-Z_-]+:.*?## .*$$' Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

#  ____             _             
# |  _ \  ___   ___| | _____ _ __ 
# | | | |/ _ \ / __| |/ / _ \ '__|
# | |_| | (_) | (__|   <  __/ |   
# |____/ \___/ \___|_|\_\___|_|   

IMAGE := $(NAMESPACE)/$(APP)
VERSION := latest

docker-build: ## Build the Docker image.
	docker build -t $(IMAGE):$(VERSION) .

docker-debug: ## Debug the running container.
	docker exec -ti $(shell docker ps | grep $(IMAGE):$(VERSION) | awk '{print $$1}') /bin/sh

docker-run: ## Run a detached container.
	docker run --restart=always -p $(PORT):$(PORT) -d $(IMAGE):$(VERSION)

docker-shell: ## Run an interactive container.
	docker run -p $(PORT):$(PORT) -ti $(IMAGE):$(VERSION) /bin/sh

docker-stop: ## Stop the detached container.
	docker stop $(shell docker ps | grep $(IMAGE):$(VERSION) | awk '{print $$1}')

#  _  __       _                               _             
# | |/ /_   _ | |__    ___  _ __  _ __    ___ | |_  ___  ___ 
# | ' /| | | || '_ \  / _ \| '__|| '_ \  / _ \| __|/ _ \/ __|
# | . \| |_| || |_) ||  __/| |   | | | ||  __/| |_|  __/\__ \
# |_|\_\\__,_||_.__/  \___||_|   |_| |_| \___| \__|\___||___/

k8s-apply: docker-build k8s-namespace ## Apply the Kubernetes configuration.
	kubectl apply -f kubernetes.yaml -n $(NAMESPACE)

k8s-debug: ## Debug the running service.
	kubectl exec -ti service/$(APP) -n $(NAMESPACE) -- sh

k8s-delete: ## Delete the applied configuration.
	kubectl delete -f kubernetes.yaml -n $(NAMESPACE)
	kubectl delete namespace $(NAMESPACE)

k8s-ingress: ## Deploy Ingress controller.
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.7.1/deploy/static/provider/cloud/deploy.yaml
	kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=120s

k8s-ingress-host: ## Append host to /etc/hosts, if not present.
	$(eval ENTRY := '127.0.0.1 $(APP).home.arpa')
	sudo -- sh -c -e "grep -qxF $(ENTRY) /etc/hosts || echo $(ENTRY) >> /etc/hosts"

k8s-namespace: ## Create Kubernetes namespace.
	kubectl create namespace $(NAMESPACE) --dry-run=client -o yaml | kubectl apply -f -

k8s-port-forward: ## Forward connection to local port.
	kubectl port-forward service/$(APP) $(PORT):80 -n $(NAMESPACE)
