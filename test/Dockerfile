# Base Image
FROM python:3.8-alpine

WORKDIR /app

# Copy application code into container
COPY ec2-legacy-app/app/ .

# Install dependencies
RUN pip install -r requirements.txt

# Create non-root user
RUN adduser -D appuser
RUN chown -R appuser:appuser /app

USER appuser

# Healthcheck (note: alpine may not include curl by default)
# If curl is missing, you may need: RUN apk add --no-cache curl
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
CMD ["curl", "-f", "http://localhost:5002/health"]

EXPOSE 5002

CMD ["gunicorn", "--bind", "0.0.0.0:5002", "wsgi:app"]