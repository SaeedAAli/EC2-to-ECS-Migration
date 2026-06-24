
FROM python:3.12-alpine3.21 AS build

WORKDIR /app


COPY ec2-legacy-app/app/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt



FROM python:3.12-alpine

WORKDIR /app 


COPY --from=build /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=build /usr/local/bin/gunicorn /usr/local/bin/gunicorn

COPY ec2-legacy-app/app .
 

RUN  adduser -D appuser

RUN chown -R appuser:appuser /app

USER appuser


HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD wget --no-verbose --tries=1 --spider https://localhost:5002/app/health || exit 1


EXPOSE 5002

CMD [ "gunicorn", "--bind", "0.0.0.0:5002", "wsgi:app" ]








