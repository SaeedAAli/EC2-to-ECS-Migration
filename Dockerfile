# Base Image Foundation && Build Stage
FROM python:3.8-alpine AS build

WORKDIR /app

# Copying the Files into the Image
COPY ec2-legacy-app/app/ .

# Installing Werkzeug, Flask, Gunicorn
RUN  pip install -r requirements.txt


## Runtime Stage
FROM python:3.8-alpine

WORKDIR /app 

COPY --from=build /app /app/

COPY --from=build /usr/local/lib/python3.8/site-packages /usr/local/lib/python3.8/site-packages
#
# Creating a Non Root User and giving it Permission
RUN  adduser -D appuser

RUN chown -R appuser:appuser /app

USER appuser

## This is a debug line to make sure if Site package is located
RUN ls -la /usr/local/lib/python3.8/site-packages

# Making sure the Image is Healthy by verifiying the URL via CURL
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "curl", "-f", "http://localhost:5002/health" ]


EXPOSE 5002

# Default command that starts your application
# When doing this, 

CMD [ "python", "-m", "gunicorn", "--bind", "0.0.0.0:8000", "wsgi:app" ]



