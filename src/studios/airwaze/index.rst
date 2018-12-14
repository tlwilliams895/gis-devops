:orphan:

.. _airwaze-studio:

================
Studio: Airwazes
================

Your goal is to add an additional layer that shows flight routes and display it on the map.  This time we will incorporate our map into a Spring Boot project. We will store geographic data in our Postgresql database. Some starter code has been provided for you.

Set Up Project
==============
* Fork and clone this `Gitlab project <https://gitlab.com/LaunchCodeTraining/airwaze-studio>`_.
* Then open the project in IntelliJ
* Create a story branch ``$ git checkout -b day5-solution``

What is PostGIS?
===============
`PostGIS <https://postgis.net/>`_ is a spatial database extension for PostgreSQL object-relational database. PostGIS adds support for geographic objects in Postgresql. This includes features such as georgraphic data types, location functions, and location based querying.

Install PostGIS on your Computer
================================
- Make sure your Postgresql server is running. Remember we used https://postgresapp.com/ to install Postgresql, which automatically created a service that we can start and stop via its UI in the menu bar.
- To install the PostGIS extension, run the below commands in terminal

  - Note that this makes the extension available on your computer, but you will need to run additional commands to enable them in a specific database. More on that in the Enable Extension section. 
  
  ::

    $ brew update
    $ brew install postgis

Create a Database for the Airwaze Data
======================================
Run ``psql`` CLI by double clicking on the ``postgres`` database in the Postgresql app.

Open the Postgres UI and double click on the ``postgres`` db to open a ``psql`` command prompt.

.. image :: /_static/images/postgresapp-db-icon.png

Run the Create Command
^^^^^^^^^^^^^^^^^^^^^^
Then in the postgres termainl run this to create a new database::

    postgres=# CREATE DATABASE airwaze;


Also create a database for your tests::

    postgres=# CREATE DATABASE airwaze_test;

Enable Geospatial Extensions in the Airwaze Database
=====================================================
Now we want to install the geospatial extensions to Postgres for the ``airwaze`` db. Open the Postgres UI and double click on the ``airwaze`` db to open a ``psql`` command prompt connected to the ``airwaze`` db::

    airwaze=# CREATE EXTENSION postgis;
    airwaze=# CREATE EXTENSION postgis_topology;
    airwaze=# CREATE EXTENSION fuzzystrmatch;
    airwaze=# CREATE EXTENSION postgis_tiger_geocoder;


Make sure that everything installed correctly by running this query
- Remember to do that for your test database ``airwaze_test`` as well!::

   airwaze=# SELECT POSTGIS_FULL_VERSION();

Create Users and Grant Access Rights
====================================
* Create users ``airwaze_user`` and ``airwaze_test_user``
* Grant the users access to only what they need ``airwaze_user`` -> ``airwaze`` and ``airwaze_test_user`` -> ``airewaze_test``
* For hints on above, go look at Week 1 Day 4 Walkthrough
* After you have created the users, you need to grant special ``superuser`` rights because we are going to be running a file with ``postgres``

.. code-block::sql

    ALTER USER airwaze_user with superuser;

Now Let's Use the New Database
==============================
Notice in ``application.properties`` and ``application-test.properties`` that the db configurtion refers to token values like ``${APP_DB_NAME}`` and ``${APP_DB_HOST}``.

- Define each in environmment variables OR in Intellij run configurations
- Do not commit db config information to source control

Review import.sql and CSV files
=====================================

This application uses Spring Boot and Spring Data.  When the project boots up, **if** you have a ``src/main/resources/import.sql`` file, it will automatically be executed against your database by hibernate. 

- **NOTE** ``import.sql`` only runs if ``ddl-auto=create or create-drop`` in ``application.properties``
- `More information on Spring Data initialization <https://docs.spring.io/spring-boot/docs/current/reference/html/howto-database-initialization.html#howto-initialize-a-database-using-hibernate>`_

The ``import.sql`` file in this project contains SQL statements that import CSV data into SQL tables. Please take a minute to review ``import.sql`` and the two ``.csv`` files.

- Review the ``import.sql`` file in the airwaze project
- Be sure that the ``import.sql`` points to **your** local copies of the ``airports.csv`` and ``routes.csv``. It needs to be the "full path" to each file on your local computer.
- You will need to change the path value for both files listed. ``/Users/YOUR-USERNAME/YOUR-PATH/airwaze-studio/routes.csv``
- Open the ``csv`` files to see what data is being imported for routes and airports

Run the Application and Populate the Database
=============================================

* Run the ``bootRun`` gradle task to build and run the web application
* Make sure there aren't any errors in the log.
* When the Spring Boot application starts it will execute the ``import.sql`` file and populate the related tables
* Then go to ``http://localhost:8080`` in your browser. You should see a map with Mexico on it that includes a map layer for airports as red circles.

.. image :: /_static/images/airwaze-example.png

Review the Tables and Data in Postgis
======================================================
Open a ``psql`` prompt connected to ``airwaze`` database and then run these commands one at a time::

    airwaze=# select count(*) from route;
    airwaze=# select count(*) from airport;
    airwaze=# \d
    airwaze=# \d airport
    airwaze=# \d route


Review AirportController
========================

* Visit this url in your browser: http://localhost:8080/airport/.  Note the trailing ``/`` is important.
* Then look at the code that returns that data.

Tasks
=====
1. When the map is clicked, list all airports that are at that pixel
   
   * You will need to add more code to the function ``map.forEachFeatureAtPixel(event.pixel, function(feature,layer)`` in ``resources/static/js/scripts.js``

2. Create a route endpoint that returns routes for a certain srcId.

   * Example: ``http://localhost:8080/route/?srcId=12``

3. When an airport feature is clicked on the map, show the routes for that airport
   
   * By adding a router layer that only contains routes connected to the clicked airport
   * The data for the new layer will be provided by ``http://localhost:8080/route/?srcId=X``, where X will be the ``airportId`` from the feature

4. Write integration tests for ``RouteController`` use ``AirportControllerTests`` as a guide

Bonus Missions
==============
* Get this to work **without** jQuery. Hints: `fetch <https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch>`_ and ``document.findElementById``
* Change the style of the dots: color, size, fill in
* Sort airports by alpha order when they are displayed below the map
* Check what kind of feature was clicked when map.onclick runs
* Remove previous route layers when adding a new one

Solution Screen Shot
====================
(Your list of airports can be organized and styled differently)

.. image :: /_static/images/airwaze-solution-example.png

Resources
=========
* `Read about constructing GeoJSON <https://macwright.org/2015/03/23/geojson-second-bite>`_
* `OpenLayers Examples <https://openlayers.org/en/latest/examples/>`_
* `Adding and Removing Layers with OpenLayers <http://www.acuriousanimal.com/thebookofopenlayers3/chapter02_01_adding_removing_layers.html>`_
* `Validate your GeoJSON! <http://geojson.io>`_
* `OpenLayers Drawing Examples <http://openlayers.org/en/latest/examples/geojson.html>`_
* `JSONPath <http://goessner.net/articles/JsonPath/>`_
