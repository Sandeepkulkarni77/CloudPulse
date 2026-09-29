# 🚀 CloudPulse

<p align="center">

![Python](https://img.shields.io/badge/Python-3.13-blue?style=for-the-badge&logo=python)
![FastAPI](https://img.shields.io/badge/FastAPI-REST_API-009688?style=for-the-badge&logo=fastapi)
![Docker](https://img.shields.io/badge/Docker-Containerization-2496ED?style=for-the-badge&logo=docker)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestration-326CE5?style=for-the-badge&logo=kubernetes)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI/CD-2088FF?style=for-the-badge&logo=githubactions)
![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-E6522C?style=for-the-badge&logo=prometheus)
![Grafana](https://img.shields.io/badge/Grafana-Dashboard-F46800?style=for-the-badge&logo=grafana)

</p>

## 📖 Project Overview

CloudPulse is an **end-to-end DevOps project** built to demonstrate modern software delivery practices using **FastAPI, Docker, GitHub Actions, Kubernetes, Prometheus, and Grafana**.

The project showcases how an application moves from development to deployment with automated testing, containerization, continuous integration, Kubernetes deployment configuration, and monitoring.

It is designed as a portfolio project for aspiring **DevOps and Cloud Engineers**.

---

# ✨ Features

- REST API built with FastAPI
- Dockerized application
- Automated CI/CD with GitHub Actions
- Automated unit testing using Pytest
- Docker Hub image publishing
- Kubernetes Deployment
- Kubernetes Service
- Kubernetes Namespace
- ConfigMap & Secret
- Horizontal Pod Autoscaler (HPA)
- Ingress Configuration
- Resource Requests & Limits
- Readiness & Liveness Probes
- Graceful Startup & Shutdown
- Prometheus Metrics Endpoint
- Grafana Dashboard Configuration
- Structured Logging

---

# 🏗 Architecture

<img width="1536" height="1024" alt="ChatGPT Image Sep 28, 2026, 03_40_23 PM" src="https://github.com/user-attachments/assets/fda5c294-b097-49bf-a1c1-58668fe6c068" />


---

# 🛠 Tech Stack

| Category | Technology |
|----------|------------|
| Language | Python 3.13 |
| Framework | FastAPI |
| Testing | Pytest |
| Containerization | Docker |
| CI/CD | GitHub Actions |
| Registry | Docker Hub |
| Orchestration | Kubernetes |
| Monitoring | Prometheus |
| Visualization | Grafana |
| Version Control | Git & GitHub |

---

# 📂 Project Structure

```text
CloudPulse/
│
├── app/
│   ├── main.py
│   ├── config.py
│   ├── logger.py
│   ├── metrics.py
│   ├── models.py
│   ├── database.py
│   └── requirements.txt
│
├── tests/
│   └── test_api.py
│
├── k8s/
│   ├── namespace.yaml
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── configmap.yaml
│   ├── secret.yaml
│   ├── hpa.yaml
│   ├── prometheus-configmap.yaml
│   ├── prometheus-deployment.yaml
│   ├── prometheus-service.yaml
│   ├── grafana-deployment.yaml
│   └── grafana-service.yaml
│
├── monitoring/
│   ├── prometheus.yml
│   └── grafana/
│       ├── datasource.yml
│       └── dashboard.json
│
├── images/
│
├── tests/
│
├── .github/
│   └── workflows/
│       └── ci.yml
│
├── Dockerfile
├── docker-compose.yml
├── pytest.ini
└── README.md
```

---

# 🔄 CI/CD Workflow

<img width="1774" height="887" alt="ChatGPT Image Sep 28, 2026, 06_56_08 PM" src="https://github.com/user-attachments/assets/36f326f9-5b16-4748-b19d-f7c95544956e" />

---

# ☸ Kubernetes Architecture

<img width="1024" height="1536" alt="ChatGPT Image Sep 28, 2026, 07_00_37 PM" src="https://github.com/user-attachments/assets/ad0329e9-69b1-4b8c-8333-62ba5ba86807" />

---

# 📊 Monitoring

CloudPulse exposes application metrics through the `/metrics` endpoint.

### Monitoring Stack

- Prometheus
- Grafana

### Health Endpoints

| Endpoint | Purpose |
|----------|----------|
| `/health` | Liveness Check |
| `/ready` | Readiness Check |
| `/metrics` | Prometheus Metrics |

---

# 📌 API Endpoints

| Method | Endpoint | Description |
|---------|----------|-------------|
| GET | `/` | Home |
| GET | `/health` | Health Check |
| GET | `/ready` | Readiness Check |
| GET | `/version` | Application Version |
| GET | `/users` | Get Users |
| POST | `/users` | Create User |
| GET | `/metrics` | Prometheus Metrics |

---

# ▶ Running Locally

## Clone Repository

```bash
git clone https://github.com/Tanmay-hue/CloudPulse.git
cd CloudPulse
```

---

## Create Virtual Environment

Windows

```bash
python -m venv .venv
.venv\Scripts\activate
```

Linux/macOS

```bash
python3 -m venv .venv
source .venv/bin/activate
```

---

## Install Dependencies

```bash
pip install -r app/requirements.txt
```

---

## Start Application

```bash
uvicorn app.main:app --reload
```

---

## Swagger Documentation

```
http://127.0.0.1:8000/docs
```

---

## Run Tests

```bash
pytest
```

---

# 🐳 Docker

Build Image

```bash
docker build -t cloudpulse .
```

Run Container

```bash
docker run -p 8000:8000 cloudpulse
```

---

#  Screenshots

## Swagger UI

![Swagger UI](https://github.com/Tanmay-hue/CloudPulse/blob/main/images/swagger-ui.png)

---

## GitHub Actions (Successful CI/CD)

![GitHub Actions](https://github.com/Tanmay-hue/CloudPulse/blob/main/images/github-actions.png)

---

## Docker Hub Repository

<img width="937" height="592" alt="image" src="https://github.com/user-attachments/assets/13f62f9f-60c7-448c-b704-5b2eaf436b21" />

---

## Project Structure

![Project Structure](https://github.com/Tanmay-hue/CloudPulse/blob/main/images/project-structure.png)

---

#  Future Improvements

- Deploy on AWS EKS
- Infrastructure as Code with Terraform

---

#  Learning Outcomes

This project demonstrates practical experience with:

- REST API Development
- Docker Containerization
- CI/CD Pipeline Automation
- GitHub Actions
- Docker Hub Integration
- Kubernetes Resource Management
- Health & Readiness Probes
- Prometheus Monitoring
- Grafana Configuration
- Production-style DevOps Workflow

---
