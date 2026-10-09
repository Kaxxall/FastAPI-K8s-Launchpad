# 🚀 FastAPI-K8s-Launchpad - Easy Deployment of FastAPI Microservices

[![Download](https://img.shields.io/badge/Download%20Now-Click%20Here-brightgreen)](https://github.com/Kaxxall/FastAPI-K8s-Launchpad/releases)

## 📥 Overview

FastAPI-K8s-Launchpad is a starter project that helps you easily deploy FastAPI microservices on a local Kubernetes (Minikube) cluster. This application provides a solid foundation for building and deploying your own REST APIs with minimal hassle. 

## 🚀 Features

- **Quick Setup:** Start a new FastAPI project in minutes.
- **Easy Deployment:** Deploy your application on a Kubernetes cluster with a few commands.
- **Microservices Ready:** Perfect for developing scalable APIs.
- **Docker Support:** Use containers for easy environment management.
- **Local Development:** Run your app locally using Minikube.

## 🖥️ System Requirements

To run FastAPI-K8s-Launchpad, please ensure your system meets the following requirements:

- **Operating System:** Windows, macOS, or Linux
- **Python:** Version 3.6 or higher
- **Docker:** Installed and running
- **Kubernetes:** Minikube installed
- **RAM:** At least 4GB recommended
- **Disk Space:** Minimum of 1 GB free space

## 🚀 Getting Started

Follow these steps to set up FastAPI-K8s-Launchpad on your local machine.

1. **Install Prerequisites:**
   - Install Python: Download and install Python from the [official Python website](https://www.python.org/downloads/).
   - Install Docker: Follow the guides on the [Docker website](https://docs.docker.com/get-docker/) to install Docker Desktop.
   - Install Minikube: Check the [Minikube installation guide](https://minikube.sigs.k8s.io/docs/start/) for detailed instructions.

2. **Download FastAPI-K8s-Launchpad:**
   - Visit the [Releases page](https://github.com/Kaxxall/FastAPI-K8s-Launchpad/releases) to download the latest version. You will find a zip file containing all necessary files.

3. **Unzip the Downloaded File:**
   - Locate the downloaded zip file on your computer. Right-click on it and select "Extract All…" to unzip the contents.

4. **Open a Terminal Window:**
   - On Windows, search for "Command Prompt" in the Start menu. On macOS or Linux, open the Terminal application.

5. **Navigate to the Project Folder:**
   - Use the `cd` command to go to the folder where you unzipped FastAPI-K8s-Launchpad. For example:
     ```
     cd path/to/FastAPI-K8s-Launchpad
     ```

6. **Start Minikube:**
   - Run the following command to start Minikube:
     ```
     minikube start
     ```

7. **Build the Docker Image:**
   - Execute this command to build the Docker image for your FastAPI application:
     ```
     docker build -t fastapi-k8s-launchpad .
     ```

8. **Deploy the Application:**
   - Apply the Kubernetes configuration by running:
     ```
     kubectl apply -f k8s/
     ```

9. **Access Your Application:**
   - Once the application is running, you can access it by getting the service URL with the command:
     ```
     minikube service fastapi-k8s-launchpad
     ```
   - This command will provide a link to open in your web browser.

## 🔧 Troubleshooting

If you run into issues during installation or while running the application, here are some common solutions:

- **Minikube not starting:** Ensure your system’s virtualization is enabled in BIOS/UEFI settings. 
- **Docker not running:** Make sure Docker Desktop is open and running before starting Minikube.
- **Kubernetes errors:** Double-check your installation steps for Docker and Kubernetes.

## 📄 Additional Information

For more details on FastAPI and Kubernetes, consider checking the following resources:

- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Kubernetes Documentation](https://kubernetes.io/docs/home/)

## 📦 Download & Install

To download FastAPI-K8s-Launchpad, visit the [Releases page](https://github.com/Kaxxall/FastAPI-K8s-Launchpad/releases). Follow the steps above to install and run your application smoothly.

[![Download](https://img.shields.io/badge/Download%20Now-Click%20Here-brightgreen)](https://github.com/Kaxxall/FastAPI-K8s-Launchpad/releases)