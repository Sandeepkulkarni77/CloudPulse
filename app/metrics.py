from fastapi import Response
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST

REQUEST_COUNT = Counter(
    "cloudpulse_requests_total",
    "Total number of API requests handled by CloudPulse"
)


def metrics():
    return Response(
        content=generate_latest(),
        headers={"Content-Type": CONTENT_TYPE_LATEST}
    )
