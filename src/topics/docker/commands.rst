.. 
  TODO: anything else to add in docker basics section?

:orphan:

.. _docker_commands:

Docker Commands
===============

- ``docker ps`` see list of **running** containers
- ``docker ps -a`` see lisf of all containers, including ones that failed or were stopped
- ``docker start <container-name or id>`` starts the container
- ``docker stop <container-name or id>`` stops the container
- ``docker restart <container-name or id>`` restarts the container
- ``docker rm <container-name or id>`` removes the container
- ``docker images`` shows list of images that you have downloaded. containers are created from images
- ``docker image rm <image-name or id>`` removes an image
- ``docker build --tag super-happy-fun-os .`` builds a new image that containers can be created from
- ``docker-compose up -d`` uses a docker-compose.yml file to configure and start containers

.. note::

  For more info and more commands please see `the Docker CLI docs <https://docs.docker.com/engine/reference/commandline/docker/>`_