FROM python:3.13-slim

# CloudPulse Image Metadata & Identification
LABEL org.opencontainers.image.title="CloudPulse"
LABEL org.opencontainers.image.description="FastAPI application with Docker, Kubernetes and Prometheus monitoring"
LABEL org.opencontainers.image.version="1.0.0"

# Python runtime settings
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

WORKDIR /app

# Install dependencies separately for better layer caching
COPY app/requirements.txt ./requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

# Copy application source
COPY app/ ./app/

# Create a dedicated non-root user
RUN groupadd --system cloudpulse && \
    useradd --system --gid cloudpulse --no-create-home cloudpulse

USER cloudpulse

EXPOSE 8000

# Container health check
HEALTHCHECK --interval=30s \
    --timeout=5s \
    --start-period=10s \
    --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')"

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
