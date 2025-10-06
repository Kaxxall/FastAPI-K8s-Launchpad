# FastAPI-K8s-Launchpad 

A comprehensive, beginner-friendly starter project that demonstrates how to build, containerize, and deploy a multi-service FastAPI application on a local Kubernetes cluster using Minikube.

This project is designed to be a **blueprint** for anyone moving from developing a monolithic application to adopting a cloud-native, microservices architecture. It bridges the gap between writing Python code and running it in an orchestrated, production-like environment.

---

### Core Technologies

| Technology | Role |
| :--- | :--- |
| **FastAPI** | Building high-performance, asynchronous API microservices. |
| **Poetry** | Managing dependencies for each isolated service. |
| **Docker** | Containerizing the individual microservices for portability. |
| **Docker Compose**| Running the multi-container application locally for quick testing. |
| **Kubernetes** | Orchestrating the containers (Pods, Deployments, Services). |
| **Minikube** | Running a single-node Kubernetes cluster on a local machine. |
| **Makefile** | Providing a simple command-line interface for all project operations. |


---

### Key Learning Objectives

This repository provides a hands-on example of the following core concepts:

- **Microservice Design:** Splitting a logical application into smaller, independent services.
- **Containerization:** Creating efficient and reproducible container images for each service with `Dockerfile`.
- **Service Discovery:** Enabling services to find and communicate with each other within the Kubernetes cluster using `Service` objects.
- **Declarative Configuration:** Defining the desired state of the application using Kubernetes YAML manifests (`Deployment`, `Service`).
- **Local Development Workflow:** A complete guide on how to run and test a multi-container application on your local machine before pushing to a real cloud environment.

---

## Project Architecture

This project consists of two simple microservices that communicate with each other:

1.  **`inventory-service`**
    *   Acts as the data source.
    *   It holds a static list of products (ID, name, price).
    *   Exposes endpoints to list all products or get a single product by its ID.

2.  **`order-service`**
    *   Handles the business logic.
    *   Exposes an endpoint to create a new order.
    *   Before creating an order, it makes an **internal HTTP request** to the `inventory-service` to validate the product and get its price.

This interaction is a classic example of inter-service communication within a microservices architecture.

---

## Prerequisites

Before you begin, ensure you have the following tools installed on your system:

*   [Docker Desktop](https://www.docker.com/products/docker-desktop/)
*   [Minikube](https://minikube.sigs.k8s.io/docs/start/)
*   [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
*   `make` 

---

## Getting Started

This project is managed via a `Makefile`, which simplifies all common tasks.

### Workflow 1: Running with Docker Compose (Quick Local Test)

This workflow is ideal for quickly testing the services on your local machine without Kubernetes.

1.  **Build and Start the Services:**
    This command will build the Docker images and start the containers in the background.
    ```bash
    make up
    ```

2.  **Test the Application:**
    You can now access the services:
    *   **Order Service Docs:** `http://localhost:8001/docs`
    *   **Inventory Service Docs:** `http://localhost:8000/docs`

3.  **Stop and Clean Up:**
    This will stop the containers and remove the network.
    ```bash
    make down
    ```


<br>

### Workflow 2: Deploying on Kubernetes with Minikube (Main Goal)

This is the core workflow of the project, demonstrating a full deployment cycle.

1.  **Start the Minikube Cluster:**
    This command initializes your local Kubernetes cluster. It may take a few minutes on the first run.
    ```bash
    make k8s-start
    ```

2.  **Build Images for Minikube:**
    This crucial step builds your Docker images *inside* Minikube's isolated Docker environment, making them available to the cluster.
    ```bash
    make k8s-build
    ```

3.  **Deploy the Application:**
    This command applies all the YAML manifests from the `kubernetes_manifests` directory to your cluster, creating the Deployments and Services.
    ```bash
    make k8s-deploy
    ```

4.  **Check the Status:**
    Verify that all Pods are in the `Running` state.
    ```bash
    make k8s-status
    ```

5.  **Access the Application:**
    To test the application from your local machine (e.g., Postman or a browser), you need to create a tunnel to the `order-service`. Open a **new terminal window** and run:
    ```bash
    make k8s-forward-order
    ```
    This will make the `order-service` available at `http://localhost:8001`. Keep this terminal open while testing.

6.  **Clean Up:**
    When you're finished, you can delete all the application resources from your cluster.
    ```bash
    make k8s-delete
    ```
    You can also stop the Minikube cluster itself to save system resources:
    ```bash
    make k8s-stop
    ```

---

## Testing the API

Once the application is running (either via Docker Compose or Kubernetes with port-forwarding), you can test the `order-service` endpoint.

**Example using `curl`:**
```bash
curl -X 'POST' \
  'http://localhost:8001/orders' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "product_id": 1,
  "quantity": 2
}
```

Expected Successful Response (201 Created):

```json
{
  "product_id": 1,
  "quantity": 2,
  "id": 1,
  "total_price": 2400,
  "status": "completed"
}
```

---

## Using the Makefile

The Makefile provides a convenient interface for all project tasks. Run make help to see all available commands.

```bash
$ make help
Makefile for the FastAPI-K8s-Launchpad project
---------------------------
Usage: make [target]

Available Targets:
  build                     Build Docker images for all services.
  clean                     Clean up all Docker and Kubernetes resources.
  down                      Stop and remove Docker Compose services.
  help                      Display this help message.
  k8s-build                 Build Docker images for Minikube.
  k8s-delete                Delete the application from Kubernetes.
  k8s-deploy                Deploy the application to Kubernetes.
  k8s-forward-inventory     Forward inventory-service to localhost:8000.
  k8s-forward-order         Forward order-service to localhost:8001.
  k8s-start                 Start the Minikube cluster.
  k8s-status                Show the status of Pods and Services.
  k8s-stop                  Stop the Minikube cluster.
  logs                      Follow the logs of running services.
  up                        Start services using Docker Compose.
```

---

## License
This project is licensed under the MIT License. 