:orphan:

.. _spring-data-jpa-hibernate-walkthrough:

====================================================
Walkthrough: Cars Demo - Spring Data, JPA, Hibernate
====================================================

In this walkthrough, we revisit the `Car Integration Tests <https://gitlab.com/LaunchCodeTraining/car-integration-test-starter>`_ that we worked on in yesterday's walkthrough :ref:`SIT-walkthrough`. We'll refactor the app to use Postgres and Hiberante.

Setup
-----

1. In the terminal go to project folder for **Car Integration Tests**
2. Checkout the branch that contains the solution for the Day 3 walkthrough. Example: ``$ git checkout master`` or ``$git checkout solution``
3. Create a new branch for today's work: ``$ get checkout -b day4-add-hibernate``

Our Tasks
---------

Each section outlines one task or group of tasks we need to complete.

Set Up A Postgres DB
====================

1. From ``psql``, create a Postgres user: ``psql=# create user car_user with encrypted password 'catdogbluehouse';``
2. Create a database: ``psql=# create database car;``
3. Grant the user access to the database:``psql=# grant all privileges on database car to car_user``


Configure the App to use the Database
=====================================

In intellij, open ``/car-integration-tests/src/main/resources/application.properties`` then set each of these values::

    spring.datasource.url=jdbc:postgresql://${APP_DB_HOST}:${APP_DB_PORT}/${APP_DB_NAME}
    spring.datasource.username=${APP_DB_USER}
    spring.datasource.password=${APP_DB_PASS}
    spring.jpa.hibernate.ddl-auto=update


.. note::

  Committing passwords to source control is a BAD idea. We are using a spring data feature that searches for and uses enviroment variables. `Read more about Spring Boot/Data configuration. <https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-external-config.html#boot-features-external-config>`_

Intellij Run Configurations
===========================
We will use **Run Configurations** to set the **Environment Variables**.

.. image:: /_static/images/run-configurations.png


Update Gradle Dependencies
==========================

Add the associated Postgres dependency to ``build.gradle`` as a compile-time dependency.
Set the existing h2 dependency to be a ``testCompile`` dependency, since it will only be needed for running tests at this point.::

    dependencies {
        runtime('org.springframework.boot:spring-boot-devtools')
        compile('org.springframework.boot:spring-boot-starter-data-jpa')
        compile('org.springframework.boot:spring-boot-starter-thymeleaf')
        compile('org.springframework.boot:spring-boot-starter-web')
        compile(group: 'org.postgresql', name: 'postgresql', version: '42.1.4')
        testCompile('com.h2database:h2')
        testCompile('org.springframework.boot:spring-boot-starter-test')
    }


Add Annotations to Car Model
============================

.. code-block:: java

    package org.launchcode.training.models;

    import javax.persistence.Entity;
    import javax.persistence.GeneratedValue;
    import javax.persistence.GenerationType;
    import javax.persistence.Id;

    @Entity
    public class Car {

        @Id
        @GeneratedValue(strategy= GenerationType.IDENTITY)
        private int id;
        //rest of class is not shown...


Add CarRepository
=================

.. code-block:: java

    package org.launchcode.training.data;

    import org.launchcode.training.models.Car;
    import org.springframework.data.jpa.repository.JpaRepository;
    import org.springframework.stereotype.Repository;

    @Repository
    public interface CarRepository extends JpaRepository<Car, Integer> {
    }

Autowire Repositories into Controllers
======================================

.. code-block:: java

    @Controller
    @RequestMapping("car")
    public class CarController {

        @Autowired
        private org.launchcode.training.data.CarRepository carRepository;


Autowire Repositories in Tests
==============================

.. code-block:: java

    @RunWith(SpringRunner.class)
    @IntegrationTestConfig
    public class CarControllerTests {

        @Autowired
        private MockMvc mockMvc;

        @Autowired
        private CarRepository carRepository;

Configure Test DB
=================

Add a ``/car-integration-tests/src/test/resources/application-test.properties`` file with below contents.

.. code-block:: java

    spring.datasource.driver-class-name=org.h2.Driver
    spring.datasource.url=jdbc:h2:mem:test
    spring.jpa.properties.hibernate.dialect = org.hibernate.dialect.H2Dialect
    spring.jpa.hibernate.ddl-auto=update

We need to make sure our test properaties are used when running tests. Add the below code to ``/car-integration-tests/src/test/java/org/launchcode/training/IntegrationTestConfig.java``.
The ``@Transactional`` annotation insures that any sql executed during a test will only exist for that single test and won't pollute another test.

.. code-block:: java

    @TestPropertySource(locations = "classpath:application-test.properties")
    @Transactional

Do the Tests Pass?
==================
If not, fix them ;p
