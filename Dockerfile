FROM python:alpine

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY polls/. .

# By default, gunicorn will start on port 8000
CMD gunicorn polls.wsgi
