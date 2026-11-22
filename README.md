<div align="center">

# ⚡ CloudPulse

![Python](https://img.shields.io/badge/Python-3.13-blue?style=for-the-badge&logo=python)
![FastAPI](https://img.shields.io/badge/FastAPI-REST_API-009688?style=for-the-badge&logo=fastapi)
![Docker](https://img.shields.io/badge/Docker-Containerization-2496ED?style=for-the-badge&logo=docker)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestration-326CE5?style=for-the-badge&logo=kubernetes)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI/CD-2088FF?style=for-the-badge&logo=githubactions)
![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-E6522C?style=for-the-badge&logo=prometheus)
![Grafana](https://img.shields.io/badge/Grafana-Dashboard-F46800?style=for-the-badge&logo=grafana)

</div>

##  Project Overview

CloudPulse is an end-to-end DevOps project that demonstrates the process of building, containerizing, deploying, and monitoring a Python-based REST API.

The application is developed using FastAPI and containerized using Docker. GitHub Actions automates application testing and Docker image publishing, while Kubernetes manages application deployment and orchestration.

Prometheus and Grafana are integrated to collect and visualize application metrics, providing visibility into application performance and health.

The project brings together application development, CI/CD automation, container orchestration, and monitoring in a single workflow.

---

## Features

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

#  Architecture

<img width="2560" height="1880" alt="architecture" src="https://github.com/user-attachments/assets/a2d18920-0e34-4e63-b81c-4f2a0f041def" />

---

## Tech Stack

| Category | Technology |
|---|---|
| Programming Language | Python 3.13 |
| Framework | FastAPI |
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

## CI/CD Workflow

<img width="1774" height="887" alt="ChatGPT Image Sep 28, 2026, 06_56_08 PM" src="https://github.com/user-attachments/assets/36f326f9-5b16-4748-b19d-f7c95544956e" />

CloudPulse uses GitHub Actions to automate the application testing, Docker image build, and publishing process.

The workflow is triggered by repository changes and performs the following steps:

1. **Source Checkout:** Retrieves the latest application code from GitHub.
2. **Dependency Installation:** Installs the required Python dependencies.
3. **Automated Testing:** Runs the test suite using Pytest to validate application functionality.
4. **Docker Image Build:** Builds the application Docker image using the Dockerfile.
5. **Image Publishing:** Pushes the successfully built image to Docker Hub for deployment.

This workflow reduces manual steps and provides a repeatable process for building and publishing application images.

---
## Kubernetes Deployment

CloudPulse uses Kubernetes to deploy and manage the containerized application. The Kubernetes manifests are maintained separately in the `k8s/` directory.

### Kubernetes Architecture

<img width="1024" height="1536" alt="ChatGPT Image Sep 28, 2026, 07_00_37 PM" src="https://github.com/user-attachments/assets/ad0329e9-69b1-4b8c-8333-62ba5ba86807" />

### Kubernetes Resources

The Kubernetes configuration includes the following resources:

| Resource | Purpose |
|---|---|
| **Namespace** | Organizes and isolates application resources. |
| **Deployment** | Manages application Pods and replicas. |
| **Service** | Provides stable internal network access to the application. |
| **ConfigMap** | Stores application configuration. |
| **Secret** | Manages sensitive configuration values. |
| **Ingress** | Defines external HTTP/HTTPS routing to the application. |

### Application Health and Resource Management

- **Health Probes:** Readiness and liveness probes help Kubernetes monitor application health and manage container restarts.
- **Resource Requests and Limits:** Define the CPU and memory resources required and permitted for containers.
- **Horizontal Pod Autoscaler (HPA):** Configures automatic scaling of application replicas based on resource utilization.

### Deploying CloudPulse

Apply the Kubernetes manifests to deploy CloudPulse:

```bash
# Create namespace
kubectl apply -f k8s/namespace.yaml

# Create application configuration
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/secret.yaml

# Deploy application
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

Verify the deployment:

```bash
kubectl get pods -n cloudpulse
kubectl get svc -n cloudpulse
```

---

## Monitoring and Observability

CloudPulse exposes application metrics through the `/metrics` endpoint, allowing Prometheus to collect metrics from the application.

Prometheus is configured to scrape the application metrics at a defined interval. Grafana uses Prometheus as a data source to visualize the collected metrics through dashboards.

### Monitoring Components

- **Prometheus:** Collects and stores application metrics.
- **Grafana:** Visualizes metrics through dashboards.

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

Open: `http://localhost:9090`

Verify the CloudPulse target under **Status → Targets**. The target should show `UP`.

### Grafana Setup

Deploy Grafana:

```bash
kubectl apply -f k8s/grafana-deployment.yaml
kubectl apply -f k8s/grafana-service.yaml
```

Access the Grafana UI:

```bash
kubectl port-forward svc/grafana-service 3000:3000 -n cloudpulse
```

Open: `http://localhost:3000`

### Connecting Prometheus to Grafana

1. Navigate to **Connections → Data Sources** in Grafana.
2. Add Prometheus as a data source.
3. Set the Prometheus server URL:

   `http://prometheus-service:9090`

4. Click **Save & Test** to verify the connection.
5. Create dashboards using PromQL queries to visualize CloudPulse metrics.
---

### Health Endpoints

| Endpoint | Purpose |
|----------|----------|
| `/health` | Liveness Check |
| `/ready` | Readiness Check |
| `/metrics` | Prometheus Metrics |

---

## API Endpoints

CloudPulse provides the following REST API endpoints:

| Method | Endpoint | Description |
|---|---|---|
| GET | `/` | Returns the application home response |
| GET | `/health` | Checks application health |
| GET | `/ready` | Checks application readiness |
| GET | `/version` | Returns the application version |
| GET | `/users` | Retrieves the list of users |
| POST | `/users` | Creates a new user |
| GET | `/metrics` | Exposes application metrics for Prometheus |

---

## Running Locally

Follow these steps to set up and run CloudPulse on your local machine.

### Prerequisites

Make sure the following tools are installed:

- Python 3.13
- Git
- pip

### 1. Clone the Repository

Clone the repository and navigate to the project directory.

```bash
git clone https://github.com/Tanmay-hue/CloudPulse.git

cd CloudPulse
```

### 2. Create a Virtual Environment

Create an isolated Python environment for the project.

```bash
python3 -m venv .venv
```

Activate the virtual environment:

**Linux/macOS**

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

Upgrade pip and install the project dependencies.

```bash
python -m pip install --upgrade pip

pip install -r app/requirements.txt
```

### 4. Start the Application

Start the FastAPI application using Uvicorn.

```bash
uvicorn app.main:app --reload
```

The application will start on:

```text
http://127.0.0.1:8000
```

### 5. Access the API Documentation

FastAPI automatically provides interactive API documentation through Swagger UI.

Open the following URL in your browser:

```text
http://127.0.0.1:8000/docs
```

Use Swagger UI to explore and test the available API endpoints.

### 6. Verify Application Endpoints

Test the application using curl:

**Home endpoint**

```bash
curl http://127.0.0.1:8000/
```

**Health check**

```bash
curl http://127.0.0.1:8000/health
```

**Readiness check**

```bash
curl http://127.0.0.1:8000/ready
```

**Application version**

```bash
curl http://127.0.0.1:8000/version
```

**Prometheus metrics**

```bash
curl http://127.0.0.1:8000/metrics
```

### 7. Run Automated Tests

Execute the test suite using Pytest:

```bash
pytest
```

Pytest runs the available application tests and reports their results in the terminal.

### 8. Stop the Application

Press `Ctrl + C` in the terminal to stop the Uvicorn server.

Deactivate the virtual environment:

```bash
deactivate
```

---

## Running with Docker

Docker is used to package the CloudPulse application and its dependencies into a container image. This allows the application to run consistently across different environments without requiring Python and its dependencies to be installed directly on the host machine.

### 1. Build the Docker Image

Make sure Docker is installed and running. From the root directory of the project, execute:

```bash
docker build -t cloudpulse:latest .
```

**Command explanation:**
- `docker build` builds an image using the instructions in the Dockerfile.
- `-t cloudpulse:latest` assigns the image name `cloudpulse` and tag `latest`.
- `.` specifies the current directory as the build context.

Verify that the image was created:

```bash
docker images
```

### 2. Run the Docker Container

Start a container from the newly created image:

```bash
docker run -d \
  --name cloudpulse-container \
  -p 8000:8000 \
  cloudpulse:latest
```

**Command explanation:**
- `-d` runs the container in detached mode, in the background.
- `--name` assigns a name to the container.
- `-p 8000:8000` maps port 8000 on the host machine to port 8000 inside the container.
- `cloudpulse:latest` specifies the image used to create the container.

### 3. Verify the Running Container

Check whether the container is running:

```bash
docker ps
```

To view all containers, including stopped ones:

```bash
docker ps -a
```

### 4. Access the Application

Once the container is running, access the application using:

- Application: `http://localhost:8000`
- Swagger UI: `http://localhost:8000/docs`
- Health endpoint: `http://localhost:8000/health`

You can also test the health endpoint from the terminal:

```bash
curl http://localhost:8000/health
```

### 5. View Container Logs

To inspect application logs:

```bash
docker logs cloudpulse-container
```

To continuously follow the logs:

```bash
docker logs -f cloudpulse-container
```

### 6. Monitor Container Resource Usage

View the container's live CPU and memory usage:

```bash
docker stats cloudpulse-container
```

### 7. Stop and Remove the Container

Stop the running container:

```bash
docker stop cloudpulse-container
```

Remove the stopped container:

```bash
docker rm cloudpulse-container
```

To remove the Docker image:

```bash
docker rmi cloudpulse:latest
```

**Note:** Removing a container does not automatically remove the image. The image can be reused to create another container.

---

#  Screenshots

## Swagger UI

The Swagger UI provides an interactive interface for exploring and testing the CloudPulse REST API endpoints.

<img width="1918" height="932" alt="image" src="https://github.com/user-attachments/assets/d6fd232a-05db-4233-b0b6-843f63ab477f" />

---

## GitHub Actions (Successful CI/CD)

The GitHub Actions workflow automates the CI/CD process by running application tests, building the Docker image, and publishing the image to Docker Hub.

<img width="1918" height="932" alt="image" src="https://github.com/user-attachments/assets/28883184-5baa-4825-824e-4925c626e232" />

---

## Docker Hub Repository

The Docker Hub repository stores the CloudPulse container image published by the GitHub Actions CI/CD workflow, making it available for deployment and reuse.

<img width="937" height="592" alt="image" src="https://github.com/user-attachments/assets/13f62f9f-60c7-448c-b704-5b2eaf436b21" />

---

## Monitoring

CloudPulse uses **Prometheus** for metrics collection and **Grafana** for visualization.

- Prometheus scrapes application metrics from the `/metrics` endpoint at 15-second intervals.
- Grafana uses Prometheus as its data source to visualize application and system metrics.
- The monitoring setup provides visibility into application availability, HTTP request metrics, CPU utilization, and memory consumption.

## Prometheus Metrics

Prometheus successfully scrapes metrics exposed by the CloudPulse application.

<img width="1916" height="925" alt="image" src="https://github.com/user-attachments/assets/ec395fd0-ab22-4bd2-a370-2767955b67b8" />

---

## Grafana Dashboard

Application Availability

Prometheus monitors CloudPulse application availability by periodically scraping its /metrics endpoint. Grafana visualizes the availability status over time using the Prometheus up metric.

PromQL Query: `up{job="cloudpulse"}`

A value of 1 indicates that Prometheus successfully scraped the application, while 0 indicates a failed scrape.

<img width="1246" height="822" alt="image" src="https://github.com/user-attachments/assets/14f38346-3b92-402c-ab7b-c70dff446cac" />


## CPU Utilization

CloudPulse application CPU consumption is monitored using
Prometheus and visualized through Grafana.

PromQL Query: `rate(process_cpu_seconds_total[1m]) * 100`

<img width="1288" height="885" alt="image" src="https://github.com/user-attachments/assets/e5495eea-2100-4c09-a387-ba97467d5b41" />

---

#  Future Improvements

- **AWS EKS Deployment:** Deploy CloudPulse on Amazon Elastic Kubernetes Service (EKS) to explore managed Kubernetes in AWS.
- **Infrastructure as Code:** Use Terraform to provision and manage cloud infrastructure in a repeatable and automated way.

---

# Conclusion

CloudPulse brings together application development, containerization, CI/CD automation, Kubernetes orchestration, and monitoring into a single DevOps project.

Building this project helped me gain hands-on experience with tools and workflows used in modern DevOps environments. It also strengthened my understanding of how applications are built, tested, packaged, deployed, and monitored.

This project is an ongoing learning journey, and I plan to extend it further by exploring AWS EKS and Infrastructure as Code using Terraform.

---
