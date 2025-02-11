# Jenkins Pipeline for Docker Image Build & Push

## Overview
This repository contains a CI/CD pipeline that uses a Docker container as a **slave** to build, tag, and push Docker images. The pipeline automates the process of building Docker images, tagging them with a version, and pushing them to a Docker registry (e.g., Docker Hub, AWS ECR).
## Prerequisites
- Jenkins installed and running.
- Docker installed on the Jenkins host.
- **Docker Pipeline Plugin** installed in Jenkins.
- A valid **Docker Hub account**.
- Jenkins credentials configured (`docker-hub-credentials` for username/password).

## Pipeline Workflow
1. Clones the repository from GitHub.
2. Builds the Docker image.
3. Tags the image.
4. Logs into Docker Hub.
5. Pushes the image to Docker Hub.

## How to Run
1. **Create a New Pipeline Job in Jenkins.**
2. **Select "Pipeline script from SCM"** and provide the repository URL.
3. **Ensure Jenkins has access to Docker** (Bind `/var/run/docker.sock` if needed).
4. **Run the Job.**

