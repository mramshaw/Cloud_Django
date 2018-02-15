# Cloud Django

This project follows on from my [Writing_Django](https://github.com/mramshaw/Writing_Django) project, which is a simple Hello World in Django.

It will use [gunicorn](http://gunicorn.org/) which is a web server for [Django](https://docs.djangoproject.com/en/1.11/howto/deployment/wsgi/gunicorn/). Specifically, it is a [WSGI](https://en.wikipedia.org/wiki/Web_Server_Gateway_Interface) server.

It will also use [Docker](https://github.com/mramshaw/Docker) and [Kubernetes](https://github.com/mramshaw/Kubernetes) (initially via [minikube](https://github.com/kubernetes/minikube)).

## gunicorn

To install locally:

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

#### Docker build

Lets build our dockerized app:

    $ sudo docker build -t mramshaw4docs/python-django-gunicorn:1.0 .

Available from DockerHub [here](https://hub.docker.com/r/mramshaw4docs/python-django-gunicorn/).

#### Docker versions

Okay, lets check the software versions bundled in our Dockerized app:

    $ docker run --rm -it mramshaw4docs/python-django-gunicorn /bin/sh
    /usr/src/app # python --version
    Python 3.6.4
    /usr/src/app # python -m django --version
    1.11.10
    /usr/src/app # gunicorn --version
    gunicorn (version 19.7.1)
    /usr/src/app # exit
    $

Apart from the Python version, the same software as in the original [Writing_Django](https://github.com/mramshaw/Writing_Django) project.

## minikube

Start minikube:

    $ minikube start
    Starting local Kubernetes v1.9.0 cluster...
    Starting VM...
    Getting VM IP address...
    Moving files into cluster...
    Setting up certs...
    Connecting to cluster...
    Setting up kubeconfig...
    Starting cluster components...
    Kubectl is now configured to use the cluster.
    Loading cached images from config file.
    $

Run our dockerized app:

    $ kubectl create -f ./polls.yaml

The 'service' component of `polls.yaml` is currently a stub so we will port-forward our pod (as usual, Ctrl-C to terminate):

    $ kubectl port-forward polls-7bd58769c7-r27rr 8000:8000
    Forwarding from 127.0.0.1:8000 -> 8000
    Handling connection for 8000
    ....
    Handling connection for 8000
    ^C$

This will make our app available at `127.0.0.1:8000` where we will test it:

![Minikubed_App](images/minikube_app.png)

Everything works, so now we need to make it address a non-local back-end.

Lets teardown our local kubernetes infrastructure first:

    $ kubectl delete svc/polls deploy/polls

Finally:

    $ minikube stop

## To Do

- [x] Upgrade to most recent __minikube__ (v0.25.0)
- [x] Upgrade to most recent __kubectl__ (v1.8.6 - client, v1.9.0 - server)
- [x] Verify `polls` app (written and tested with Python __2.7.12__) works with the latest Python (__3.6.4__)
