FROM python:3.12-alpine

WORKDIR /app

COPY ec2-legacy-app . 

RUN pip install --upgrade pip

RUN pip install -r app/requirements.txt

EXPOSE 8080

CMD [ "gunicorn", "--bind", "0.0.0.0:8080", "wsgi:app" ]