# FastAPI-K8s-Launchpad 🚀

A comprehensive, beginner-friendly starter project that demonstrates how to build, containerize, and deploy a multi-service FastAPI application on a local Kubernetes cluster using Minikube.

This project is designed to be a **blueprint** for anyone moving from developing a monolithic application to adopting a cloud-native, microservices architecture. It bridges the gap between writing Python code and running it in an orchestrated, production-like environment.

### Core Technologies

| Technology | Role |
| :--- | :--- |
| **FastAPI** | Building high-performance, asynchronous API services. |
| **Docker** | Containerizing the individual microservices for portability. |
| **Kubernetes** | Orchestrating the containers (Pods, Deployments). |
| **Minikube** | Running a single-node Kubernetes cluster locally for development. |
| **HTTPX** | Enabling synchronous/asynchronous communication between services. |


### Key Learning Objectives

This repository provides a hands-on example of the following core concepts:

- **Microservice Design:** Splitting a logical application into smaller, independent services.
- **Containerization:** Creating efficient and reproducible container images for each service with `Dockerfile`.
- **Service Discovery:** Enabling services to find and communicate with each other within the Kubernetes cluster using `Service` objects.
- **Declarative Configuration:** Defining the desired state of the application using Kubernetes YAML manifests (`Deployment`, `Service`).
- **Local Development Workflow:** A complete guide on how to run and test a multi-container application on your local machine before pushing to a real cloud environment.

---
