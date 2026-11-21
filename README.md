<div align="center">

# 🚀 CloudPulse

### From `git push` to a monitored Kubernetes deployment, end to end.

A FastAPI service that is **tested, containerized, shipped through CI/CD, deployed on Kubernetes, and observed with Prometheus and Grafana**.

[![CI](https://github.com/Tanmay-hue/CloudPulse/actions/workflows/ci.yml/badge.svg)](https://github.com/Tanmay-hue/CloudPulse/actions/workflows/ci.yml)
![Python](https://img.shields.io/badge/Python-3.13-3776AB?style=flat-square&logo=python&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=flat-square&logo=fastapi&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=flat-square&logo=kubernetes&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=flat-square&logo=githubactions&logoColor=white)
![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=flat-square&logo=prometheus&logoColor=white)
![Grafana](https://img.shields.io/badge/Grafana-F46800?style=flat-square&logo=grafana&logoColor=white)

[Quick Start](#quick-start) · [Architecture](#architecture) · [CI/CD](#cicd-pipeline) · [Kubernetes](#kubernetes-deployment) · [Monitoring](#monitoring-and-observability) · [Screenshots](#screenshots)

</div>

---

## At a Glance

| | |
|---|---|
| **What it is** | A Python REST API with a complete build, deploy, and monitor workflow around it |
| **Pipeline** | Pytest → Docker build → publish to Docker Hub, automated with GitHub Actions |
| **Runtime** | Kubernetes with 2 replicas, rolling updates, probes, resource limits, HPA, and Ingress |
| **Observability** | `/metrics` endpoint → Prometheus (15s scrape) → Grafana dashboards |
| **Roadmap** | AWS EKS deployment and Terraform-managed infrastructure |

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Quick Start](#quick-start)
- [API Reference](#api-reference)
- [Running Locally](#running-locally)
- [Running with Docker](#running-with-docker)
- [CI/CD Pipeline](#cicd-pipeline)
- [Kubernetes Deployment](#kubernetes-deployment)
- [Monitoring and Observability](#monitoring-and-observability)
- [Design Decisions](#design-decisions)
- [Security Notes](#security-notes)
- [Screenshots](#screenshots)
- [Troubleshooting](#troubleshooting)
- [Roadmap](#roadmap)
- [What I Learned](#what-i-learned)
- [Contributing](#contributing) · [License](#license) · [Author](#author)

---

## Overview

CloudPulse takes a small Python REST API through the full lifecycle that real services follow:

**code → test → containerize → publish → deploy → observe**

- **Build:** a FastAPI application with health, readiness, and metrics endpoints.
- **Ship:** GitHub Actions runs the Pytest suite, builds the Docker image, and publishes it to Docker Hub.
- **Run:** Kubernetes manifests deploy the app with probes, resource limits, rolling updates, autoscaling, and ingress.
- **Observe:** Prometheus scrapes `/metrics` and Grafana turns the data into dashboards.

The goal was to connect every stage into one working workflow, rather than treating them as separate tools.

---

## Features

| Area | What's included |
|---|---|
| **Application** | FastAPI REST API, Pytest unit tests, structured logging, `/health`, `/ready`, `/metrics` |
| **Containerization** | Dockerfile for a portable image, `docker-compose.yml` for local runs |
| **CI/CD** | GitHub Actions workflow for install, test, build, and publish to Docker Hub |
| **Kubernetes** | Namespace, Deployment (2 replicas, RollingUpdate), Service, Ingress, ConfigMap, Secret, HPA |
| **Reliability** | Liveness and readiness probes, CPU and memory requests and limits, graceful startup and shutdown |
| **Monitoring** | Prometheus scrape config, Grafana datasource, importable dashboard |

---

## Architecture

<p align="center">
  <img width="900" alt="CloudPulse end-to-end architecture diagram" src="https://github.com/user-attachments/assets/fda5c294-b097-49bf-a1c1-58668fe6c068" />
</p>

### Runtime and monitoring flow

```mermaid
flowchart TB
    Client["Client"] --> Ingress["Ingress"]
    Ingress --> Service["Service"]
    Service --> Pods["CloudPulse Pods<br/>FastAPI · 2 replicas"]
    HPA["HPA"] -. scales .-> Pods
    Prometheus["Prometheus"] -- "scrapes /metrics every 15s" --> Pods
    Grafana["Grafana"] -- "PromQL queries" --> Prometheus
```

---

## Tech Stack

| Category | Technology |
|---|---|
| Language | Python 3.13 |
| Framework | FastAPI |
| Testing | Pytest |
| Containerization | Docker, Docker Compose |
| CI/CD | GitHub Actions |
| Registry | Docker Hub |
| Orchestration | Kubernetes |
| Metrics | Prometheus |
| Dashboards | Grafana |
| Version control | Git and GitHub |

---

## Project Structure

```text
CloudPulse/
├── app/                          # FastAPI application
│   ├── main.py                   # App entry point and routes
│   ├── config.py                 # Configuration
│   ├── logger.py                 # Structured logging
│   ├── metrics.py                # Prometheus metrics
│   ├── models.py                 # Data models
│   ├── database.py               # Data layer
│   └── requirements.txt
├── tests/
│   └── test_api.py               # Pytest test suite
├── k8s/                          # Kubernetes manifests
│   ├── namespace.yaml
│   ├── configmap.yaml
│   ├── secret.yaml
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── hpa.yaml
│   ├── prometheus-configmap.yaml
│   ├── prometheus-deployment.yaml
│   ├── prometheus-service.yaml
│   ├── grafana-deployment.yaml
│   └── grafana-service.yaml
├── monitoring/
│   ├── prometheus.yml            # Scrape configuration
│   └── grafana/
│       ├── datasource.yml        # Prometheus datasource
│       └── dashboard.json        # Importable dashboard
├── images/                       # README screenshots
├── .github/workflows/ci.yml      # CI/CD pipeline
├── Dockerfile
├── docker-compose.yml
├── pytest.ini
└── README.md
```

---

## Quick Start

Pick whichever path fits. All three give you the API on port 8000 and Swagger UI at **http://localhost:8000/docs**.

**Option 1: Docker** (requires Docker)

```bash
git clone https://github.com/Tanmay-hue/CloudPulse.git
cd CloudPulse

docker build -t cloudpulse:latest .
docker run -d --name cloudpulse-container -p 8000:8000 cloudpulse:latest
```

**Option 2: Docker Compose**

```bash
docker compose up --build
```

**Option 3: Python** (requires Python 3.13)

```bash
python3 -m venv .venv && source .venv/bin/activate
pip install -r app/requirements.txt
uvicorn app.main:app --reload
```

Confirm it works:

```bash
curl http://localhost:8000/health
```

---

## API Reference

| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/` | Home response |
| `GET` | `/health` | Liveness check |
| `GET` | `/ready` | Readiness check |
| `GET` | `/version` | Application version |
| `GET` | `/users` | List users |
| `POST` | `/users` | Create a user |
| `GET` | `/metrics` | Prometheus metrics |

Full interactive documentation, including request and response schemas, is served at `/docs` (Swagger UI) while the app is running.

---

## Running Locally

**Prerequisites:** Python 3.13, Git, pip

```bash
# 1. Clone
git clone https://github.com/Tanmay-hue/CloudPulse.git
cd CloudPulse

# 2. Create and activate a virtual environment
python3 -m venv .venv
source .venv/bin/activate            # Windows: .venv\Scripts\activate

# 3. Install dependencies
python -m pip install --upgrade pip
pip install -r app/requirements.txt

# 4. Start the app with auto-reload
uvicorn app.main:app --reload
```

The API is available at `http://127.0.0.1:8000`.

**Try the endpoints**

```bash
curl http://127.0.0.1:8000/
curl http://127.0.0.1:8000/health
curl http://127.0.0.1:8000/ready
curl http://127.0.0.1:8000/version
curl http://127.0.0.1:8000/metrics
```

**Run the tests**

```bash
pytest
```

Press `Ctrl + C` to stop the server and run `deactivate` to leave the virtual environment.

---

## Running with Docker

<details>
<summary><b>Build and run the image</b></summary>

```bash
# Build
docker build -t cloudpulse:latest .

# Run in the background, mapping host port 8000 to the container
docker run -d --name cloudpulse-container -p 8000:8000 cloudpulse:latest
```

| Flag | Meaning |
|---|---|
| `-t cloudpulse:latest` | Names and tags the image |
| `-d` | Runs the container in detached mode |
| `--name` | Gives the container a readable name |
| `-p 8000:8000` | Maps host port 8000 to container port 8000 |

</details>

<details>
<summary><b>Inspect, debug, and clean up</b></summary>

```bash
docker ps                                   # running containers
docker logs -f cloudpulse-container         # follow logs
docker stats cloudpulse-container           # live CPU and memory usage

docker stop cloudpulse-container            # stop
docker rm cloudpulse-container              # remove the container
docker rmi cloudpulse:latest                # remove the image
```

Removing a container does not remove its image, so the image can be reused to start a new container.

</details>

<details>
<summary><b>Use the published image from Docker Hub</b></summary>

```bash
docker pull <your-dockerhub-username>/cloudpulse:latest
docker run -d -p 8000:8000 <your-dockerhub-username>/cloudpulse:latest
```

</details>

---

## CI/CD Pipeline

<p align="center">
  <img width="900" alt="CloudPulse CI/CD workflow diagram" src="https://github.com/user-attachments/assets/36f326f9-5b16-4748-b19d-f7c95544956e" />
</p>

The GitHub Actions workflow (`.github/workflows/ci.yml`) runs on repository changes:

```mermaid
flowchart LR
    A["Checkout code"] --> B["Install dependencies"]
    B --> C["Run Pytest"]
    C --> D["Build Docker image"]
    D --> E["Push to Docker Hub"]
```

| Stage | What happens |
|---|---|
| **Checkout** | Pulls the latest code from GitHub |
| **Install** | Sets up Python and installs `app/requirements.txt` |
| **Test** | Runs Pytest. A failing test stops the pipeline before any image is built |
| **Build** | Builds the Docker image from the `Dockerfile` |
| **Publish** | Pushes the image to Docker Hub, ready to deploy |

Registry credentials are kept in GitHub repository secrets, never in the code.

---

## Kubernetes Deployment

<p align="center">
  <img width="500" alt="CloudPulse Kubernetes architecture diagram" src="https://github.com/user-attachments/assets/ad0329e9-69b1-4b8c-8333-62ba5ba86807" />
</p>

### Resources

| Resource | Purpose |
|---|---|
| **Namespace** | Isolates and organizes all CloudPulse resources |
| **Deployment** | Runs 2 replicas with a RollingUpdate strategy |
| **Service** | Stable internal network endpoint for the Pods |
| **Ingress** | HTTP routing from outside the cluster |
| **ConfigMap** | Non-sensitive application configuration |
| **Secret** | Sensitive configuration values |
| **HPA** | Scales replicas automatically based on resource utilization |

### Reliability and resource management

- **Liveness probe** (`/health`): Kubernetes restarts a container that stops responding.
- **Readiness probe** (`/ready`): traffic only reaches Pods that are ready to serve it.
- **Requests and limits:** CPU and memory are reserved and capped per container.
- **Rolling updates:** new versions roll out gradually so the app stays available.
- **Graceful shutdown:** in-flight requests can finish before a Pod terminates.

### Deploy

**Prerequisites:** a running cluster (Minikube, kind, or a managed cluster) and `kubectl`.

```bash
# Namespace and configuration
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/secret.yaml

# Application
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml
kubectl apply -f k8s/hpa.yaml
```

> [!NOTE]
> The HPA needs [metrics-server](https://github.com/kubernetes-sigs/metrics-server) in the cluster, and the Ingress needs an ingress controller such as NGINX. On Minikube: `minikube addons enable metrics-server ingress`.

### Verify

```bash
kubectl get pods -n cloudpulse        # all Pods should be Running and Ready
kubectl get svc -n cloudpulse
kubectl get hpa -n cloudpulse
```

Reach the API without configuring Ingress by port-forwarding the Service:

```bash
kubectl port-forward svc/<service-name> 8000:<service-port> -n cloudpulse
curl http://localhost:8000/health
```

### Clean up

```bash
kubectl delete namespace cloudpulse
```

---

## Monitoring and Observability

CloudPulse exposes metrics at `/metrics`. Prometheus scrapes them every **15 seconds**, and Grafana visualizes them with Prometheus as its data source, covering availability, HTTP request metrics, CPU utilization, and memory consumption.

### 1. Deploy Prometheus

```bash
kubectl apply -f k8s/prometheus-configmap.yaml
kubectl apply -f k8s/prometheus-deployment.yaml
kubectl apply -f k8s/prometheus-service.yaml

kubectl port-forward svc/prometheus-service 9090:9090 -n cloudpulse
```

Open `http://localhost:9090` and check **Status → Targets**. The CloudPulse target should show `UP`.

### 2. Deploy Grafana

```bash
kubectl apply -f k8s/grafana-deployment.yaml
kubectl apply -f k8s/grafana-service.yaml

kubectl port-forward svc/grafana-service 3000:3000 -n cloudpulse
```

Open `http://localhost:3000`.

### 3. Connect Grafana to Prometheus

1. Go to **Connections → Data sources → Add data source → Prometheus**.
2. Set the URL to `http://prometheus-service:9090`.
3. Click **Save & test**.
4. Import `monitoring/grafana/dashboard.json` via **Dashboards → New → Import**, or build your own panels with PromQL.

### Useful starting queries

Run these in the Prometheus UI or a Grafana panel. Metric names depend on what `/metrics` exposes, so check `curl http://localhost:8000/metrics` and adjust.

```promql
up                                     # is the target reachable? (1 = up)
rate(process_cpu_seconds_total[1m])    # CPU usage
process_resident_memory_bytes          # memory usage
```

---

## Design Decisions

| Decision | Why |
|---|---|
| **Separate liveness and readiness probes** | A slow-starting or temporarily busy Pod should be taken out of rotation without being killed |
| **2 replicas with RollingUpdate** | Deployments replace Pods gradually, so the service stays available during releases |
| **Requests and limits on every container** | Gives the scheduler accurate information and gives the HPA a meaningful utilization baseline |
| **ConfigMap and Secret split** | Keeps configuration out of the image and sensitive values apart from plain settings |
| **Tests gate the image build** | An image is only published if the test suite passes |
| **Metrics from the app itself** | Application-level metrics show request behaviour that CPU and memory alone cannot |

---

## Security Notes

> [!WARNING]
> `k8s/secret.yaml` is for demonstration. Kubernetes Secrets are base64-encoded, **not encrypted**. Never commit real credentials. For production, use an external secrets manager (for example HashiCorp Vault with External Secrets Operator, or AWS Secrets Manager) or sealed secrets.

- CI credentials live in GitHub Actions secrets.
- Images are pushed only after tests pass.
- Resource limits help contain a misbehaving container.

---

## Screenshots

### Swagger UI
Interactive API documentation for exploring and testing endpoints.

<img width="900" alt="CloudPulse Swagger UI" src="https://github.com/user-attachments/assets/d6fd232a-05db-4233-b0b6-843f63ab477f" />

### GitHub Actions: successful CI/CD run
Tests, image build, and Docker Hub publish all passing.

<img width="900" alt="Successful GitHub Actions workflow run" src="https://github.com/user-attachments/assets/28883184-5baa-4825-824e-4925c626e232" />

### Docker Hub repository
The image published by the pipeline.

<img width="900" alt="CloudPulse image on Docker Hub" src="https://github.com/user-attachments/assets/13f62f9f-60c7-448c-b704-5b2eaf436b21" />

### Prometheus targets and metrics
Prometheus successfully scraping the application.

<img width="900" alt="Prometheus scraping CloudPulse metrics" src="https://github.com/user-attachments/assets/ec395fd0-ab22-4bd2-a370-2767955b67b8" />

### Grafana dashboard
Request and resource metrics visualized from Prometheus data.

<img width="900" alt="Grafana dashboard for CloudPulse" src="https://github.com/user-attachments/assets/92694f46-8981-47af-a564-72feea50da3e" />

---

## Troubleshooting

| Problem | Things to check |
|---|---|
| Pods stuck in `Pending` or `CrashLoopBackOff` | `kubectl describe pod <name> -n cloudpulse` and `kubectl logs <name> -n cloudpulse` |
| `ImagePullBackOff` | Confirm the image name and tag in `deployment.yaml` exist on Docker Hub |
| Pod running but not `Ready` | Confirm `/ready` responds correctly and the probe path and port match the container |
| HPA shows `<unknown>` for CPU | metrics-server is missing, or the Deployment has no CPU requests set |
| Prometheus target is `DOWN` | Verify the scrape target in the Prometheus ConfigMap matches the Service name and port |
| Grafana shows "No data" | Confirm the datasource URL is `http://prometheus-service:9090` and the target is `UP` |
| Port 8000 already in use | Stop the other process, or map another host port, e.g. `-p 8080:8000` |

---

## Roadmap

- [x] FastAPI service with tests, health checks, and metrics
- [x] Dockerized app with automated CI/CD to Docker Hub
- [x] Kubernetes deployment with probes, limits, HPA, and ingress
- [x] Prometheus and Grafana monitoring
- [ ] Deploy to **AWS EKS** (managed Kubernetes)
- [ ] Provision infrastructure with **Terraform**
- [ ] Automate deployment to the cluster from the CI/CD pipeline
- [ ] Add alerting rules with Prometheus Alertmanager

---

## What I Learned

- Wiring a complete path from commit to running Pod, and where each stage can fail.
- Why liveness and readiness probes are separate, and how they affect rollouts.
- Setting resource requests and limits so autoscaling behaves predictably.
- Exposing application metrics and turning them into useful dashboards.

---

## Contributing

Suggestions and improvements are welcome. Fork the repo, create a branch, make sure `pytest` passes, and open a pull request.

---

## License

Distributed under the MIT License. See `LICENSE` for details.

---

## Author

**Sandeep kulkarni**

[GitHub](https://github.com/Sandeepkulkarni77) · [LinkedIn](https://www.linkedin.com/in/sandeep-kulkarni-b8a69a29a/)

If you found this project useful, consider giving it a ⭐.
