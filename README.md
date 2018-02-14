# Writing Django

This project follows on from my [Writing_Django](https://github.com/mramshaw/Writing_Django) project, which is a simple Hello World in Django.

It will use [gunicorn](http://gunicorn.org/) which is a web server for [Django](https://docs.djangoproject.com/en/1.11/howto/deployment/wsgi/gunicorn/). Specifically, it is a [WSGI](https://en.wikipedia.org/wiki/Web_Server_Gateway_Interface) server.

To install:

    $ pip install --user gunicorn

As usual, replace `pip` with `pip3` for Python3.

To verify the version:

    $ pip list --format=legacy | grep gunicorn

Or simply use the `requirements.txt` file:

    $ pip install --user -r requirements.txt

