# Cloud Django

This project follows on from my [Writing_Django](https://github.com/mramshaw/Writing_Django) project, which is a simple Hello World in Django.

It will use [gunicorn](http://gunicorn.org/) which is a web server for [Django](https://docs.djangoproject.com/en/1.11/howto/deployment/wsgi/gunicorn/). Specifically, it is a [WSGI](https://en.wikipedia.org/wiki/Web_Server_Gateway_Interface) server.

## gunicorn

To install:

    $ pip install --user gunicorn

As usual, replace `pip` with `pip3` for Python3.

To verify the version:

    $ pip list --format=legacy | grep gunicorn

Or simply use the `requirements.txt` file:

    $ pip install --user -r requirements.txt

Lets see if it runs (this needs to be in the same folder as `manage.py`):

    $ gunicorn polls.wsgi
    [2018-02-13 17:30:31 +0000] [6232] [INFO] Starting gunicorn 19.7.1
    [2018-02-13 17:30:31 +0000] [6232] [INFO] Listening at: http://127.0.0.1:8000 (6232)
    [2018-02-13 17:30:31 +0000] [6232] [INFO] Using worker: sync
    [2018-02-13 17:30:31 +0000] [6236] [INFO] Booting worker with pid: 6236
    Not Found: /
    Not Found: /favicon.ico
    Not Found: /favicon.ico
    ^C[2018-02-13 17:31:06 +0000] [6232] [INFO] Handling signal: int
    [2018-02-14 01:31:06 +0000] [6236] [INFO] Worker exiting (pid: 6236)
    [2018-02-13 17:31:06 +0000] [6232] [INFO] Shutting down: Master
    $

Okay, everything runs.

## Docker

Lets see if we can save some Docker build time:

    $ sudo docker search python
    ....
    $ sudo docker search django
    ....
    $ sudo docker search gunicorn
    ....

Hmm, maybe it would be faster to do a search from:

    https://hub.docker.com/explore/

Or maybe not, it looks like the official Django image is __deprecated__:

    https://hub.docker.com/_/django/

[This page has a link to the Docker Store version of Django: 404]

Okay, the recommendation is to start with a Python image, lets do that.

The options are endless:

    https://hub.docker.com/_/python/

[Of course, it doesn't really make any sense to Dockerize an app with a local database - but we will address that later.]

## To Do

- [ ] Upgrade to most recent __minikube__
- [ ] Upgrade to most recent __kubectl__
