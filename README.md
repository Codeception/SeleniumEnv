SeleniumEnv
===========

This is a Docker Image with Selenium Server, Xvfb, Firefox and Chromium installed. SeleniumEnv was created to run Selenium tests without installing Selenium and its dependencies. Selenium server is executed inside a container and connected from a host machine.

## Installation

Grab prepacked image from a Docker Hub

```
docker pull davert/selenium-env
```


Or build image by yourself. Just clone this repo and run

```
docker build -t selenium-env .
```

you should edit Dockerfile in order to customize version of Selenium Server.

## Usage

SeleniumEnv is able to connect to local or remote web sites. 

### Accessing Remote Website

Run the container and bind it to default Selenium port `4444` 

```
docker run -i -t -p 4444:4444 davert/selenium-env 
```

### Accessing Local Website by Port

In case you want to access local website from container you can do the following:
if application is run on localhost (`0.0.0.0`) on a specific port, you can pass `APP_PORT` environment variable into it:

```
php -S 0.0.0.0:8000 & 
docker run -i -t -p 4444:4444 -e APP_PORT=8000 davert/selenium-env 
```

### Accessing Local Website by Host

In case local web site is served by nginx or Apache, and is configured for a specific host, you can pass host name as environment variable:

```
docker run -i -t -p 4444:4444 -e APP_HOST=myapp davert/selenium-env 
```

