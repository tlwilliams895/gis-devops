.. _week8_project:

===================================================
Week 11 - Project Week: Zika Mission Control Part 4
===================================================

Overview
========

`Read Mission Briefing 4 <../../_static/images/zika_mission_briefing_4.pdf>`_

You will be adding GeoServer to your local and deployed application. This will require several steps, including setting up a GeoServer instance, connecting it to a PostGIS store, and creating a new layer from existing data.

After you have this new system fully set up, you'll be able to add additional layers in GeoServer or use public Geoserver services to display through OpenLayers.

Requirements
============

1. Configure Geoserver to expose Postgis report feature data through a WFS endpoint.
2. Implement the ability for users to request and display the WFS data in the client.
3. Discover and incorporate additional layers in the client using public WMS data sources (like elevation, population, temperature).
4. Integrate Geoserver into your AWS deployment infrastructure.

Setup
=====

The first step in this project week is to download and configure Geoserver. Geoserver can be installed using a VM or a Docker container. In the past week we learned how to run Geoserver in a VM. For this project week we will use a Docker container. Given the popularity of Geoserver there are many public images available to choose from. A user by the name of `kartoza` is heavily involved in the Docker scene for GIS related tooling. They have created a Geoserver image that is both heavily customizable and, as always with Docker, lightweight and portable!

The image we will use can be found at ``kartoza/geoserver`` which includes a Geoserver application served by an underlying Tomcat server. There are many tags available for this image for using different versions and configurations of Geoserver. However, we will be using the ``2.15.2`` tag due to its built-in support for Cross Origin Resource Sharing [CORS].

Cross Origin Resource Sharing
-----------------------------

Recall that CORS headers are required for resources (data) to be shared across origins when accessed through the browser. When a site rendered in the browser requests data from the same server the HTML/CSS/JS originates from we say these are requests to the same origin. However, when the client content is served from one origin (server) and requests data from another origin this is considered `cross-origin`. All modern browsers enforce the `Same Origin Policy` for improving the security by defaulting to rejection of any requests sent to different origins. CORS headers sent by the requested server allow this policy to be "relaxed" by communicating rules about what requests should be allowed. 

In our current deployment we implemented CORS support in the Zika API in order for the browser to allow our front-end client (hosted at its own origin in an S3 bucket) to request API data served from a different origin (hosted in an EC2 instance). In the same way, our Geoserver will need to be configured to allow CORS in order for the WFS data to be received and displayed in the browser.

We could configure the CORS headers ourselves by modifying the Tomcat configuration files. But this is a tedious and delicate process that requires digging into and editing XML. Because it is increasingly common for a Geoserver to be hosted separately from clients that consume its data Kartoza has created an image that is pre-configured to set the headers for us!

This is a relatively large image so you can begin downloading it while completing the next sections by using the following command:

.. code-block:: bash
  
  $ docker pull kartoza/geoserver:2.15.2

.. warning::
  
  Don't run the container after it has been pulled until you have completed the following sections.


Database and Layer Setup
------------------------

Before we start up and configure the Geoserver we will prepare our database to provide data in a format Geoserver recognizes. We will be creating some SQL views that pull in data from different tables that we want to be available as features. These views will then be used by Geoserver to generate queryable layers available through its exposed services.

.. note::
  SQL views are stored commands for creating table-like structures that are built at runtime instead of being persisted as a traditional table. In this way you can aggregate and reshape data from existing tables without having duplicated storage. 
  
  You can query from them just like you would a traditional table including column selection, filters and ordering. 
  

Using the ``psql`` tool connect to your PostGIS database then create two views:

.. code-block:: sql

  CREATE VIEW cases_by_location_and_date AS
    SELECT
      location_id,
      report_date,
      sum(value) AS cases
    FROM reports
    GROUP BY location_id, report_date
  ;


.. code-block:: sql

  CREATE VIEW locations_with_cases_by_date AS
    SELECT locations.id, country, state, report_date, cases, geometry
    FROM locations
    INNER JOIN cases_by_location_and_date
      ON cases_by_location_and_date.location_id = locations.id
  ;

You are free to create any other views you would like using these examples as a template. Try querying from them to see how they work. They will be automatically detected by Geoserver once connected to the Postgis store. Views can then be published for use in the various Geoserver services such as the WFS project requirement.

.. note::

  Don't forget to create these views in your cloud database when you are ready to deploy the Geoserver! If you are using a containerized database instead of an RDS you can replace the existing database container image with the ``launchcodedevops/zika:geoserver`` image which includes both the associated data and the two views from above.

Integrating GeoServer
=====================

Managing Geoserver Configuration Data
-------------------------------------

Recall in your Geoserver training that before we can begin consuming data we first need to configure the workspace, data store, layers and services we want it to expose. Each of these configurations are persisted by writing to files located in an installation directory called ``data_dir/``. The location of this directory depends on how it was installed. In our containerized Geoserver its default location is ``/opt/geoserver/data_dir``. 

Although we will first configure Geoserver locally eventually our goal is to deploy it into our AWS cloud. We are presented with two options to choose from before beginning the configuration. Either save the local configuration, upload it to S3 and apply it in the deployed container or reconfigure the server from scratch once deployed. 

The former approach involves mounting a host directory into the container as a ``bind mount`` so that data is written to the host (our local machine) instead of the container. The latter approach is simpler but will require more time during deployment. In both cases we will need to update the Postgis database connection details to point at our deployed database host.

If we choose to save a copy of the configuration we can use the ``-v`` volume option in the run command for the container. Bind mounting a volume is simply connecting a host machine directory to a container directory. Much in the same way that we use the ``-p`` option to "publish a port" which is just binding a host port to the container process' port.

.. code-block:: bash

  -p <host port>:<container port>

.. note::

  If you would like to read more about bind mount volumes the `Docker bind mount documentation <https://docs.docker.com/v17.09/engine/admin/volumes/bind-mounts/>`_ is a well-written resource.

The general form for mounting a volume through a run command is:

.. code-block:: bash

  -v </host/directory/path>:<container/directory/path>:<bind options>

As an example if we wanted to mount the host directory ``~/geoserver/data`` to the container's configuration directory ``/opt/geoserver/data_dir`` with ``rw`` or `read-write` ability we would use:

.. code-block:: bash

  -v ~/geoserver/data:/opt/geoserver/data_dir:rw

Now when the container is started all of the configuration data will be written to the bind-mounted volume on the host at ``~/geoserver/data``. Later when we deploy the Geoserver we can upload this directory and mount it to the deployed container to save time having to reconfigure it!

.. warning::

  While this shortcut will save you from having to reconfigure the entire server during deployment **you will still need to update the Postgis data store connection details to point at the EC2 (or RDS) database in your VPC.**


Start Geoserver
---------------

Once the image has been pulled we can run the container using the following command. If you choose to bind mount a volume don't forget to include that option in the ``run`` command.

.. code-block:: bash
  
  $ docker run -d -p 8081:8080 --name zika-geoserver kartoza/geoserver:2.15.2

Create a Zika Workspace
-----------------------
  
  ``name``: ``zika``
  
  ``namespace URI``: ``https://zika.devops.launchcode.org``
  
  you do not need to check either of the boxes (default, isolated)  

Configure a PostGIS Data Store
------------------------------

* Create a PostGIS data store using the Zika PostGIS database credentials. If you are running the ``launchcodedevops/zika`` database container then the following credentials can be used:

  * name: ``zika``
  * host: ``localhost``
  * port: ``5432``
  * username: ``zika_user``
  * password: ``zika``

.. note::
  
  When deploying the Geoserver you will need to update the ``host`` parameter to point at your PostGIS EC2 instance IP or RDS endpoint.


Create a View Layer
-------------------

* Create a new layer from the ``locations_with_cases_by_date`` view

  * Make sure Native and Declared SRS are set to **EPSG:4326**
  * For Native Bounding Box, click on **Compute from data**
  * For Lat/Lon Bounding Box, click on **Compute from native bounds**

Updating OpenLayers Code
------------------------

Following the `OpenLayers example <https://openlayers.org/en/latest/examples/vector-wfs-getfeature.html>`_ for querying ``GetFeature``, update your OpenLayers code to query GeoServer to get locations with report totals by date. You'll need to use the ``ol.format.filter.equalTo`` filter. 

.. note::

  Take a look at the many filters available. Get creative with the search tool you create for WFS requests!

.. warning::

  For the geometries in your layer to be rendered properly on the map, the spatial reference systems (SRS) must match the base layer of the map. **If they do not your features can be distorted or silently fail which can be extremely challenging and frustrating to debug.** The Open Street Maps (OSM) base layer we have been using has the SRS ``EPSG:3857`` while our PostGIS data has a default SRS of ``EPSG:4326``. You can control the SRS that is used to generate the returned features by setting the ``srsName`` parameter when creating the get feature request in OpenLayers.

Deploying GeoServer
===================

Introduce a new instance to your cloud deployment that will run the Geoserver. This instance should run the Geoserver container much like the Elasticsearch and PostGIS instances.

.. note::

  If you chose to store the Geoserver configuration data you can upload it to an S3 bucket then copy it into the instance during deployment. Once copied into the instance just mount it into the container when issuing the ``docker run`` command.

.. note::

  Always try to script as much as possible in the ``user data`` section of the EC2 instance configuration. Production deployments rarely, if ever, involve any setup done through SSH.

.. note::

  Be mindful when sizing your EC2 instance. Like Elasticsearch the Geoserver container consumes quite a bit if memory (around ``1.75GB`` during usage) so smaller instance types will not be suitable.


Bonus Missions
==============

.. note::

  Only consider these bonus missions **after completing all the core requirements for this project week.**

Docker Compose Deployment
-------------------------

If you want to gain more advanced practice with Docker you can also consider using ``docker-compose`` to deploy everything within a single EC2 instance. This approach creates a back-end `stack` which runs the primary Zika API and Geoserver services along with the backing services of the PostGIS and Elasticsearch databases. Your VPC will be simplified by only requiring a single instance. Once you have it working you can safely remove the previous EC2 instances.

.. warning::

  This is a rather involved bonus mission and you will likely need help from your instructor. Start by creating the ``docker-compose.yml`` file and testing it out locally to make sure it works as expected. The good news is once it works on your machine it will work just the same in an EC2 instance!

You will want to refer to the `docker-compose file reference <https://docs.docker.com/compose/compose-file/>`_ along with the practice project covered in the prep weeks to develop your compose file. Remember that writing a compose file is like writing a script for running several containers at once. Think about the options you use when running each container manually with ``docker run ...`` then translate those into service definitions.

.. note::

  It is easy to get overwhelmed with all of the compose directives listed in the reference. Stick with version ``3+`` and only refer to directives for options you actually need instead of reading it from top to bottom.

.. note::

  Gradually build up the compose file to make debugging easier. Start by writing one service. Then add another service one at a time while testing in between to make sure the stack is working. Once you understand how to configure a service you will find the others are intuitive to add.

.. note::

  In order to run the stack you will need to use a ``Dockerfile`` for creating an up-to-date Zika API image. This way the built image will always be up to date according to the latest ``app.jar`` file sent to the instance (manually or via pipeline)

.. code-block:: Dockerfile

  FROM launchcodedevops/openjdk8-jre

  # expects app.jar to be in the same directory as this Dockerfile
  COPY app.jar app.jar

  CMD [ "java", "-jar", "app.jar" ]

.. note::

  You should bundle all of the files needed for the stack: ``docker-compose.yml``, ``.env``, ``Dockerfile`` (for the API) and the geoserver data (if you want to use a saved configuration). Create a ``compose`` directory in your Zika API repo to hold all of these files and add them to version control. You can then upload the directory to an S3 bucket to make it easy to copy into the host EC2 instance.

You can use the following commands to test and manage the compose stack:

.. code-block:: bash

  # issue these from within the directory with the docker-compose.yml file

  # test the compose file for errors - if no errors are found the file contents will be printed
  $ docker-compose config

  # start up the stack in detached mode
  $ docker-compose up -d

  # shut down the stack
  $ docker-compose down

  # view stack containers
  $ docker-compose ps

  # view memory usage of all containers in the stack
  # thanks to https://github.com/docker/compose/issues/1197#issuecomment-405207016
  $ docker-compose ps -q | xargs docker stats


Geoserver Elasticsearch Integration
-----------------------------------

Check out the `ElasticGeo Plugin <https://github.com/ngageoint/elasticgeo>`_. It is an Elasticsearch plugin that allows you to integrate Elasticsearch into GeoServer. The great thing is that you can do Elasticsearch queries directly through GeoServer via WFS calls. Here are the setup instructions and instructions on how to make the calls: `ElasticGeo Instructions <https://github.com/ngageoint/elasticgeo/blob/master/gs-web-elasticsearch/doc/index.rst>`_
