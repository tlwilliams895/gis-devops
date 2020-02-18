:orphan:

.. _walkthrough-elasticsearch-spring:

====================================
Walkthrough: Elasticsearch in Spring
====================================

We'll walk through the steps to integrate Elasticsearch with Spring, using the Launchcart application.

The goal is to enable fuzzy searching for items via LaunchCart's REST API. This will require:

#. Configuring the application to work with Elasticsearch.
#. Creating a Java representation of the item documents we want to store in Elasticsearch.
#. Creating a REST endpoint that conducts a fuzzy search for item documents.

Update Tools
============

Update Gradle
-------------

We will need to use Gradle version 4.4. We can check the Gradle version by checking out our ``/gradle/wrapper/gradle-wrapper.properties`` file.

.. image:: /_static/images/spring-elasticsearch/gradle-version.png

From this file we can see the gradle version for this project is 4.4. That's what we want!

Update SpringBoot
-----------------

We can check our version of Springboot by looking into our projects ``build.gradle`` file.

.. image:: /_static/images/spring-elasticsearch/spring-boot-version.png

From this file we can see the spring boot version of this project is 2.1.1. That's what we want!


Amend build.gradle
------------------

Going back to our ``build.gradle`` file we need to add a plugin:

.. code-block:: groovy

   apply plugin: 'io.spring.dependency-management

.. image:: /_static/images/spring-elasticsearch/spring-dependency-management.png

If you have a ``bootRun{}`` section towards the bottom of your file delete it. That's a holdover from an older version of gradle.

.. code-block:: groovy

   bootRun {
       // addResources = true
       sourceResources sourceSets.main
   }

.. note::
   
   You may not have done much up to this point, since we have been using these versions so far throughout this class. However, it's a good idea to check the versions of the software you use. You will need to know which versions work together, and you are responsible for knowing about security vulnerabilties in specific versions of the software you use in your projects!

Let's add the dependencies Spring data will need to work with Elasticsearch.

We will be adding the following dependencies to the dependency section of our ``build.gradle`` file.

.. code-block:: groovy

   compile('org.springframework.data:spring-data-elasticsearch:3.1.3.RELEASE')
   compile('net.java.dev.jna:jna')

.. image:: /_static/images/spring-elasticsearch/springdata-elasticsearch-dependencies.png

Amend application.properties
----------------------------

Now that we have the correct versions of Elasticsearch, Springdata, and Gradle we need to configure Springdata so that it knows where, and how to communicate with Elasticsearch.

We have used ``application.properties`` to configure various aspects of our project, and this is also where the variables of our configuration will live for Elasticsearch.

We will be setting the Elasticsearch transport client port, the Elasticsearch cluster URL, the Elasticsearch cluster's index name.

Add the following code snippet to the bottom of your ``application.properties`` file.

.. code-block:: console
   :caption: application.properties

    spring.jpa.properties.hibernate.jdbc.lob.non_contextual_creation=true

Sync Gradle
-----------

Your IntelliJ may have already started pulling in the updated libraries. However, you can force this by click the refresh button in the gradle menu.

bootRun
-------

After all of the libraries have loaded run your project with bootRun.

It may not run, because you may have methods that need to be updated.

Refactor Methods
----------------

You might have multiple instances of ``findOne(id)`` throughout your code. We will need to update these to ``getOne(id)``.

Similarly any instances of ``delete(id)`` will need to be updated to ``deleteById(id)``.

Look through your code to replace these.

bootRun
-------

After replacing all methods that need updating, re-run your project with bootRun. 

You will know everything was done correctly when your project is running again.

Spring Elasticsearch Connection
===============================

application.properties
----------------------

Add the following code snippet to the bottom of your ``application.properties`` file.

.. code-block:: console
   :caption: application.properties

   # Elasticsearch Config
   spring.data.elasticsearch.cluster-nodes=127.0.0.1:9300
   spring.data.elasticsearch.cluster-name=elasticsearch
   es.index-name=launchcart

You will also want to add this to your ``application-test.properties`` file.

.. code-block:: console
   :caption: application-test.properties

   # Elasticsearch Config
   spring.data.elasticsearch.cluster-nodes=127.0.0.1:9300
   spring.data.elasticsearch.cluster-name=elasticsearch
   es.index-name=launchcart

.. hint::
   
   It would be a good idea to use environment variables for your Elasticsearch information. So that your elasticsearch information won't be posted to Gitlab, and to make this project easier to deploy in the future. You can use environment variables by using tokens that look like this: ``${ES_CLUSTER_URL}:${ES_CLUSTER_PORT}``. You would then need to add the environment variable to your runtime configuration.

.. note::

   Based on the versions of PSQL, and Spring data you are using you may get a mysterious error when running your project for the first time. The error message will stop your application from running, and will mention something about Clob, or ClobContext issues. If you run into this issue, you need to add ``spring.jpa.properties.hibernate.jdbc.lob.non_contextual_creation=true`` to your application.properties, and application-test.properties files.

EsConfig.java
-------------

Create a new file at the root of your project called ``EsConfig.java``.

.. image:: /_static/images/spring-elasticsearch/es-configuration-java.png

Now we will want to add some code to this file.

.. code-block:: java
   
   //imports
   import org.springframework.beans.factory.annotation.Value;
   import org.springframework.stereotype.Component;
   
   @Component
   public class EsConfig {

       @Value("${es.index-name}")
       private String indexName;

       public String getIndexName() {
           return indexName;
       }

       public void setIndexName(String indexName) {
           this.indexName = indexName;
       }

   }

The @Value annotation tells Spring to read the es.index-name property from the properties file and store it in the field indexName.

The @Component annotation tells Spring that this class is a bean that it should create and manage. The end result of setting up this class is that we can use Spring’s Expression Language to dynamically insert the value of the indexName field in our code with the syntax #{esConfig.indexName}.

bootRun
-------

With the additions to our ``application.properties`` file, and our ``EsConfig`` file we have connected our Spring application to our Elasticsearch cluster. Re-run bootRun and check out the Tomcat logs.

You will notice we have some new additions near the bottom of the logs.

.. code-block::java

   Adding transport node : 127.0.0.1:9300

Our application is aware of the IP address and the port we configured in our ``application.properties`` file.

Check cluster
-------------

You should try querying your cluster.

``curl 127.0.0.1:9200/_cat/indices``

We don't have any new launchcart indices yet, but we will soon. We still need to have spring create our index.

Create Index from Spring
========================

ItemDocument
------------

We need to create a new model class to represent the documents that we'll be storing in ES, along with a corresponding repository.

Create a new package, ``org.launchcode.launchcart.models.es``, and add the following class:

.. code-block:: java

    /*
    * /src/main/java/org/launchcode/launchcart/models/es/ItemDocument.java
    */

   import org.springframework.data.elasticsearch.annotations.Document;

   import javax.persistence.GeneratedValue;
   import javax.persistence.GenerationType;
   import javax.persistence.Id;

   @Document(indexName = "#{esConfig.indexName}", type = "items")
   public class ItemDocument {

       @Id
       @GeneratedValue(strategy= GenerationType.AUTO)
       private String id;

       private Integer itemUid;
       private String name;
       private double price;
       private boolean newItem;
       private String description;

       public ItemDocument() {}

       public ItemDocument(Item item) {
           this.itemUid = item.getUid();
           this.name = item.getName();
           this.price = item.getPrice();
           this.newItem = item.isNewItem();
           this.description = item.getDescription();
       }

       // Getters and setters omitted

    }



.. note:: The ``@Id`` annotation should come from the ``javax.persistence`` package, so be sure to select the correct import.

Review the fields and constructors for this class to make sure you understand what it represents. Each ``ItemDocument`` object will be a "copy" of an ``Item`` that is suitable for storing in Elasticsearch, and which keeps track of the original item's ID in the ``itemUid`` field.

There are two things to note about the ``ItemDocument`` class that make it different from our other persistent model classes.

1. The ID field for the class is of type ``String`` instead of ``Integer``. We do this because Elasticsearch uses hash strings as IDs instead of integers.
2. The ``@Document`` annotation notifies Spring that this class may be stored in Elasticsearch, using the index and type names provided. Notice the index name, ``#{esConfig.indexName}``. This uses Spring's expression language to dynamically insert the value of the ``indexName`` property of the ``EsConfig`` bean that we created earlier. Recall that this property is set using the value of ``es.index-name`` in the properties file, so it will be different for development and test contexts.

ItemDocumentRepository
----------------------

Also add a new repository, which extends ``ElasticsearchRepository``:

.. code-block:: java

    /*
     * src/main/java/org/launchcode/launchcart/data/ItemDocumentRepository.java
     */
   import org.elasticsearch.index.query.QueryBuilder;
   import org.launchcode.launchcart.models.ItemDocument;
   import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

    public interface ItemDocumentRepository 
        extends ElasticsearchRepository<ItemDocument, String> {

        Iterable<ItemDocument> search(QueryBuilder queryBuilder);

    }

bootRun
-------

Let's run bootRun again.

Check cluster
-------------

After your application is running again, try curling for indices again: ``curl 127.0.0.1:9200/_cat/indices``.

We now have a new index named launchcart. Spring created our index for us.

Post to Elasticsearch
=====================

ItemRestController
------------------

In order to get Spring to add new documents to our index, we will have to use our new ItemDocumentRepository class. For now let's add this functionality inside of our ItemRestController.

The changes we are about to make to our post mapping handler will utilize ItemDocumentRepository so let's @Autowire it into our ItemRestController file first.

Towards the top of your class where you have autowired your ItemRepository add:

.. code-block:: java

   @Autowired
   private ItemDocumentRepository itemDocumentRepository;


Update the post mapping in your ItemRestController like this:

.. code-block:: java

   @PostMapping
   @ResponseStatus(HttpStatus.CREATED)
   public Item postItem(@RequestBody Item item) {
       Item postItem = itemRepository.save(item);
       ItemDocument itemDocument = new ItemDocument(postItem);
       itemDocumentRepository.save(itemDocument);
       return postItem;
   }

We have amended our PostMapping so that when it saves a new Item to our ItemRepository it also saves an ItemDocument to our ItemDocumentRepository.

ItemRestControllerTests
-----------------------

To test this new functionality out let's write a new test in our ItemRestControllerTests file to make sure our post saves a new ItemDocument to Elasticsearch.

You will have to Autowire an ItemDocumentRepository into your ItemRestControllerTests file first, and then we can add a new test.

Towards the top of your Test class add:

.. code-block:: java

   // imports to look out for!!!

   import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
   import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
   
   ...

   @Autowired
   private ItemDocumentRepository itemDocumentRepository;

Add the following to your ItemRestControllerTests file: 

.. code-block:: java

   @Test
   public void testPostCreatesItemDocument() throws Exception {
       itemDocumentRepository.deleteAll();
       Item postItem = new Item("Post test item", 22.00);
       String json = json(postItem);
       mockMvc.perform(post("/api/items")
               .content(json)
               .contentType(contentType))
               .andExpect(status().is(201));
       Iterator<ItemDocument> itemDocuments = itemDocumentRepository.findAll().iterator();
       Assert.assertTrue(itemDocuments.hasNext());
   }

This test clears out our elasticsearch index first, and then makes a post request to our ItemRestController.

We then test that our elasticsearch cluster has at least one document in it.

Fuzzy Search
============

ItemDocumentController
----------------------

Create ``ItemDocumentController`` and implement the ``search`` method/endpoint.

.. code-block:: java

   /*
   * src/main/java/org/launchcode/launchcart/controllers/es/ItemDocumentController.java
   */

   import org.elasticsearch.index.query.FuzzyQueryBuilder;
   import org.elasticsearch.index.query.QueryBuilders;
   import org.launchcode.launchcart.data.ItemDocumentRepository;
   import org.launchcode.launchcart.models.ItemDocument;
   import org.springframework.beans.factory.annotation.Autowired;
   import org.springframework.web.bind.annotation.GetMapping;
   import org.springframework.web.bind.annotation.RequestMapping;
   import org.springframework.web.bind.annotation.RequestParam;
   import org.springframework.web.bind.annotation.RestController;

   import java.util.ArrayList;
   import java.util.Iterator;
   import java.util.List;

   @RestController
   @RequestMapping(value = "/api/items")
   public class ItemDocumentController {

       @Autowired
       private ItemDocumentRepository itemDocumentRepository;

       @GetMapping(value = "search")
       public List<ItemDocument> search(@RequestParam String q) {
           FuzzyQueryBuilder fuzzyQueryBuilder = QueryBuilders.fuzzyQuery("name", q);
           List<ItemDocument> results = new ArrayList<>();
           Iterator<ItemDocument> iterator = itemDocumentRepository.search(fuzzyQueryBuilder).iterator();

           while(iterator.hasNext()) {
               results.add(iterator.next());
           }

           return results;
       }

   }

Spring is unable to serialize (i.e. turn into XML or JSON) an ``Iterable`` object, so we must copy each of the results into a new ``List``. If we expect large results sets, we should use a paginated approach that only returns segments of the result set.

ItemDocumentControllerTests
---------------------------

Again to test this functionality out, let's write a new test.

Create a new test file named ``ItemDocumentControllerTests`` and add the following code:

.. code-block:: java

    /*
     * In src/test/java/org/launchcode/launchcart/ItemDocumentControllerTests.java
     /*

    // imports
    import org.junit.Test;
    import org.junit.runner.RunWith;
    import org.launchcode.launchcart.models.Item;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.test.context.junit4.SpringRunner;
    import org.springframework.test.web.servlet.MockMvc;

    import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
    import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
    import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
    import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

    @RunWith(SpringRunner.class)
    @IntegrationTestConfig
    public class ItemDocumentControllerTests extends AbstractBaseRestIntegrationTest {

        @Autowired
        private MockMvc mockMvc;

        @Autowired
        private ItemDocumentRepository itemDocumentRepository;

        @Test
        public void testFuzzySearch() throws Exception {
            itemDocumentRepository.deleteAll();
            Item item = new Item("Test Item Again", 42);
            String json = json(item);
            mockMvc.perform(post("/api/items/")
                    .content(json)
                    .contentType(contentType));
            mockMvc.perform(get("/api/items/search?q={term}", "agan"))
                    .andDo(print())
                    .andExpect(status().isOk())
                    .andExpect(content().contentType(contentType))
                    .andExpect(jsonPath("$.length()").value(1))
                    .andExpect(jsonPath("$[0].name").value(item.getName()));
        }

    }


Seed Elasticsearch from Spring
==============================

In this section we will be learning how to seed our elasticsearch cluster from the data that currently exists in our database.

You will need to create two new files ``EsUtil.java`` and ``EsController.java``. We recommend creating a new package off the root of your project named utils for your ``EsUtil.java`` file. Your ``EsController.java`` file can be created in your controllers directory.

EsUtil
-------

After creating ``Esutil.java`` add the following code:

.. code-block:: java

    /*
     * src/main/java/org/launchcode/launchcart/util/EsUtil.java
     */

    import org.launchcode.launchcart.data.ItemDocumentRepository;
    import org.launchcode.launchcart.data.ItemRepository;
    import org.launchcode.launchcart.models.Item;
    import org.launchcode.launchcart.models.ItemDocument;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.stereotype.Component;

    import java.util.ArrayList;
    import java.util.List;

    @Component
    public class EsUtil {

        @Autowired
        private ItemRepository itemRepository;

        @Autowired
        private ItemDocumentRepository itemDocumentRepository;

        public void refresh() {
            itemDocumentRepository.deleteAll();
            List<ItemDocument> itemDocuments = new ArrayList<>();
            for(Item item : itemRepository.findAll()) {
                itemDocuments.add(new ItemDocument(item));
            }
            itemDocumentRepository.saveAll(itemDocuments);
        }
    }

EsController
------------

After creating your EsController file add the following code:

.. code-block:: java

    /*
     * src/main/java/org/launchcode/launchcart/controllers/es/EsController.java
     */

    import org.launchcode.launchcart.util.EsUtil;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.http.HttpStatus;
    import org.springframework.http.ResponseEntity;
    import org.springframework.web.bind.annotation.PostMapping;
    import org.springframework.web.bind.annotation.RequestMapping;
    import org.springframework.web.bind.annotation.RestController;

    @RestController
    @RequestMapping(value = "/api/es")
    public class EsController {

        @Autowired
        private EsUtil esUtil;

        @PostMapping(value = "/refresh")
        public ResponseEntity refresh() {
            esUtil.refresh();
            return new ResponseEntity("Refreshed Elasticsearch index\n", HttpStatus.OK);

        }

    }

bootRun and Seed
----------------

After creating these files go ahead and run your project with bootRun.

When your project is running create a few new items from the web portal.

After creating the items so they exist in the database fire off a curl request: ``curl -XPOST 127.0.0.1:8080/api/es/refresh``.

This will hit our controller class, which calls the EsUtil class which will delete our current index, and rebuild it from the items in our database.

This will come in handy with your Zika projects next week.


Your Tasks
==========

On your own, study the code above and make sure you understand each of the components, referring to the linked resources below as necessary. When you come across something that isn't clear, talk through it with another student or with an instrutor.

Bonus Missions
==============

We looked at how to push a new item to Elasticsearch when creating it via the REST API. There are still several tasks that can be immediately carried out to fully integrate ES with the application. Try one more more of the following:

* We are currently creating and saving a new ``ItemDocument`` whenever a new ``Item`` is created, however, we are not updating or deleting an ``ItemDocument`` when the corresponding ``Item`` is updated or deleted. Add the code to do this.
* Add a search view that displays results of a fuzzy search. This may be done either by an AJAX request to ``ItemDocumentRepository.search``, or by creating a new controller method that passes fuzzy search results into a template.

Resources
=========

* `Spring Data Elasticsearch <http://www.baeldung.com/spring-data-elasticsearch-tutorial>`_
* `ElasticsearchRepository <https://docs.spring.io/spring-data/elasticsearch/docs/current/api/org/springframework/data/elasticsearch/repository/ElasticsearchRepository.html>`_
* `TransportClient <https://www.elastic.co/guide/en/elasticsearch/client/java-api/6.2/transport-client.html>`_
* `QueryBuilders <https://static.javadoc.io/org.elasticsearch/elasticsearch/2.4.0/org/elasticsearch/index/query/QueryBuilders.html>`_
* `Spring Data Elasticsearch Queries <http://www.baeldung.com/spring-data-elasticsearch-queries>`_
* `The @Value annotation <http://www.baeldung.com/spring-value-annotation>`_