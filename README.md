<div align="center">

# CloudPulse

**An end-to-end DevOps project that builds, containerizes, deploys, and monitors a Python REST API.**

![Python](https://img.shields.io/badge/Python-3.13-3776AB?style=flat-square&logo=python&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-REST_API-009688?style=flat-square&logo=fastapi&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Containerization-2496ED?style=flat-square&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestration-326CE5?style=flat-square&logo=kubernetes&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI%2FCD-2088FF?style=flat-square&logo=githubactions&logoColor=white)
![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-E6522C?style=flat-square&logo=prometheus&logoColor=white)
![Grafana](https://img.shields.io/badge/Grafana-Dashboard-F46800?style=flat-square&logo=grafana&logoColor=white)

[Overview](#overview) · [Architecture](#architecture) · [Running Locally](#running-locally) · [Kubernetes](#kubernetes-deployment) · [Monitoring](#monitoring-and-observability)

</div>

---

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Running Locally](#running-locally)
- [Running with Docker](#running-with-docker)
- [API Reference](#api-reference)
  - [Endpoints](#endpoints)
  - [Interactive Documentation (Swagger UI)](#interactive-documentation-swagger-ui)
- [CI/CD Pipeline](#cicd-pipeline)
  - [Workflow Steps](#workflow-steps)
  - [Pipeline Results](#pipeline-results)
- [Kubernetes Deployment](#kubernetes-deployment)
  - [Kubernetes Architecture](#kubernetes-architecture)
  - [Kubernetes Resources](#kubernetes-resources)
  - [Health and Resource Management](#health-and-resource-management)
  - [Deploying CloudPulse](#deploying-cloudpulse)
- [Monitoring and Observability](#monitoring-and-observability)
  - [Monitoring Components](#monitoring-components)
  - [Prometheus Setup](#prometheus-setup)
  - [Grafana Setup](#grafana-setup)
  - [Connecting Prometheus to Grafana](#connecting-prometheus-to-grafana)
  - [Dashboards](#dashboards)
- [Troubleshooting](#troubleshooting)
- [Future Improvements](#future-improvements)
- [Conclusion](#conclusion)

---

## Overview

CloudPulse is an end-to-end DevOps project that demonstrates how to build, containerize, deploy, and monitor a Python-based REST API.

The application is built with **FastAPI** and containerized with **Docker**. **GitHub Actions** automates application testing and Docker image publishing, while **Kubernetes** manages deployment and orchestration. **Prometheus** and **Grafana** collect and visualize application metrics, providing visibility into application performance and health.

The project brings together application development, CI/CD automation, container orchestration, and monitoring in a single workflow:

> **Code** → **Test** (Pytest) → **Build** (Docker) → **Publish** (Docker Hub) → **Deploy** (Kubernetes) → **Monitor** (Prometheus + Grafana)

---

## Key Features

**Application Development**

- REST API developed using FastAPI.
- Automated unit testing using Pytest.
- Health check, readiness, and metrics endpoints.
- Structured application logging.

**Containerization and CI/CD**

- Application containerization using Docker.
- Automated CI/CD pipeline using GitHub Actions.
- Automated testing and Docker image building.
- Docker image publishing to Docker Hub.

**Kubernetes Deployment**

- Kubernetes Deployments and Services.
- Namespace-based resource organization.
- ConfigMaps and Secrets for configuration management.
- Horizontal Pod Autoscaler (HPA) configuration.
- Ingress configuration for external access.
- CPU and memory requests and limits.
- Readiness and liveness probes.
- Graceful application startup and shutdown.

**Monitoring**

- Prometheus metrics endpoint.
- Prometheus configuration for metrics collection.
- Grafana dashboard configuration for metrics visualization.

---

## Architecture

<p align="center">
  <img src="https://github.com/user-attachments/assets/a2d18920-0e34-4e63-b81c-4f2a0f041def" alt="CloudPulse architecture diagram" width="900">
</p>

<p align="center"><em>Figure 1. CloudPulse end-to-end architecture.</em></p>

How the pieces fit together:

1. The FastAPI application is developed, tested with Pytest, and packaged as a Docker image.
2. GitHub Actions runs the test suite, builds the image, and publishes it to Docker Hub for deployment. See [CI/CD Pipeline](#cicd-pipeline).
3. Kubernetes runs and manages the containerized application. See [Kubernetes Deployment](#kubernetes-deployment).
4. Prometheus scrapes the application's `/metrics` endpoint, and Grafana visualizes the collected metrics. See [Monitoring and Observability](#monitoring-and-observability).

---

## Tech Stack

| Category | Technology |
|---|---|
| Programming Language | Python 3.13 |
| Framework | FastAPI |
| Application Server | Uvicorn |
| Testing | Pytest |
| Containerization | Docker |
| CI/CD | GitHub Actions |
| Container Registry | Docker Hub |
| Container Orchestration | Kubernetes |
| Metrics Collection | Prometheus |
| Metrics Visualization | Grafana |
| Version Control | Git & GitHub |

---

## Project Structure

```
CloudPulse/
│
├── app/
│   ├── main.py                        # FastAPI application entry point
│   ├── config.py                      # Application and environment configuration
│   ├── logger.py                      # Configurable structured logging
│   ├── metrics.py                     # Prometheus metrics and exposition
│   └── requirements.txt               # Python dependencies
│
├── tests/
│   └── test_api.py                    # Pytest API tests
│
├── k8s/
│   ├── namespace.yaml                 # Kubernetes namespace
│   ├── deployment.yaml                # Application Deployment
│   ├── service.yaml                   # Application Service
│   ├── ingress.yaml                   # Ingress routing
│   ├── configmap.yaml                 # Application configuration
│   ├── secret.yaml                    # Kubernetes Secret
│   ├── hpa.yaml                       # Horizontal Pod Autoscaler
│   ├── prometheus-configmap.yaml      # Prometheus configuration
│   ├── prometheus-deployment.yaml     # Prometheus Deployment
│   ├── prometheus-service.yaml        # Prometheus Service
│   ├── grafana-deployment.yaml        # Grafana Deployment
│   └── grafana-service.yaml           # Grafana Service
│
├── monitoring/
│   ├── prometheus.yml                 # Prometheus scrape configuration
│   └── grafana/
│       ├── datasource.yml             # Grafana data source provisioning
│       └── dashboard.json             # Grafana monitoring dashboard
│
├── .github/
│   └── workflows/
│       └── ci.yml                     # GitHub Actions CI/CD workflow
│
├── .dockerignore                      # Docker build context exclusions
├── .gitignore                         # Git ignore rules
├── Dockerfile                         # Container image definition
├── docker-compose.yml                 # Local container orchestration
├── pytest.ini                         # Pytest configuration
└── README.md                          # Project documentation

```
---

### Prerequisites

Ensure the following tools and environments are available before getting started:

| Task | Requirements |
|---|---|
| **Run locally** | Python 3.13, pip, and Git (for cloning the repository) |
| **Build and run with Docker** | Docker Engine and Docker CLI, with the Docker daemon running |
| **Deploy on Kubernetes** | A Kubernetes cluster (such as Minikube) and `kubectl` configured to access it |
| **Monitoring and Observability** | Prometheus and Grafana, deployed using the provided Kubernetes manifests |

**Note:** Prometheus and Grafana are deployed within the Kubernetes cluster using the manifests in the `k8s/` directory. Separate local installations are not required.

---

## Running Locally

### 1. Clone the Repository

```bash
git clone https://github.com/Sandeepkulkarni77/CloudPulse.git
cd CloudPulse
```

### 2. Create and Activate a Virtual Environment

Create an isolated Python environment for the project:

```bash
python3 -m venv .venv
```

Activate it:

**Linux / macOS**

```bash
source .venv/bin/activate
```

**Windows**

```powershell
.venv\Scripts\activate
```

Verify the Python version:

```bash
python --version
```

### 3. Install Dependencies

Upgrade pip and install the project dependencies:

```bash
python -m pip install --upgrade pip
pip install -r app/requirements.txt
```

### 4. Start the Application

Start the FastAPI application with Uvicorn:

```bash
uvicorn app.main:app --reload
```

The application starts on `http://127.0.0.1:8000`.

### 5. Verify the Endpoints

FastAPI provides interactive API documentation through Swagger UI. Open it in your browser:

```text
http://127.0.0.1:8000/docs
```

You can also test the application from the terminal with `curl`:

```bash
curl http://127.0.0.1:8000/           # Home endpoint
curl http://127.0.0.1:8000/health     # Health check
curl http://127.0.0.1:8000/ready      # Readiness check
curl http://127.0.0.1:8000/version    # Application version
curl http://127.0.0.1:8000/metrics    # Prometheus metrics
```

### 6. Run the Test Suite

Execute the automated tests with Pytest:

```bash
pytest
```

Pytest runs the available application tests and reports the results in the terminal.

### 7. Stop the Application

Press `Ctrl + C` in the terminal to stop the Uvicorn server, then deactivate the virtual environment:

```bash
deactivate
```

---

## Running with Docker

Docker packages CloudPulse and its dependencies into a container image, so the application runs consistently across environments without installing Python or its dependencies on the host machine.

### 1. Build the Docker Image

Make sure Docker is installed and running. From the root directory of the project, run:

```bash
docker build -t cloudpulse:latest .
```

<details>
<summary>Command breakdown</summary>

- `docker build` builds an image using the instructions in the Dockerfile.
- `-t cloudpulse:latest` assigns the image name `cloudpulse` and the tag `latest`.
- `.` specifies the current directory as the build context.

</details>

Verify that the image was created:

```bash
docker images
```

### 2. Run the Container

Start a container from the newly built image:

```bash
docker run -d \
  --name cloudpulse-container \
  -p 8000:8000 \
  cloudpulse:latest
```

<details>
<summary>Command breakdown</summary>

- `-d` runs the container in detached mode, in the background.
- `--name` assigns a name to the container.
- `-p 8000:8000` maps port 8000 on the host machine to port 8000 inside the container.
- `cloudpulse:latest` specifies the image used to create the container.

</details>

### 3. Verify the Running Container

```bash
docker ps        # running containers
docker ps -a     # all containers, including stopped ones
```

### 4. Access the Application

Once the container is running, the application is available at:

| Resource | URL |
|---|---|
| Application | `http://localhost:8000` |
| Swagger UI | `http://localhost:8000/docs` |
| Health endpoint | `http://localhost:8000/health` |

You can also test the health endpoint from the terminal:

```bash
curl http://localhost:8000/health
```

### 5. View Logs and Resource Usage

Inspect the application logs:

```bash
docker logs cloudpulse-container
```

Follow the logs continuously:

```bash
docker logs -f cloudpulse-container
```

View the container's live CPU and memory usage:

```bash
docker stats cloudpulse-container
```

### 6. Stop and Remove the Container

```bash
# Stop the running container
docker stop cloudpulse-container

# Remove the stopped container
docker rm cloudpulse-container

# Remove the image
docker rmi cloudpulse:latest
```

> [!NOTE]
> Removing a container does not automatically remove the image. The image can be reused to create another container.

---

## API Reference

### Endpoints

CloudPulse provides the following REST API endpoints:

| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/` | Returns the application home response |
| `GET` | `/health` | Liveness check: verifies application health |
| `GET` | `/ready` | Readiness check: verifies the application is ready |
| `GET` | `/version` | Returns the application version |
| `GET` | `/users` | Retrieves the list of users |
| `POST` | `/users` | Creates a new user |
| `GET` | `/metrics` | Exposes application metrics for Prometheus |

### Interactive Documentation (Swagger UI)

Swagger UI provides an interactive interface for exploring and testing the CloudPulse REST API endpoints. It is available at `/docs` when the application is running.

<p align="center">
  <img src="https://github.com/user-attachments/assets/d6fd232a-05db-4233-b0b6-843f63ab477f" alt="Swagger UI showing the CloudPulse API endpoints" width="900">
</p>

<p align="center"><em>Figure 2. Swagger UI for the CloudPulse REST API.</em></p>

---

## CI/CD Pipeline

CloudPulse uses GitHub Actions to automate application testing, Docker image building, and image publishing. The workflow is defined in [`.github/workflows/ci.yml`](.github/workflows/ci.yml) and is triggered by repository changes.

<p align="center">
  <img src="https://github.com/user-attachments/assets/36f326f9-5b16-4748-b19d-f7c95544956e" alt="CloudPulse CI/CD workflow diagram" width="900">
</p>

<p align="center"><em>Figure 3. CI/CD workflow.</em></p>

### Workflow Steps

| # | Step | Description |
|---|---|---|
| 1 | **Source Checkout** | Retrieves the latest application code from GitHub. |
| 2 | **Dependency Installation** | Installs the required Python dependencies. |
| 3 | **Automated Testing** | Runs the test suite with Pytest to validate application functionality. |
| 4 | **Docker Image Build** | Builds the application Docker image using the Dockerfile. |
| 5 | **Image Publishing** | Pushes the successfully built image to Docker Hub for deployment. |

This workflow reduces manual steps and provides a repeatable process for building and publishing application images.

### Pipeline Results

**Successful GitHub Actions run.** The workflow runs the application tests, builds the Docker image, and publishes the image to Docker Hub.

<p align="center">
  <img width="1892" height="923" alt="image" src="https://github.com/user-attachments/assets/8b12a827-61d5-4e5f-b0ce-5354542504f0" />
</p>

<p align="center"><em>Figure 4. Successful GitHub Actions run.</em></p>

**Docker Hub repository.** The repository stores the CloudPulse container image published by the workflow, making it available for deployment and reuse.

<p align="center">
  <img src="https://github.com/user-attachments/assets/13f62f9f-60c7-448c-b704-5b2eaf436b21" alt="CloudPulse image in the Docker Hub repository" width="800">
</p>

<p align="center"><em>Figure 5. CloudPulse image on Docker Hub.</em></p>

---

## Kubernetes Deployment

CloudPulse uses Kubernetes to deploy and manage the containerized application. The manifests are maintained separately in the [`k8s/`](k8s/) directory.

### Kubernetes Architecture

<p align="center">
  <img src="https://github.com/user-attachments/assets/ad0329e9-69b1-4b8c-8333-62ba5ba86807" alt="CloudPulse Kubernetes architecture diagram" width="500">
</p>

<p align="center"><em>Figure 6. Kubernetes architecture.</em></p>

### Kubernetes Resources

| Resource | Manifest | Purpose |
|---|---|---|
| **Namespace** | `namespace.yaml` | Organizes and isolates application resources. |
| **Deployment** | `deployment.yaml` | Manages application Pods and replicas. |
| **Service** | `service.yaml` | Provides stable internal network access to the application. |
| **ConfigMap** | `configmap.yaml` | Stores application configuration. |
| **Secret** | `secret.yaml` | Manages sensitive configuration values. |
| **Ingress** | `ingress.yaml` | Defines external HTTP/HTTPS routing to the application. |
| **Horizontal Pod Autoscaler** | `hpa.yaml` | Configures automatic scaling of application replicas based on resource utilization. |

### Health and Resource Management

- **Health probes:** Readiness and liveness probes help Kubernetes monitor application health and manage container restarts.
- **Resource requests and limits:** Define the CPU and memory resources required and permitted for containers.
- **Graceful startup and shutdown:** The application starts and stops gracefully.

### Deploying CloudPulse

Apply the Kubernetes manifests:

```bash
# 1. Create the namespace
kubectl apply -f k8s/namespace.yaml

# 2. Create the application configuration
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/secret.yaml

# 3. Deploy the application
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

To enable external access and autoscaling, also apply the Ingress and HPA manifests:

```bash
kubectl apply -f k8s/ingress.yaml
kubectl apply -f k8s/hpa.yaml
```

> [!NOTE]
> An Ingress requires an ingress controller in the cluster, and the HPA requires the Kubernetes Metrics Server to read CPU and memory usage.

Verify the deployment:

```bash
kubectl get pods -n cloudpulse
kubectl get svc -n cloudpulse
```

---

## Monitoring and Observability

CloudPulse exposes application metrics through the `/metrics` endpoint. Prometheus scrapes this endpoint at 15-second intervals, and Grafana uses Prometheus as its data source to visualize the collected metrics through dashboards.

The monitoring setup provides visibility into application availability, HTTP request metrics, CPU utilization, and memory consumption.

### Monitoring Components

| Component | Role | Kubernetes manifests | Local access |
|---|---|---|---|
| **Prometheus** | Collects and stores application metrics. | `prometheus-configmap.yaml`, `prometheus-deployment.yaml`, `prometheus-service.yaml` | `http://localhost:9090` |
| **Grafana** | Visualizes metrics through dashboards. | `grafana-deployment.yaml`, `grafana-service.yaml` | `http://localhost:3000` |

The standalone configuration files are in [`monitoring/`](monitoring/): `prometheus.yml`, `grafana/datasource.yml`, and `grafana/dashboard.json`.

### Prometheus Setup

Deploy Prometheus using the Kubernetes manifests:

```bash
kubectl apply -f k8s/prometheus-configmap.yaml
kubectl apply -f k8s/prometheus-deployment.yaml
kubectl apply -f k8s/prometheus-service.yaml
```

Access the Prometheus UI:

```bash
kubectl port-forward svc/prometheus-service 9090:9090 -n cloudpulse
```

Then open `http://localhost:9090` and verify the CloudPulse target under **Status → Targets**. The target should show `UP`.

<p align="center">
  <img width="1920" height="253" alt="image" src="https://github.com/user-attachments/assets/e1b5fac9-c6a7-49cc-a009-366507b65a2e" />
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/ec395fd0-ab22-4bd2-a370-2767955b67b8" alt="Prometheus scraping CloudPulse application metrics" width="900">
</p>

<p align="center"><em>Figure 7. Prometheus successfully scraping CloudPulse metrics.</em></p>

### Grafana Setup

Deploy Grafana using the Kubernetes manifests:

```bash
kubectl apply -f k8s/grafana-deployment.yaml
kubectl apply -f k8s/grafana-service.yaml
```

Access the Grafana UI:

```bash
kubectl port-forward svc/grafana-service 3000:3000 -n cloudpulse
```

Then open `http://localhost:3000`.

### Connecting Prometheus to Grafana

1. Navigate to **Connections → Data Sources** in Grafana.
2. Add **Prometheus** as a data source.
3. Set the Prometheus server URL to `http://prometheus-service:9090`.
4. Click **Save & Test** to verify the connection.
5. Create dashboards using PromQL queries to visualize CloudPulse metrics.

### Dashboards

| Dashboard panel | PromQL query |
|---|---|
| Application availability | `up{job="cloudpulse"}` |
| CPU utilization | `rate(process_cpu_seconds_total[1m]) * 100` |

#### Application Availability

Prometheus monitors CloudPulse availability by periodically scraping its `/metrics` endpoint. Grafana visualizes the availability status over time using the Prometheus `up` metric. A value of `1` indicates that Prometheus successfully scraped the application, while `0` indicates a failed scrape.

```promql
up{job="cloudpulse"}
```

<p align="center">
  <img src="https://github.com/user-attachments/assets/14f38346-3b92-402c-ab7b-c70dff446cac" alt="Grafana dashboard showing CloudPulse application availability" width="900">
</p>

<p align="center"><em>Figure 8. Application availability in Grafana.</em></p>

#### CPU Utilization

CloudPulse application CPU consumption is monitored using Prometheus and visualized through Grafana.

```promql
rate(process_cpu_seconds_total[1m]) * 100
```

<p align="center">
  <img src="https://github.com/user-attachments/assets/e5495eea-2100-4c09-a387-ba97467d5b41" alt="Grafana dashboard showing CloudPulse CPU utilization" width="900">
</p>

<p align="center"><em>Figure 9. CPU utilization in Grafana.</em></p>

---

## Troubleshooting

<details>
<summary><strong>Port 8000 is already in use</strong></summary>

Another process is using the port. Stop it, or run CloudPulse on a different port.

```bash
# Locally
uvicorn app.main:app --reload --port 8001

# With Docker (host port 8080 -> container port 8000)
docker run -d --name cloudpulse-container -p 8080:8000 cloudpulse:latest
```

</details>

<details>
<summary><strong>The container exits or the application does not respond</strong></summary>

Check the container status and logs:

```bash
docker ps -a
docker logs cloudpulse-container
```

</details>

<details>
<summary><strong>Pods are not in the Running or Ready state</strong></summary>

Inspect the Pod events and the application logs:

```bash
kubectl get pods -n cloudpulse
kubectl describe pod <pod-name> -n cloudpulse
kubectl logs <pod-name> -n cloudpulse
```

</details>

<details>
<summary><strong>The Prometheus target is not <code>UP</code></strong></summary>

- Confirm the CloudPulse application Pods are running and that `/metrics` responds.
- Review the scrape configuration in `k8s/prometheus-configmap.yaml` (or `monitoring/prometheus.yml`) and check **Status → Targets** in the Prometheus UI for the scrape error.
- Confirm the port-forward to `prometheus-service` is still running.

</details>

<details>
<summary><strong>The HPA shows unknown metrics, or the Ingress is not reachable</strong></summary>

The HPA needs the Kubernetes Metrics Server, and the Ingress needs an ingress controller. Verify both are installed in the cluster, then check the resources:

```bash
kubectl get hpa -n cloudpulse
kubectl get ingress -n cloudpulse
```

</details>

---

## Future Improvements

- **AWS EKS deployment:** Deploy CloudPulse on Amazon Elastic Kubernetes Service (EKS) to explore managed Kubernetes on AWS.
- **Infrastructure as Code:** Use Terraform to provision and manage cloud infrastructure in a repeatable, automated way.

---

## Conclusion

CloudPulse brings together application development, containerization, CI/CD automation, Kubernetes orchestration, and monitoring in a single DevOps project.

Building it provided hands-on experience with the tools and workflows used in modern DevOps environments, and strengthened my understanding of how applications are built, tested, packaged, deployed, and monitored.

This project is an ongoing learning journey, and I plan to extend it by exploring AWS EKS and Infrastructure as Code with Terraform.
