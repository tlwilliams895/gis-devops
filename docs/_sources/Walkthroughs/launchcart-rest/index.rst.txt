:orphan:

.. _walkthrough-launchcart-rest:

============================
Walkthrough: LaunchCart REST
============================

In this walkthrough, the instructor will guide you through adding some RESTful endpoints to the LaunchCart application.

Getting Started
===============

From the same ``launchcart`` `project/repository <https://gitlab.com/LaunchCodeTraining/launchcart>`_  that you used previously, check out the ``rest-walkthrough`` branch. Then create a story branch.::

    $ git checkout rest-walkthrough
    $ git checkout -b rest-walkthrough-solution

What's New
==========

This starter code has some functionality beyond what you added in  :ref:`launchcart-part2`. In particular, it has a ``Customer`` class, along with functionality for users to register and log in as customers.

.. hint::

    A good way to see what has been added in a branch is to you use the **comparison** feature of Gitlab.

    Example: View the `launchcart branches <https://gitlab.com/LaunchCodeTraining/launchcart/branches>`_ and notice the **Compare** button next to each branch.


Adding a REST Controller
========================

Let's complete a few setup steps before starting to code:

* Create a new package, ``org.launchcode.launchcart.controllers.rest``
* Create a new class in this package named ``ItemRestController``
* Annotate the class with ``@RestController``

In the ``test`` module, note that there are two new classes. ``AbstractBaseRestIntegrationTest`` contains a couple of utility methods to handle serializing Java objects for the purposes of testing. And ``ItemRestControllerTests`` extends ``AbstractBaseRestIntegrationTest`` and contains the integration tests for the functionality that we'll be adding. We'll review this code in class.

Our Tasks
=========

We will now implement the Item resource in the following ways:

* ``GET /api/items`` (with parameter ``price``)
* ``GET /api/items/{id}``
* ``POST /api/items``
* ``PUT /api/items/{id}``
* ``DELETE /api/items/{id}``

Bonus Mission
=============

Enable XML as a resource format. To do this, add the following Gradle dependency::

    compile('com.fasterxml.jackson.dataformat:jackson-dataformat-xml')

Now annotate the ``Item`` class with ``@XmlRootElement``. Then add ``@XmlElement`` to each field that should be included in the XML serialization as an XML element child of ``<Item>``, and ``@XmlAttribute`` to each field that should be included as an XML attribute of ``<Item>``. Don't forget about inherited fields.
