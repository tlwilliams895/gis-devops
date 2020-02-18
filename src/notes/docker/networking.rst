.. _docker-networking:

Networking Between Containers
=============================

So far we have learned how to run containers, like our PostGIS database, which we have used for local development and testing. We have been connecting to this database using ``localhost`` and ``5432``, the **published port** of the container.

You are able to connect to your published containers through ``localhost:PORT`` because that process "originates" from the local machine itself. Technically the process originates from a container. But we publish, or bind, a host port to a container with ``docker run -p <host>:<container>``. From that point onward any connections made on the [local] host machine's port will be forwarded to the published container.

.. note::

  ``localhost`` is a **hostname** for a machine relative to a process it is running. Like any other hostname it is used to identify a machine on a network without having to rely on a fixed IP address thanks to DNS resolution. ``localhost`` is resolved to the *home* IP address ``127.0.0.1`` of *that machine* using a special mechanism called a `loopback <https://www.hostinger.com/tutorials/what-is-localhost>`_. In simple terms the loopback was made for simulating networking from within a single machine. This is really useful for us when we are developing applications locally!


.. tip::

  You can't use ``localhost`` in a container to network with anything but processes running **inside it**. Because containers behave like their own machines so ``localhost`` refers to their *own machine* that runs their respective process. Other services (processes) are in *their own* containers [machines], each with *their own* ``localhost`` resolution. 

So how do we connect two or more containers? Generally speaking this is a question about **networking between machines [containers] on a network**. There are three options to consider for networking within the same Docker host:

* The simplest, but least reliable, solution is to use the default container network
* A less scalable, but more reliable, solution is to use a custom bridge network
* A (relatively) more complex, but more scalable and reliable, solution is to use ``docker-compose``

.. TODO: link to docker-compose notes or add networking with docker-compose section here
.. You will learn more about ``docker-compose`` `later in the course <>`_. 

Using the Default Network
=========================

By default all containers are connected to the ``bridge network`` when they are created. This network (along with the ``host`` and ``none`` networks) are all created automatically when the Docker daemon starts up. Within the ``bridge network`` every container is assigned a private (internal) IP address. These addresses are assigned within the ``bridge network``'s subnet[work] range.

Containers can connect to each other using these private IP addresses. In the same way that any two machines on a network can connect to each other by their IP addresses. However, addresses on a network are rarely static. 

Typically addresses are dynamically assigned as machines are added and removed from it. Containers behave the same as they are created and destroyed or assigned and unassigned from the default ``bridge network``.

.. warning::

  **The addresses assigned to containers on a network will only be constant for as long as the containers exist on the network**. If we "hard-code" the use of one of these IP addresses there is no guarantee that it will be assigned to the same container in the future!

You can list all of the networks (default and custom) using the following command:

.. code:: bash

  $ docker network ls

You can also inspect the details of a network using Docker. This will show you information about the network including with the containers that are assigned to it. You can see the network's subnet range under ``IPAM.Config.Subnet``. Under ``Containers`` you can see all of the containers connected to the network and their IP addresses (notice how they are all within the subnet range):

.. code:: bash

  # inspect a network
  $ docker network inspect <network name>

  # inspect the default bridge network
  $ docker network inspect bridge

  # use sed to only show the container information (between Containers and Options sections)
  $ docker network inspect bridge | sed -n '/Containers/,/Options/p'

To connect one container to another you just use their IP addresses along with the port the container's process is running on.

.. note::

  Containers are completely isolated from the host machine in terms of networking (and file system access) by default. But unless a container is assigned to another network when it is created it will **always join the default** ``bridge network`` and be accessible by any other container within it. **Even if the container hasn't published or exposed its port!**

By far using the default network addresses is the simplest mechanism of networking between containers. It can work great in a pinch. But this simplicity comes at the cost of reliance on unchanging addresses - which is not a practical expectation. In the next approach we will learn how to use hostname **aliases** in a custom network to *resolve* this dependency on a fixed IP address.

.. note::

  Did you spot the pun? You will after reading the custom network approach!

Using a Custom Network
======================

In the previous section we learned about using hard-coded container IP addresses on the ``default bridge network``. We also learned how using the IP addresses can lead to inconsistent behavior due to the ephemeral nature of containers and, by extension, their assigned addresses within a network.

Fortunately Docker lets us create *custom user-defined networks* that support networking between containers using aliases, or **hostnames**, instead of their mutable IP addresses. In these custom networks the **aliases remain constant** and are resolved into the IP address the containers are assigned. The hostname resolutions in each network are handled by an internal DNS that Docker manages. 

.. note::

  Aliases can only be used in custom networks. Within the default ``bridge network`` only the assigned IP address can be used to network with other containers.

Instead of hard-coding an IP address we can refer to a container by its alias and its internal IP will be resolved to the correct address. Even if that address changes in the future. **This is true as long as the container is on the same network and given the same alias.**

.. note::

  Using an alias for a container's internal IP address on a network is no different than using ``localhost`` as an alias for ``127.0.0.1`` on your laptop. Because ``localhost`` is just that - the **local host[name]** of your machine!

.. tip::

  Docker networking can be a pretty complicated topic. `There are a lot of different network types <https://docs.docker.com/network/>`_ (including custom drivers). Each has pros and cons depending on the context of the system.
  
For our purposes we are only concerned with networking between containers **on the same Docker host**. This simplifies things for us. We can use a custom **bridge network** which happens to be the default driver used when issuing the ``network create`` command: 

.. code:: bash

  # create a bridge network by the given name
  $ docker network create <network name>

  # view all networks (3 defaults and the custom one created above)
  $ docker network ls


Connecting Containers On a Custom Network
-----------------------------------------

Once you have created a custom network you can start connecting containers to it. Containers can be added when they are created by using the ``--network <network name>`` option of ``docker run``. Or they can be added (and removed) after being created using the ``docker network connect/disconnect`` commands.

.. note::

  If a container is added to a network *after being created* it will be connected to both the default ``bridge network`` *and* the new network.

In a custom network the alias of each container can be:
  
* the container name, assigned using the ``--name`` option in ``docker run``
* the container ID, assigned automatically to all new containers
* the service name of a container created through ``docker-compose``
* a custom alias assigned using the ``--alias`` option in ``docker network connect``
* one or more custom aliases using the ``--network-aliases`` option in ``docker run``

Below is a list of useful commands for managing containers and their aliases within a custom network:

.. code:: bash

  # connect a container whose hostname will be the container name
  $ docker network connect <network name> <container name>

  # connect a container with a custom alias
  $ docker network connect --alias <custom alias> <network name> <container name>

  # disconnect a container
  $ docker network disconnect <network name> <container name>

  # connect to a custom network (instead of the default bridge) when running a container
  $ docker run --network <network name> ...

  # connect to a custom network AND give the container alias(es) on that network
  $ docker run --network <network name> --network-alias <alias name>[,<other alias name>,...] ...
 
.. tip::
  
  When using a custom network you can replace your intuitive usage of ``localhost`` with the alias, or hostname, of the container [another machine] you want to connect to.  **As long as both those containers [machines] are on the same network**.

Two Containers and a Network
----------------------------

Let's look at a generalized example using two containers and a custom network. In this example the ``service-one`` container needs to connect to the ``service-two`` container:

.. code:: bash

  # create the network
  $ docker network create my-network

  # create the containers and connect them to the network
  $ docker run --name service-one --network my-network ...
  $ docker run --name service-two --network my-network ...

Now within the ``service-one`` container we can connect to ``service-two`` by its by its container name ``service-two`` (instead of ``localhost``)! The same is true from ``service-two`` to ``service-one`` using the latter's alias. 

You can test how the container name aliases get resolved to their private IP address on the network by issuing a ``curl`` request from within one of the containers and using the *verbose* option ``-v`` to see the connection steps in detail:

.. note::

  The container must have ``curl`` installed to perform this test. Many container's are slimmed down to only include the programs needed to support their main process and may not have ``curl``. 

.. code:: bash

  # note the container must have curl installed for this to work!

  # the curl -v option prints out connection details
  $ docker exec <container name> curl <other container alias>:<port> -v

  # you will get an output like this
  * TCP_NODELAY set
  * Connected to <container alias> (172.X.X.X) port <port> (#0)
  > GET / HTTP/1.1
  > Host: <alias>:<port>

Using curl is a simple example to show how connections are formed. You can see how the container's hostname is resolved to its IP address on the second line. In practice you will be forming database or service to service connections for more useful business!

.. tip::

  The same process can be repeated for any number of containers **as long as the containers are on the same network and you use their aliases to connect**.

Custom Network Example
----------------------

We will create a basic HTTP server container, ``server``, and a container with the ``curl`` program installed, ``client``. The ``server`` container will serve a file with a message which the ``client`` container will request using ``curl``. 

First create the network:

.. code:: bash

  $ docker network create networking-test

Now create the message file:

.. code:: bash
  
  # create a temporary directory to mount in the container
  $ mkdir /tmp/networking-test

  # create the file
  $ echo 'using container aliases works!' > /tmp/networking-test/message

Next let's run the ``server`` container. We will be using the ``launchcodedevops/simple-http`` image for this example. It runs a ``python`` simple HTTP server process on port ``8080``. It serves any files that are in the ``/var/www/`` directory within the container. We will use a ``bind mount`` to mount our temporary directory, in the host machine, onto the serving directory, in the container, so we can access the file from the ``client``:

.. code:: bash

  # the :ro volume option means "read-only"
  $ docker run -d --rm --name server --network networking-test -v /tmp/networking-test/:/var/www/:ro launchcodedevops/simple-http

.. tip::

  The ``--rm`` option will automatically remove a container when it exits or is stopped by the host

Create the ``client`` container which is just a basic image with the ``curl`` program installed. We will use this container to make ``curl`` requests against the ``server`` container:

.. code:: bash

  $ docker run -itd --name client --network networking-test launchcodedevops/simple-client

Inspect the network to see that both the containers are connected to it. Notice the ``Containers.Name`` field for the ``server`` container. This is the hostname **alias** we will use to connect over the custom network:

.. code:: bash

  $ docker network inspect networking-test

  # or print just the Containers section using sed
  $ docker network inspect networking-test | sed -n '/Containers/,/Options/p'

.. note::

  Take note of the ``server`` container's IP address on the network

Now let's use the ``exec`` command to *execute* a ``curl`` request from the ``client`` container to the ``server`` container on port ``8080``. We will request the ``message`` file from its serving directory to see if our networking test succeeded...

.. code:: bash

  # the -v, verbose, option will show connection data
  $ docker exec client curl -v server:8080/message

  # output
  # we can see how the alias was resolved into the container IP on the network 
  ...
  * Connected to server (172.28.0.2) port 8080 (#0)
  > GET /message HTTP/1.1
  > Host: server:8080
  ...
  <
  using container aliases works!

  
Clean up by stopping the containers, remove the network and delete the temporary directory:

.. code:: bash

  # once the containers are stopped they will remove themselves automatically
  $ docker stop server client

  # remove the network
  $ docker network remove 

  # remove the temp directory and file
  $ rm -rf /tmp/networking-test