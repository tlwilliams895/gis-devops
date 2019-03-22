:orphan:

.. _elasticsearch-walkthrough:

==========================
Walkthrough: Elasticsearch
==========================

Elasticsearch is a non-relational database. It stores information as documents, a collection of key-value pairs that describe the object. It is very similar to JSON.

Unlike a relational database, we will not use SQL to communicate with our data, instead we will be using HTTP Requests, and JSON to communicate with our data. It is a RESTful API and therefore we will predominately be using GET, POST, PUT, and DELETE HTTP methods, and will be receiving JSON as a response.

A non-relational database has certain advantages, and disadvantages in comparison to a relational database.

Advantages:
    - Fast search
    - Full text search
    - Real time search
    - Fuzzy search
    - Distributed workers
    
Disadvantages:
    - Data loss & data corruption
    - Reindex for every document creation, or update
    - Memory intensive

Throughout this class we will be leveraging Elasticsearch's fast, full, and fuzzy searches, but will never use it as a primary datastore. We will be using it as a secondary datastore.

Getting Ready
=============

To use Elasticsearch we need to first install it.

We will be running elasticsearch as a docker container. You can check if you have docker installed with: ``$ docker -v``, if it's installed it will print out the version installed. Check out the `docker installation <../../installations/docker/>`_ if you need to install docker.

After docker is installed you can check your containers with: ``$ docker ps -a``, if you don't have an elasticsearch container, you can get one by following the `elasticsearch installation instructions <../../installations/docker-elasticsearch/>`_.

Elasticsearch Terms
===================

Cluster

Node

Index

Shard

Replica

Document

Elasticsearch Basics
====================

Now that we have Elasticsearch installed on our machines we can learn the basics. We will focus on CRUD functionality.

We will be passing JSON back and forth with Elasticsearch, and using HTTP as the means of communication.

To do this on Unix based systems we will use the cURL terminal tool.

From the terminal a cURL command looks like: ``$ curl -X<HTTP_VERB> '<URL>' -H 'Content-type:application/json' -d '<BODY>'``

Let's break that command down:
    - -X<HTTP_VERB>: The HTTP verb we want to use (GET, POST, PUT, DELETE)
    - <URL>: The URL of the elasticsearch cluster and the path of the index we are requesting
    - -H: HTTP Header in this case we are setting the Content Type to application/json this allows us to include JSON with our request
    - -d: The Body of the request in this case it's where we would include our JSON

Let's make a request to view data about our elasticsearch cluster: ``$ curl -XGET 'http://127.0.0.1:9200/'``

.. image:: /_static/images/elasticsearch/cluster-data.png

Another useful request is to the _cat endpoint. It gives us more information about how to query even more resources.

``$ curl -XGET 'http://127.0.0.1:9200/_cat/'``

.. image:: /_static/images/elasticsearch/cat.png

Let's check the nodes associated with this cluster: ``$ curl -XGET 'http://127.0.0.1:9200/_cat/nodes'``

.. image:: /_static/images/elasticsearch/cat-nodes.png

We have one node. The location of the node on my machine is 172.17.0.2, that happens to be the internal IP address of the docker container where my elasticsearch cluster lives. Your IP Address will probably be different.

Now let's check the indices associated with our cluster: ``$ curl -XGET 'http://127.0.0.1:9200/_cat/indices'``.

.. image:: /_static/images/elasticsearch/cat-indices-empty.png

We don't have any! We will have to create one.

Create
------

Before we create documents, we will have to create an index for our documents. Let's create a new index called teams.

.. sourcecode:: console
   :caption: PUT /teams

   curl -XPUT 127.0.0.1:9200/teams -H 'Content-Type: application/json' -d '
   { 
      "settings": {
        "index": {
          "number_of_shards": 2,
          "number_of_replicas": 1
        }
      }
   }'

When you add a document to an index it's called indexing a document. Indexing is slightly different than creating a record in a relational database. Indexing creates the document, and makes it fully searchable, which is more memory intensive, and slower than simply creating a record in a database. This allows the document in Elasticsearch to be searched fully, and very quickly.

Now let's index some MLB teams as documents on the ``/teams`` index.

First the St. Louis Cardinals.

.. sourcecode:: console
   :caption: POST /teams/_doc/1

   curl -XPOST 127.0.0.1:9200/teams/_doc/1 -H 'Content-Type: application/json' -d '
   {
      "city": "St. Louis",
      "name": "Cardinals",
      "league": "National"
   }'

The Washington Nationals.

.. sourcecode:: console
   :caption: POST /teams/_doc/2

   curl -XPOST 127.0.0.1:9200/teams/_doc/2 -H 'Content-Type: application/json' -d '
   {
      "city": "Washington",
      "name": "Nationals",
      "league": "National"
   }'

Finally, the Chicago Cubs.

.. sourcecode:: console
   :caption: POST /teams/_doc/3

   curl -XPOST 127.0.0.1:9200/teams/_doc/3 -H 'Content-Type: application/json' -d '
   {
       "city": "Chicago",
       "name": "Cubs",
       "league": "National"
   }'

Read
----

Let's rerun that command from earlier to check on the indices associated with this cluster.

.. sourcecode:: console
   :caption: GET /_cat/indices

   curl -XGET 127.0.0.1:9200/_cat/indices

Let's read these documents from Elasticsearch.

.. sourcecode:: console
   :caption: GET /teams/_doc/1

   curl -XGET 127.0.0.1:9200/teams/_doc/1?pretty=true

.. sourcecode:: console
   :caption: GET /teams/_doc/2

   curl -XGET 127.0.0.1:9200/teams/_doc/2?pretty=true

.. sourcecode:: console
   :caption: GET /teams/_doc/3

   curl -XGET 127.0.0.1:9200/teams/_doc/3?pretty=true

.. note::
   
   In the case of these cURL requests we are passing the pretty option, and setting it as true. This makes our queries a little easier to read. This option can be passed to any elasticsearch query, and the results will come back nicer. `Learn more about Elasticsearch 6.5 options <https://www.elastic.co/guide/en/elasticsearch/reference/6.5/common-options.html>`_ 

Update
------

Let's update one of these documents. The ``"city"`` key for our 2nd document currently is valued as ``"Washington"``. This can cause confusion for people that don't know the Washington Nationals are in Washington D.C. Let's update this record with a new ``"city"`` name.

.. sourcecode:: console
   :caption: POST /teams/_doc/2/_update

   curl -XPOST 127.0.0.1:9200/teams/_doc/2/_update -H 'Content-Type: application/json' -d '
   {
       "doc": {
           "city": "Washington D.C."
       }
   }'

One of the differences between a relational database (PSQL) and a non-relational database (Elasticsearch) is how records/documents are updated. In a relational database the field is simply changed. In a non-relational database the entire document is deleted, and reindexed. This makes every update far more resource intensive than an update in a relational database.

Let's see this change.

.. sourcecode:: console
   :caption: GET /teams/_doc/2

   curl -XGET 127.0.0.1:9200/teams/_doc/2?pretty=true

.. image:: /_static/images/elasticsearch/update-city.png

Delete
------

Let's delete a document.

.. sourcecode:: console
   :caption: DELETE /teams/_doc/3

   curl -XDELETE 127.0.0.1:9200/teams/_doc/3

Let's query that document again to make sure it's gone.

.. sourcecode:: console
   :caption: GET /teams/_doc/3

   curl -XGET 127.0.0.1:9200/teams/_doc/3?pretty=true

.. image:: /_static/images/elasticsearch/delete.png

I think we all feel better now that the Cubs have been deleted!

Elasticsearch Search API
========================

Setup
-----

Before we can start utilizing the Search API, we need more data:
    #. Copy `baseball.sh <https://gitlab.com/LaunchCodeTraining/elasticsearch-practice/blob/master/baseball-teams.sh>`_ to your local machine as baseball.sh.
    #. Make the script file excutable from the terminal: ``$ chmod 500 baseball.sh``
    #. Run the script: ``$ ./baseball.sh``

To make sure our Elasticsearch cluster was seeded from the shell script correctly from the terminal: ``$ curl -XGET 127.0.0.1:9200/teams/_count``.

We should have a total of 30 documents stored within the ``/teams`` index.

So far Elasticsearch functions very similarly to PSQL. How do we leverage some the advantages of Elasticsearch?

We do this through the Elasticsearch Search API!

We will be writing our Elasticsearch queries by making GET requests: ``curl -XGET 127.0.0.1:9200/teams/_search``

We can access the _search API by using query parameters, or by including JSON that describes the query to be made.

Match All Documents in Index
----------------------------

.. sourcecode:: console
   :caption: GET /teams/_search

   curl -XGET 127.0.0.1:9200/teams/_search?pretty=true

.. sourcecode:: console
   :caption: GET /teams/_search

   curl -XGET 127.0.0.1:9200/teams/_search?pretty=true -H 'Content-Type: application/json' -d '
   {
       "query": { "match_all": {} }
   }'

These queries only return 10 results. Looking at the `Elasticsearch documentation <https://www.elastic.co/guide/en/elasticsearch/reference/6.5/search-request-from-size.html>`_ to learn about Pagination.

We can configure how many results are returned with the From, and Size request parameters.

.. sourcecode:: console
   :caption: GET /teams/_search

   curl -XGET 127.0.0.1:9200/teams/_search?pretty=true -H 'Content-Type: application/json' -d '
   {
       "from": 0,
       "size": 30,
       "query": { "match_all": {} }
   }'

We can also control the results of the document source. For example if we only wanted the city, and name from each document:

.. sourcecode:: console
   :caption: GET /teams/_search

   curl -XGET 127.0.0.1:9200/teams/_search?pretty=true -H 'Content-Type: application/json' -d '
   {
       "from": 0,
       "size": 30,
       "_source": ["city", "name"],
       "query": { "match_all": {} }
   }'

Match Documents by Field
------------------------

Elasticsearch gives us even more control of our seaches with the ``"match"`` query.

.. sourcecode:: console
   :caption: GET /teams/_search

   curl -XGET 127.0.0.1:9200/teams/_search?pretty=true -H 'Content-Type: application/json' -d '
   {
       "query": { "match": { "city": "St. Louis" } }
   }'

Let's match all the teams in the National league.

.. sourcecode:: console
   :caption: GET /teams/_search

   curl -XGET 127.0.0.1:9200/teams/_search?pretty=true -H 'Content-Type: application/json' -d '
   {
       "from": 0,
       "size": 15,
       "query": { "match": { "league": "National" } }
   }'

# TODO: Match partial words
# TODO: Match phrase
# TODO: Match or
# TODO: Match and
# TODO: Filter
# TODO: Aggregate
# TODO: We have only touched the surface of what Elasticsearch can do. Check out the documentation to learn more. Tomorrow we will learn how to work with Elasticsearch from our web applications using the Spring Data Elasticsearch Repository.
# TODO: Hit the concepts again -- they need to be filled out

Elasticsearch Fuzzy Search
==========================

Resources
=========

* `Spring Data Elasticsearch <http://www.baeldung.com/spring-data-elasticsearch-tutorial>`_
* `ElasticsearchRepository <https://docs.spring.io/spring-data/elasticsearch/docs/current/api/org/springframework/data/elasticsearch/repository/ElasticsearchRepository.html>`_
* `TransportClient <https://www.elastic.co/guide/en/elasticsearch/client/java-api/6.2/transport-client.html>`_
* `QueryBuilders <https://static.javadoc.io/org.elasticsearch/elasticsearch/2.4.0/org/elasticsearch/index/query/QueryBuilders.html>`_
* `Spring Data Elasticsearch Queries <http://www.baeldung.com/spring-data-elasticsearch-queries>`_
* `The @Value annotation <http://www.baeldung.com/spring-value-annotation>`_
