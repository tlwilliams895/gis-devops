.. _week2_project:

============================================
Week 2 - Project Week: Zika Mission Control
============================================

Zika Mission Control
====================

Throughout this class we will build on the Zika Mission Control project every single project week.

This project will be our chance to practice the concepts we learned in the previous instruction week.

Each week we will have a list of requirements that we will need to build into our project.

Project Overview
================

The Zika Mission Control dashboard will be a Spring web application. It will display an interactive map from OSM. The map will present a layer of features that represent an outbreak of Zika. Each representation of a Zika report will be clickable, and upon a click event the user will see more information about that specific report.

Each week we will build on our currently existing project, so it is crucial to finish the primary objectives for each project week!

Here is a mockup of the application you will be building.

.. image:: /_static/images/cdc_zika_dashboard.png


Project Requirements
====================

Following are the requirements from our stakeholders, and our tech team.

Stakeholder Requirements
------------------------

- Zika Reports, that are currently stored in CSV files, need to be stored in a Relational Database.
- Zika Reports need to be geographically displayed on an interactive map.
- Zika Reports are clickable, upon clicking a report more information about that report is displayed.

Technical Requirements
----------------------

- Code base is managed with Git, and a remote repository is managed with GitLab.
- TDD: Tests are to be written before features are implemented.
- Unit Testing: Individual Models needed to be tested.
- Integration Testing: Controllers, and JpaRepositories need to be tested.
- PSQL/PostGIS: need to be used as the primary data store for the Zika reports.
- Spring: Spring will be used to handle the HTTP Requests, serve the HTTP Responses, and work with the database.
- Javascript: Javascript, AJAX, and jQuery should be used to load the map, and work with the zika report data.
- OpenLayers: An interactive map should be used from OSM, Zika reports should be loaded onto the map as a new Feature Layer.

There are many ways we could go about building this project, but we must follow the provided requirements.

Primary Objectives
==================

For your primary objectives articles have been provided to help you think about what needs to be completed to pass the objective.

0. `Create a Spring application <../spring-application/>`_, setup Git, and GitLab, configure the DB, and prepare IntelliJ.
1. `Display an interactive map <../display-map/>`_ from OSM in the browser.
2. `Display Zika reports <../display-reports/>`_ on the map as red circles.
3. When `Zika reports are clicked <../clickable-reports>`_ more information about the report is displayed.

Secondary Objectives
====================

For your secondary objectives no guidance will be given to you. You will have to think about what needs to be completed to pass the objective.

- Zika reports change color based on the sevirity of the outbreak.
- Zika reports change size based on the sevirity of the outbreak.
- Duplicate city/state/country names are not displayed if more than one report is selected.
- Sensitive Database information has not been committed to our version control software.
- Database is secure from SQL injection.

Turning in Your Work
====================

Code Review
-----------

Let your instructor know When you complete the primary objectives. The instructor will need a link to your GitLab repo, and they will peform a code review, and leave you feedback.

Objective Checklist
-------------------

As you work through the objectives for this week, keep track of them on your Checklist, your instructor will also confirm which objectives you completed in their code review. If you don't pass an objective the instructor will give you feedback on what you need to do to complete that objective.

Presentation
------------

Friday afternoon, everyone will present their project to the class. At the end of this course, you will have to present your project to your coworkers at the NGA.

This presentation is meant to be a celebration of your hard work throughout the week, and as a chance for you to share, and learn from the other students in the class.


OLD
===

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
