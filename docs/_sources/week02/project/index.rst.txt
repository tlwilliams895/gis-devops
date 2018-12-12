.. _week2_project:

============================================
Week 2 - Project Week - Zika Mission Control
============================================

Learning objectives for this week :ref:`week02-objectives`

Project
=======

* Mission Briefing 1 : `pdf <../../_static/images/zika_mission_briefing_1.pdf>`_


Overview
========

Your goal is to build a web application to help CDC scientists visualize the reports of Zika infection in Central and South America. Using the concepts that you have learned from the past week, build a web application using Spring Boot that serves data to an OpenLayers map (starter code is provided below). Be sure that your web application is properly tested so that you can easily modify the application during the future weeks.

Here are the user stories for your application.

1. Scientists need to be able to populate the database with Zika reports that are in a CSV format.
2. Scientists need to be able to see geographically where these infections are occurring so that they can respond with the appropriate assistance.
3. Since each country reports data slightly differently, scientists need to be able to drill down into the data to understand what each report is saying.

Requirements
============

Here is a mockup of the application you will be building.

.. image:: /_static/images/cdc_zika_dashboard.png

* The database should be populated with Zika report data from Brazil, Mexico, Panama, and Haiti.
* The app should show a red circle for each location that has provided a Zika report.
* Upon clicking on a red dot, the location's name and any reported data show up below the status bar. Remember, each location may report multiple statistics and every country does not report the same statistics.
* Only show unique location names once per listing(don't repeat location names). See bonus screenshot for example.
* Also if one click happens to touch multiple reports, all locations should be shown. See bonus screenshot for example.

Project Hints
=============

* Postgres allows you to import CSV files directly into the database if the columns on your CSV match the columns of in your target database table. Make sure that you have the full path to the file in the copy command.

::

  COPY report(field1, field2, field3, field4) from 
  '/this/is/the/full/path/to/the/file' DELIMITER ',' CSV HEADER;

* Every time Spring Boot starts up, it will run an ``import.sql`` file located in ``src/main/resources``, if the `ddl-auto` property is set to ``create`` or ``create-drop``. This is a convenient way to populate your database via CSV file.
* Remember, Spring Boot is set to recreate your database every time it starts up. That can be changed by adjusting the value of `spring.jpa.hibernate.ddl-auto` in application.properties.

Setup Project
=============

- Fork and clone Zika CDC Dashboard https://gitlab.com/LaunchCodeTraining/zika-cdc-dashboard
- Then create a story branch ``$ git checkout -b week2-solution``

Setup Postgres
==============

Run ``psql`` CLI by double clicking on the ``postgres`` database in the Postgresql App

Open the Postgres UI and double click on the ``postgres`` db to open a ``psql`` command prompt.
In terminal execute this to open a psql session::

  $ psql -p5432 -d postgres

In a psql session run this to create the databases::

  postgres=# CREATE DATABASE zika;
  postgres=# CREATE DATABASE zika_test;

In the psql session, connect to the zika db::

  postgres=# \c zika

Execute these in the psql prompt::

  zika=# CREATE EXTENSION postgis;
  zika=# CREATE EXTENSION postgis_topology;
  zika=# CREATE EXTENSION fuzzystrmatch;
  zika=# CREATE EXTENSION postgis_tiger_geocoder;
  zika=# \c zika_test
  zika_test=# CREATE EXTENSION postgis;
  zika_test=# CREATE EXTENSION postgis_topology;
  zika_test=# CREATE EXTENSION fuzzystrmatch;
  zika_test=# CREATE EXTENSION postgis_tiger_geocoder;

Create a new user for your application by opening Postgres UI and double clicking on the ``zika`` db to open a ``psql`` command prompt connected to the ``zika`` db.::

  postgres=# CREATE USER zika_app_user WITH PASSWORD 'somethingsensible' CREATEDB;
  postgres=# ALTER ROLE zika_app_user WITH SUPERUSER;


Turning In Your Work
====================

Your goal is to have your project done by Friday morning.

* Commit and push your work to GitLab.
* Create a Merge Request in Gitlab
* Ask your instructor and classmates to review your Merge Request

Bonus Missions
==============

If you complete the assignment with time to spare, improve your app by providing context about the size of the Zika outbreak. Use this OpenLayers tutorial https://openlayers.org/en/latest/examples/kml-earthquakes.html as a guide to change the size and color of the feature based on number of cases.

.. image:: /_static/images/bonus_cdc_zika_dashboard.png

Resources
=========

* `CSS Selectors <https://www.w3schools.com/cssref/css_selectors.asp>`_
* `JSON Lint <https://jsonlint.com/>`_
* `geojson.io <http://geojson.io/#map=2/20.0/0.0>`_
* `Spring Data JPA DataRepostiry query documentation <https://docs.spring.io/spring-data/jpa/docs/1.5.0.RELEASE/reference/html/jpa.repositories.html>`_

.. note::

  Remember that both jQuery and OpenLayers will silently fail if they are not given valid JSON and valid GeoJSON (respectively).
