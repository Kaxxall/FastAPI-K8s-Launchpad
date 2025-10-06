INVENTORY_SERVICE_NAME = inventory-service
ORDER_SERVICE_NAME = order-service
IMAGE_TAG ?= latest

INVENTORY_IMAGE = $(INVENTORY_SERVICE_NAME):$(IMAGE_TAG)
ORDER_IMAGE = $(ORDER_SERVICE_NAME):$(IMAGE_TAG)

PROJECT_NAME := $(shell basename "$(CURDIR)")

.PHONY: all help clean \
        up down logs build \
        k8s-start k8s-stop k8s-build k8s-deploy k8s-delete k8s-status \
        k8s-forward-order k8s-forward-inventory


all: help

help:
	@echo "Makefile for the $(PROJECT_NAME) project"
	@echo "---------------------------"
	@echo "Usage: make [target]"
	@echo ""
	@echo "\033[1mAvailable Targets:\033[0m"
	@echo "  \033[36mup\033[0m                        Start services using Docker Compose."
	@echo "  \033[36mdown\033[0m                      Stop and remove Docker Compose services."
	@echo "  \033[36mlogs\033[0m                      Follow the logs of running services."
	@echo "  \033[36mbuild\033[0m                     Build Docker images for all services."
	@echo ""
	@echo "  \033[36mk8s-start\033[0m                 Start the Minikube cluster."
	@echo "  \033[36mk8s-stop\033[0m                  Stop the Minikube cluster."
	@echo "  \033[36mk8s-build\033[0m                 Build Docker images for Minikube."
	@echo "  \033[36mk8s-deploy\033[0m                Deploy the application to Kubernetes."
	@echo "  \033[36mk8s-delete\033[0m                Delete the application from Kubernetes."
	@echo "  \033[36mk8s-status\033[0m                Show the status of Pods and Services."
	@echo "  \033[36mk8s-forward-order\033[0m         Forward order-service to localhost:8001."
	@echo "  \033[36mk8s-forward-inventory\033[0m     Forward inventory-service to localhost:8000."
	@echo ""
	@echo "  \033[36mclean\033[0m                     Clean up all Docker and Kubernetes resources."
	@echo "  \033[36mhelp\033[0m                      Display this help message."


clean: down k8s-delete
	@echo "All resources have been cleaned up."

up: build
	docker-compose up -d

down:
	docker-compose down -v

logs:
	docker-compose logs -f

build:
	@echo "Building Docker images..."
	docker build -t $(INVENTORY_IMAGE) -f $(INVENTORY_SERVICE_NAME)/Dockerfile .
	docker build -t $(ORDER_IMAGE) -f $(ORDER_SERVICE_NAME)/Dockerfile .
	@echo "Images built successfully."

k8s-start:
	minikube start

k8s-stop:
	minikube stop

k8s-build:
	@echo "Setting Docker environment to Minikube and building images..."
	@eval $$(minikube -p minikube docker-env) && \
	docker build -t $(INVENTORY_IMAGE) -f $(INVENTORY_SERVICE_NAME)/Dockerfile . && \
	docker build -t $(ORDER_IMAGE) -f $(ORDER_SERVICE_NAME)/Dockerfile .
	@echo "Images successfully built for Minikube."

k8s-deploy:
	@echo "Applying Kubernetes manifests..."
	kubectl apply -f kubernetes_manifests/
	@echo "Deployment complete. Run 'make k8s-status' to check."

k8s-delete:
	@echo "Deleting Kubernetes resources..."
	kubectl delete -f kubernetes_manifests/ --ignore-not-found=true

k8s-status:
	@echo "\n--- Pods ---"
	@kubectl get pods -o wide
	@echo "\n--- Services ---"
	@kubectl get services -o wide

k8s-forward-order:
	@echo "Starting port-forward for order-service on localhost:8001. Press Ctrl+C to stop."
	kubectl port-forward service/order-service 8001:8001

k8s-forward-inventory:
	@echo "Starting port-forward for inventory-service on localhost:8000. Press Ctrl+C to stop."
	kubectl port-forward service/inventory-service 8000:8000