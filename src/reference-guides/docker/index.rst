Docker Reference
================

-  a system that allows for individual processes to be “containerized”

   -  containerization means to design the environment needed for a
      single process to run
   -  this means that a container process has NO dependence on the
      operating system they run on (they have everything they need to
      run self contained)
   -  a container will run until its process exits (forcibly, by
      completion or by error)

-  things that can be containerized

   -  server processes

      -  app servers
      -  database servers
      -  static http servers

   -  any other process that can be run by the OS

      -  some GUI is possible but not the purpose of Docker (requires
         linking to the host machine GUI)
         
Docker Engine
-------------

-  the Docker Engine is a program that manages provisioning and interaction with Containers
-  it includes a main CLI tool ``docker`` that is used for

   - building and managing Docker Images
   - creating and managing Docker Containers
   - creating and managing Container networks
   - mounting and managing data volumes

- the Docker Engine runs on a Host Machine 
   - the Host Machine can be a physical or virtual machine that the Docker Engine will control Containers from within
   - the Host Machine must have a Linux kernel

Host Machine
------------

-  the machine that the containers run in is called the host machine

   -  it can be a physical machine (laptop, server) or a virtual
      machine (running on a physical host such as a laptop or server)

   -  **all containers share the host machine kernel**

      -  the reason Containers are so lightweight is because they do not run a full-fledged operating system like a traditional VM
      -  instead they encapsulate a single process that is managed by the host kernel
      -  **they are otherwise completely isolated from each other in terms of file system and networking**

-  host machine requirements
   
   - a Linux kernel (to be shared by Containers)
   - running Docker Engine (what manages the life cycle of containers)

-  Linux host machines can install Docker Engine and run containers natively

-  Mac/Windows must install `Docker for Desktop <https://www.docker.com/products/docker-desktop>`__

   -  includes a Linux VM that has Docker Engine preinstalled and configured
   -  the “host machine” (linux VM) is proxied to the “physical host machine” of your Windows or OSX
      
      -  the VM transparently proxies all input / output from the physical host machine so that  containers appear to be running natively

   -  in practice the host machine appears as Windows / OSX but “technically” it is the linux VM
   -  this means all commands issued from the physical host (docker commands, networking, mounting volumes etc) is transparently proxied through the Linux VM automatically

.. Overview TODO: overview image
.. --------


Images
------

-  a container is created from a Docker Image
   
   -  the Docker Image is the “blueprint” that a Docker Container is built from
   
      -  in the same way an ISO image is the blueprint that a VM is created from

-  the Docker Image sets up the file system (environment) that the Container will run its process out of

-  everything that the Container (process) needs to execute should exist in its Docker Image
  
   -  dependent programs, tools and runtimes
   -  dependent files or data
   -  dependent file system structure

The Dockerfile
^^^^^^^^^^^^^^

-  creating a Docker Image begins with a ``Dockerfile``

-  designing a Docker Image is the same procedure as configuring a VM to
   run a process (configuring the file system)

   -  you must install dependencies (from a base image or through a
      ``RUN`` command)
   -  you must configure the file system according to the needs of the
      process the Container will run
   -  **but you are only concerned with configuring the environment of
      that single process instead of setting up the entire VM /
      auxiliary processes**
   -  whatever file system configuration the container needs to execute
      its process are the steps you perform (or extend from) in the
      ``Dockerfile``

-  the ``Dockerfile`` is where the commands (directives) to create the
   image are defined

   -  every command describes some change to the internal file system of
      the Container that will be built from the Image
   -  each command builds a “layer” of changes on the internal file
      system

      -  these layers can be cached for faster Image builds that share
         identical layers (for different versions or entirely different
         Images that utilize the same layer)
      -  the layers act as a version control system where each layer
         describes some “commit” of file system changes that can be
         inspected, cached or reverted

-  every image begins from a base image which provides some initial
   tooling

   -  basic linux OS tooling (a shell, mkdir, package manager etc)
   -  use images that have already been built off of these OS tools and
      added other configurations

      -  there are thousands of pre-made images that can be used as a
         basis for further customization
      -  from the base image the ``Dockerfile`` can add additional
         customizing layers to support the specific needs of the use
         case

-  EXTEND don’t REINVENT is the motto

   -  before writing a ``Dockerfile`` look at Docker Hub to see if there
      is a base image that you can use to configure
   -  you want to extend this base image with your own customizations
      rather than dealing with reinventing the base (unless that is a
      critical aspect of your image or for optimization purposes)

-  Images are hosted on Docker Hub

   -  they behave just like git repos but for saving and sharing Images
   -  they have a host name (the author / org)
   -  an image name (the actual image)
   -  an image tag (for different variants of the image)

      -  by default the ``:latest:`` tag is used meaning whatever the
         latest un-tagged version of the image that was pushed ###
         \`Dockerfile Reference

-  for more information see

   -  Dockerfile cheatsheet: `Dockerfile
      cheatsheet <https://devhints.io/dockerfile>`__
   -  official Dockerfile reference: `Dockerfile
      Reference <https://docs.docker.com/engine/reference/builder/>`__
      \```Dockerfile # what base image you will extend FROM
      host-name/image-name:image-tag # if you leave off the tag latest
      will be used

  by default the ``docker build`` command will look for a file exactly named ``Dockerfile`` in the CWD

.. code:: sh

    # the base image to extend from
    FROM owner-name/image-name:tag

    # copy things from the host machine to the container image
    COPY host/machine/path docker/container/path

    #run commands within the container to configure its file system
    RUN “program args –flags” # whatever is necessary

    # this is the command needed to start the process of the container
    # when the container is executed this is the command that will be issued
    CMD “program args …”
..

  build an Image from a ``Dockerfile``

.. code:: sh

   $ docker build /path/to/Dockerfile -t username/image-name:tag-name
   # this will build the image locally on your machine, to view
   $ docker images
..

  you can then push the Image to DockerHub to share with others

.. code:: sh

   $ docker push username/image-name:tag-name
..

  pull an existing image (from DockerHub) to cache locally

-  local caching is used to speed up the creation of Containers relying on that Image
-  when creating a Container it will first check the local cache for the given Image before reaching out to Docker Hub to source it

.. code:: sh

  $ docker pull username/image-name:tag-name
..

Containers
----------

containers are individual and self-contained processes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-  they have their own internal file system
-  their internal file system is configured with the dependencies it needs to run a single process

   -  the process will run until it exits due to completion or failure

-  **their file system and networking exposure is completely isolated by default**

   -  connecting containers to the host machine (or other containers) is possible through configuration
   -  connecting container file systems to a host machine volumes (directories) is possible through configuration

containers are lean
^^^^^^^^^^^^^^^^^^^

-  they require and consume only what is necessary to execute their process
-  they have no additional overhead like a traditional VM

   -  VM overhead includes running a full OS virtually (hypervisor, auxilliary operating system  processes) 
   - **a container is only concerned with its individual (process)**

containers are portable
^^^^^^^^^^^^^^^^^^^^^^^

-  a Docker Container can **be executed and behave the same way on any machine**

   - so long as the host machine has a Linux kernel and Docker Engine

-  this means processes (projects, tools etc) can be easily shared with anyone else who wants to use them

   - once the Docker Image is built it can be shared so others can create Containers from them
   - **this is often referred to as "containerizing" a process**
   - they do not require the consumer to install or perform any configuration! 

containers are predictable and scalable
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  because of their principle of isolation there is no other dependence on the host OS or environmental configuration

   -  container behaviors on a local development machine will behave identically in a production server machine
   - containers have **perfect parity** which makes them so attractive in modern development / DevOps

-  because every container (from the same Image) behaves the same way they can be easily replicated for horizontal scaling

containers are disposable
^^^^^^^^^^^^^^^^^^^^^^^^^

-  containers are designed to be stateless

   -  just as there is no dependence on the host OS there should be no dependence on the internal file system beyond what the Docker Image defines
   -  this means that any changes that occur to the internal container file system during runtime should be treated as ephemeral
   -  if persistence is needed then an external volume can be mounted (binded from the host machine to the container) to retain or use data during runtime

-  because containers are entirely self sufficient they can be easily discarded and re-executed whenever they are needed
  
Docker Compose
--------------

-  uses a ``docker-compose.yml`` file to “compose” multiple containers together into a single “app deployment”
-  a mechanism to run and manage multiple containers that together make up a single application

   -  most applications require several processes to perform their duties
   -  compose lets you create, scale and manage any number of containers that will be “deployed” in tandem

-  compose is made up of **services**

   -  a service is defined by an Image that will be used to build /
      scale Containers of that type
   -  each service can be customized just like an individual Container

      -  internal / external networking and exposure
      -  mounting shared volumes for persistent data

   -  where services depart from regular Containers is in their ability
      to be automatically scaled

      -  compose lets you customize how a service should scale
      -  it will automatically create containers to meet the demands
         defined in the service configuration

-  creates a default “bridge” network to connect the application Containers

   -  internal network (private by default - only accessible by internal containers)
   -  provides hostnames for easy discovery between Containers
   -  hostnames are resolved by internal DNS to Container IP addresses on the internal network
   -  the host machine can be routed to the internal [network] containers for granular control over network access

-  to learn more about Docker Compose see the reference documentation

   -  ``docker-compose`` cheatsheet: `docker-compose
      cheatsheet <https://devhints.io/docker-compose>`__
   -  ``docker-compose`` CLI reference: `Compose command-line reference
      \| Docker
      Documentation <https://docs.docker.com/compose/reference/>`__
   -  ``docker-compose.yml`` file reference `Compose file version 3
      reference \| Docker
      Documentation <https://docs.docker.com/compose/compose-file/>`__
   -  Docker networking reference: `Networking Overview \| Docker
      Documentation <https://docs.docker.com/network/>`__
      

Container Commands
------------------

- interaction with the Docker Engine uses the ``docker`` CLI tool
-  for more information

   -  Docker [Engine] CLI cheat sheet: `Docker CLI
      cheatsheet <https://devhints.io/docker>`__
   -  Docker [Engine] CLI reference: `Use the Docker command line \|
      Docker
      Documentation <https://docs.docker.com/engine/reference/commandline/cli/>`__
      ## Essential Commands
      
-  when you create a container docker will look for the Image:

   -  locally (if you built it locally / pulled it)
   -  on docker Hub

  create a container

.. code:: sh

   $ docker create username/image-name:tag-name

   # or if you know the image ID (in local cache)
   $ docker create IMAGE_ID

   # to view the images in your local cache and find its ID
   $ docker images
..

  start / stop a container that has been created

.. code:: sh

   $ docker start CONTAINER_NAME | CONTAINER_ID
   
   # find the name or id using docker container listing
   $ docker ps # lists all running containers
   $ docker ps -a # lists all containers running or not
..

  to create AND execute a container in one go

.. code:: sh

   $ docker run -d username/image-name:tag-name
   # the -d flag tells it to run in "detached" mode
   # meaning it will not take over the current terminal
   # otherwise it will attach to the terminal
   # CTRL+C will cause the process to exit / container to shut down

   # run a container by an image ID (from local cache)
   $ docker run -d IMAGE_ID

   # sometimes it is useful to run in attached mode (for debugging)
   # just run it without the -d flag
   $ docker run username/image-name:tag-name
..

Command Options
---------------

  to network with a container you must **bind the host machine port to the container port**

-  by default **all containers are completely isolated (at the networking and file system level)**


.. code:: sh

   $ docker run username/image-name:tag-name -p HOST_PORT:CONTAINER_PORT
   # the host port will bind to the container port so that networking requests from the host machine on that port will be proxied to / from the container
   
   # the container must be listening on a port for this to work!
   $ docker run username/image-name:tag-name -p 3000:4000
   # binds the host machine port 3000 to container port 4000
   # curl localhost:3000 will proxy to / from the container on 4000
..

  to mount an external volume (directory) to the Container file system

-  by default containers are considered disposable and self-contained

   -  everything a container needs is defined by its file system configuration in its Image
   -  if you want to persist changes within a container you must mount an external volume
   -  mounting a volume means connecting a host machine volume (persisted) to a container file system (transient)

.. code:: sh

  $ docker run username/image-name:tag-name -v /path/to/host/dir:/path/to/docker/dir
  # the host machine directory at the host path will be mounted into the container at the given container path
  # the container should know to use this volume according to how the Image / process behaves in order to persist changes
..

Useful Commands
---------------

.. code:: sh

   # you can use just the first few characters of the ID to identify it
   $ docker logs -f CONTAINER_NAME | CONTAINER_ID
   
   # view all locally cached images
   $ docker images 
   
   # remove a container (must be stopped or use --force flag)
   $ docker rm CONTAINER_NAME | CONTAINER_ID 
   
   # remove a cached image (must not be in use by a container)
   $ docker rmi IMAGE_NAME | IMAGE_ID 
   
   # tells the container to execute the given command, most commonly to enter the shell of the container (like SSH in a way)
   $ docker exec -it CONTAINER_NAME | CONTAINER_ID COMMAND
   # -it tells the command to bind to the active terminal (STDIN / STDOUT)
