:orphan:

===================
Learning Objectives
===================

**Conceptual Objectives**: concepts or terminology you should be comfortable defining and discussing

**Practical Objectives**: methods, syntax, or commands you should be capable of using

Week 4
======

.. _week-code-quality-day1-objectives:

Day 1
-----

Conceptual
^^^^^^^^^^

- What are dependencies?
- What are dependency repositories?
- What is Semantic Versioning (SemVer)?
- What is a dependency manager?
- What is NPM?
- What are NPM scripts?
- What is a build tool?
- What is Gradle?
- What is the Gradle wrapper?
- What are Gradle tasks?
- What is a coding style guide?
- What is code linting?
- What is CheckStyle?
- What is ESLint?
- When should you lint your code?

Practical
^^^^^^^^^
- Search for dependencies in the Maven and NPM repositories
- Register dependencies in ``build.gradle``
- Register dependencies in ``package.json``
- Categorize production and development dependencies in Gradle or NPM
- Execute Gradle tasks from Intellij and the CLI
- Execute NPM scripts from the CLI
- Use code linters in Java and JavaScript projects

.. _week-code-quality-day2-objectives:

Day 2
-----

Conceptual
^^^^^^^^^^

- What is manual testing?
- What is automated testing?
- What is an assertion?
- What is a testing framework?
- What is a unit test?
- What is a test suite?
- What are happy and unhappy test paths?
- What is Test Driven Development (TDD)?
- What is the Red-Green-Refactor workflow?
- How can TDD help developers stay in scope?
- Why should tests be agnostic of implementation details?
- What is the mirroring strategy for test code organization?
- What functions or methods should and shouldn't be tested?
- What is code refactoring?
- How can automated testing protect against code regression?

..
  TODO: do we fit Security in here?
  - Importance of Security Culture in your organization
  - Awareness of OWASP guidelines
  - Introduction to security vulnerabilities
  - Introduction to security tools

Practical
^^^^^^^^^

- Use IntelliJ to generate test boilerplate
- Identify and define the inputs and outcome of the happy path test
- Identify and define the inputs and outcomes of any unhappy path tests
- Use user story requirements to design unit tests
- Use JUnit annotations and assertions to configure test cases
- Design and use IntelliJ runtime configurations
- Run JUnit test(s) from IntelliJ and the CLI
- Follow the TDD process to write passing implementations
- Follow the TDD process to refactor existing implementations

.. _week-code-quality-day3-objectives:

Day 3
-----

Conceptual
^^^^^^^^^^

- What are integration tests?
- How do integration tests differ from unit tests?
- What is a setup and teardown?
- Why is it important for tests to not share a mutable state?
- What is an assertion library?
- What is a testing database?
- What is dependency injection?
- What is tight coupling and why is it detrimental?
- What is loose coupling and why is it beneficial?
- How does dependency injection support loose coupling?
- What are Spring Components and how are they registered?
- How does the Spring Container manage Components and dependency injection?

Practical
^^^^^^^^^

- Create custom integration test configuration annotations
- Register Spring Components using appropriate annotations
- Use the ``@Autowired`` annotation to inject dependencies into test suites
- Use Spring Test's ``MockMVC`` to mock endpoint requests
- Use Spring Test's ``MockMVC`` assertion methods to validate response headers and status codes
- Use assertion library methods to test HTML endpoint response bodies
- Use assertion library methods to test JSON endpoint response bodies

.. 
  TODO: discuss grouping GeoInt ref links instead of under code quality?

.. _week-code-quality-day4-objectives:

Day 4
-----

Conceptual
^^^^^^^^^^

- What is GeoInt?
- What is a GIS?
- How does a GIS support GeoInt?
- What is the GeoJSON format?
- What are Point, LineString, Polygon, MultiPolygon geometry formats?
- What are Features and FeatureCollections?
- What is PostGIS and how is it used?
- What is GeoServer and how is it used?
- What is OpenLayers and how is it used?
- What are GIS layers?
- What are the differences between Vector, Tile, and Image layers?


Practical
^^^^^^^^^

- Create a map visualization using OpenLayers
- Use the OpenStreetMaps tile data
- Request map layer data through OpenLayers
- Create and customize the styling of vector map layers
- Request and visualize GeoJSON vector data

.. 
  TODO: move to w3d3
  - Install and use PostgreSQL via the `psql` CLI
  - Write common SQL commands in PostgreSQL: select, insert, update, delete
  - Understand relational database components: databases, schemas, tables, columns, constraints
  - Understand the benefits of using schemas

.. 
  TODO: move to w8d1
  - Use application.properties settings to configure a database connection in Spring Boot
  - Understand how Spring Data, JPA, and Hibernate relate to each other

.. 
  TODO: move to appropriate security section
  - Awareness of Injection attacks and how to prevent them

.. _week-code-quality-day5-objectives:

Day 5
-----

Conceptual
^^^^^^^^^^

- What is modular programming?
- How can writing modular code improve testing, readability, and portability?
- How do ES6 modules differ from traditional script files?
- What are namespaces?
- What are global and module scopes?
- What are the differences between ES6 default and named exports?

Practical
^^^^^^^^^

- Write ES6 modules
- Link ES6 modules to HTML documents
- Expose named and default exports
- Import named and default exports

.. 
  TODO: move to w1d3
  - Understand the structure of HTTP requests and responses, including differences based on request type (GET, PUT, POST, HEAD, DELETE)
  - Understand common HTTP status codes
  - Understand JSON syntax
  - User cURL to make HTTP requests
  - Understand what an API is, and how they are commonly used

.. _week02-objectives:

Week 5
======

Utilize the skills learned in week 1 to build a Spring Boot application that uses OpenLayers to display geospatial data on a map. Deliver an app with the the following features:

- Ingestion of geospatial data via CSV.
- Display Zika infection data on a map using OpenLayers.
- Display information about each indvidual feature.

Week 6
======

.. _week03-day1-objectives:

Day 1
-----

- Describe the main features of a RESTful web service
- Describe the usage of HTTP methods in a RESTful web service
- Describe the URL format for a RESTful web service
- Describe HTTP status code usage in REST
- Explain what a resource is
- Explain how resource formats are related to requests
- Explain how content negotiation works, and which HTTP headers are necessary for this
- Explain idempotence in REST
- Explain statelessness in REST
- Use and design RESTful URLs, including nested resources and query/filtering parameters
- Define the "sensitive data exposure" vulnerability
- Understand and describe the importance and purpose of salting and hashing passwords

.. _week03-day2-objectives:

Day 2
-----

- Identify the difference between Swagger toolset and the Open API Specification
- Compose Swagger YAML files to define the endpoints, responses, and schema of an API
- Use `$ref` to reference reuseable definitions
- Integrate SwaggerUI into a project
- Explain the difference between authentication and authorization
- At a high level, explain how authentication and authorization work for APIs
- Explain HATEOAS from the perspective of the data returned by a REST service
- Explain the four levels of the REST maturity model

.. _week03-day3-objectives:

Day 3
-----


.. _week03-day4-objectives:

Day 4
-----


.. _week03-day5-objectives:

Day 5
-----

- Understand the origins of JavaScript and the ECMAScript specification
- Understand both client and server JS runtime environments
- Understand what a transpiler is, and how it enables use of different versions of JS in different environments
- Understand the benefits of linting code
- Use ESLint to ensure JS code adheres to a set of standards
- Understand and use ES2015 additions: `let`, `const`, template strings, arrow functions, default parameter values
- Understand and use Webpack to build static client-side applications

Week 7
======

- Use the REST, Elasticsearch, and JavaScript skills obtained in week 3 within a student-built application.

.. _week05-day1-objectives:

Week 8
======

.. _week-data-backing-transfer-day1-objectives:

Day 1
-----

Conceptual
^^^^^^^^^^

- What is an ORM?
- What is Hibernate?
- How does an ORM protect you from SQL injection?
- What is the JPA?
- What is Spring Data?
- How do Hibernate, JPA, and Spring Data differ?
- How do Hibernate, JPA, and Spring Data overlap?


Practical
^^^^^^^^^

- Add Hibernate, Spring Data, and JPA dependencies to a Spring project
- Configure Hibernate to communicate with a PSQL data store
- Map stored records to Java objects via ``JPARepository`` interfaces
- Utilize CRUD functionality from mapped objects via JPA provided methods
- Bind customized JPA methods using JPQL

.. _week-data-backing-transfer-day2-objectives:

Day 2
-----

Conceptual
^^^^^^^^^^

- What is REST?
- What protocol does REST utilize?
- What is a resource?
- How are resources referenced in REST?
- What are the four HTTP methods commonly used in RESTful APIs?
- What is a data format?
- What are the data formats used most commonly with REST?
- How are HTTP status codes used in REST?

Practical
^^^^^^^^^

- Utilize ``@RestController`` to define a controller as a RESTful endpoint
- Define Spring Controllers to handle various HTTP requests
- Serve HTTP responses that contain a payload of the requested resource
- Override standard HTTP Response status code with ``org.springframework.http.HttpStatus;``
- Serialize POJO to JSON

.. _week-data-backing-transfer-day3-objectives:

Day 3
-----

Conceptual
^^^^^^^^^^

- Identify the difference between Swagger toolset and the Open API Specification
- Explain the difference between authentication and authorization
- At a high level, explain how authentication and authorization work for APIs
- Explain HATEOAS from the perspective of the data returned by a REST service
- Explain the four levels of the REST maturity model

Practical
^^^^^^^^^

- Integrate SwaggerUI into a project
- Compose Swagger YAML files to define the endpoints, responses, and schema of an API
- Use `$ref` to reference reuseable definitions
- Generate Swagger docs for a RESTful service in Spring

.. _week-data-backing-transfer-day4-objectives:

Day 4
-----

Conceptual
^^^^^^^^^^

- Describe the use cases for Elasticsearch (ES)
- Understand how NoSQL databases structure data, in contrast to relational databases
- Describe the representation of data in ES as indexes of documents with fields
- Describe the high-level architecture of ES as being based on a cluster with nodes and shards
- Describe how ES is fault-tolerant
- Know when ES should be used beyond the primary data store for an application
- Understand query and filter context, and how each affects a result set
- Describe how analyzers are used for full text queries
- Describe how boost and highlighting can customize result sets
- Describe and use fuzzy queries, geo queries, and aggregations

Practical
^^^^^^^^^

- Use curl to CRUD indices, and documents into a ES cluster
- Use curl to query the search API of an index
- Write filter queries
- Use pagination of result sets

.. _week-data-backing-transfer-day5-objectives:

Day 5
-----

Conceptual
^^^^^^^^^^

- Understand how parent/child relationships are represented, and how this contrasts with such relationships in relational databases
- Describe and configure document mappings, and know the causes of and preventions for mapping explosion
- Describe the purpose and procedure for reindexing

Practical
^^^^^^^^^

- Integrate Elasticsearch into a Spring Boot application

Day 2
-----

- Understand the role of the VPC in providing security for multiple instances
- Understand why AWS provides "High Availability" ELB and RDS instances
- Create ELB instances that distribute traffic across multiple EC2 servers
- Configure an EC2 instances to connect to an RDS database
- Use Telnet to troubleshoot TCP connections

.. _week05-day3-objectives:

Day 3
-----

- Understand why the 12 Factor App principles are important in building a Cloud Native app
- Explain why an ephemeral file system is required to scale apps on the cloud
- Understand how to handle log files on the cloud
- Understand the importance of parity between development, staging, and production environments
- Create an autoscaling app on AWS
- Describe why ELB and RDS databases are "high availability"

.. _week05-day4-objectives:

Day 4
-----

- Understand the purpose of Gradle, and the types of tasks it can carry out
- Describe the historical relationship between Gradle, Maven, Ivy, and Ant
- Understand the content of Gradle files as written in Groovy and the Gradle DSL
- Understand Gradle Java project structure
- Describe the three task lifecycle phases
- Recognize tasks as objects with associated behaviors
- Create basic tasks, including tasks with dependencies
- Understand that tasks can be built from provided task classes such as `DefaultTask`, `Copy`, `Jar`, and so on
- Describe the types of behavior that plugins can provide to a project
- Install and use plugins
- Understand how to configure project dependencies with proper scope
- Describe how Gradle resolves task and project dependencies using a directed acyclic graph representation
- Understand the concepts: Continuous Integration and Continuous Delivery
- Install Jenkins
- Create and configure Projects in Jenkins
- Make Projects that trigger other Projects
- Reuse the same workspace for multiple Projects
- Use Git polling to trigger a Jenkins Project to run
- Configure Jenkins to run and show results of tests
- Create a Jenkins Project to deliver the build artifact (.jar file)
- Awareness of Known Vulnerabilities security issue and how to prevent it

.. _week05-day5-objectives:

Day 5
-----

- Understand the concept of Continuous Inspection
- Install Sonarqube
- Configure `build.gradle` to use Sonarqube
- Configure project name for Sonarqube Gradle task
- How to create a project in Sonarqube
- How to read results in Sonarqube UI

.. _week06-objectives:

Week 9
======

- Use the AWS skills learned in the previous week to deploy a cloud-hosted, scalable application to AWS

.. _week07-objectives:

Week 10
=======

<aside class="aside-note" markdown="1">
GeoServer training is delivered by Boundless.
</aside>

SU 101 Spatial Basics
---------------------

- Gain a basic understanding of spatial concepts, mapping, open source, open data, data formats, geospatial concepts, and cartography.

GS101 Data Publishing
---------------------

- Publish simple datasets in GeoServer
- Accessing published data via WMS and WFS.
- Understand basic spatial file formats
- Read and configure files in the GeoServer web interface.

SU102 Spatial Web Services
--------------------------

- Gain a basic understanding of web service concepts
- Demonstrate working knowledge of Web Map Service, Web Feature Service and OGC standards.

GS102 Administration
--------------------

- Demonstrate GeoServer management, specifically the web administration interface.
- Be able to configure individual web services, manage the security system.
- Apply basic troubleshooting techniques.

GS103 Data Management
---------------------

- Apply tools tools to manipulate data to resolve issues of performance or data security.
- Recognize more advanced store types which GeoServer supports and how and why a GeoServer administrator would select these to serve their spatial data.

GW101 GeoWebCache
-----------------

- Discuss and explain concepts behind GeoWebCache as a specialized type of web cache and understanding how it can be configured to function as a component of a GeoServer instance in production.
- Demonstrate basic configuration.

PG101 Introduction to Spatial Databases
---------------------------------------

- Gain a basic understanding of spatial databases, competing technologies, application and use.
- Explain value of PostGIS with capabilities, history and success stories.
- Demonstrate basis skills such as creating a PostGIS database, connecting to a database from QGIS and GeoServer.

PG102 PostGIS Explained
-----------------------

- Demonstrate knowledge of geometry use in a PostGIS.
- Apply skills to import and export data.
- Describe, explain and apply basic SQL knowledge.

PG103 PostGIS Explored
----------------------

- Demonstrate SQL knowledge in applied queries
- Apply spatial joins, spatial indexes.
- Demonstrate Knowledge of projects and apply knowledge to effectively work with data.
- Represent 3D data.
- Apply linear referencing.
- Load raster data into a database.
- Load a road network into PgRouting.
- Gain a basic understanding of point cloud data.

PG104 PostGIS Analysis
----------------------

- Demonstrate proficient knowledge of SQL for spatial analysis.
- Demonstrate proficient knowledge of spatial joins.
- Explain DIM-9 Spatial relationship optimization.
- Apply nearest neighbor analysis.
- Apply raster analysis.
- Apply topology relationships through SQL.

.. _week08-objectives:

Week 11
=======

- Use the skills learned in the previous week to integrate GeoServer with a Spring Boot + OpenLayers application, both locally and on AWS

Week 12
=======

.. _week09-day-1-2-objectives:

Days 1-2
--------

<aside class="aside-note" markdown="1">
Pivotal Cloud Foundry training is delivered by Boundless.
</aside>

- PCF architecture
- How to interact with PCF: Command Line Interface (CLI), Apps Manager UI
- Orgs, spaces, user roles
- Deploy a Simple Application
- Scaling an app (Ver / Hor)
- Buildpacks
- Application Manifests
- Domains and Routes
- Logging and Metrics
- Application Monitoring
- Blue/Green App Deployment
- Services Marketplace
- Create & Bind a Service
- Platform Security
- NGA’s PCF envs

.. _week09-day3-objectives:

Day 3
-----

- Understand how Docker differs from traditional VMs.
- Describe the underlying Docker technologies such as Linux Containers and UnionFS.
- Spin up containers from existing images locally mapped ports.
- Spin up containers with both volumes and write through mounts.
- Create a Dockerfile that is capable of running a SpringBoot server.
- Understand Docker Network and how Docker containers are interconnected.
- Ability to create, inspect, and delete both images and containers.
- Create a Docker Compose config to spin up a web app, database, and Elasticsearch instance.

.. _week09-day4-objectives:

Day 4
-----

- Understand the difference between authentication and authorization
- Understand OAuth roles: resource owner, client, resource server, authorization server
- Know how to register an application
- Understand the general OAuth2 flow
- Understand the roles of cliend ID and client secret
- Understand OAuth authorization parameters: endpoint, client ID, redirect URI, response type, scope
- Understand the role of an access token in the authorization flow
- Understand the four OAuth grant types: auth code, implicit, resource owner password credentials, client credentials
- Understand the refresh token flow

.. _week09-day5-objectives:

Day 5
-----

- Understand the role certificates play in validating the identity of a server.
- Understand the role that a certificate authority plays in determining trust.
- Configure the browser to add new trusted certificates.
- Configure the browser to add client-side access certificates.

Week 13
=======