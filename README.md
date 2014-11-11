SeleniumEnv
===========

This is Docker Image with Selenium Server, Xvfb, Firefox and Chromium included.
SeleniumEnv was created in order to run Selenium tests without installing Selenium dependencies. Selenium server is expected to be executed inside a container and connected from HOST machine.

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

