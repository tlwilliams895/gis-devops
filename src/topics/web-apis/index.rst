.. 
  SLIDES: 
    single (SSR) vs multi (CSR) host
      pros and cons (some notes here https://gitlab.com/gis-devops-6/patrick-full-stack-js#mvc-client-api-architecture)
      importance of a consistent interface (routes + input/output + behaviors)
      internal implementation on either side of the stack can change as long as the interface is constant
    modern web dev and data driven applications as the catalyst for APIs
      web APIs as the gateway/interface to data access 
    server design
      HTTP and request-response cycle
      JSON as the primary data transfer format
      route handlers as functions/methods (req -> res)
        endpoints (API server is agnostic of its origin)
        path + method labeling (tree-like path requests take to resolution)
      ?are these too heavy?
        validation and sanitization
        access control (authentication/authorization)
        importance of stateless servers (HTTP as stateless protocol, scaling)
        external state mechanisms (cookies, JWT)
        backing services (databases, caching)
    organizational specs overview (REST, RESTish, GraphQL)
  WALKTHROUGH: web API in express (2 simple GET and POST endpoints)
    setup/installation with NPM
    start an express app server
    route handler callbacks (req, res)
      accessing request info: req.[headers, body]
      sending responses: res.[send, sendStatus, json]
    configuring middleware (CORS, JSON body parser)
    writing routes: app.[method]("/path", (req, res) => {}) 
    using Postman for manual testing
  STUDIO: build the TODO API in express
    provide endpoint specs
    reference CORS commands doc for implementing the middleware

:orphan:

.. _web-apis_index:

========
Web APIs
========

:ref:`web-apis_objectives` for this module

Lesson Content
==============

- 

Walkthrough
===========

- :ref:`web-apis_walkthrough`

Studio
======

- :ref:`web-apis_studio`

Resources
=========

- `Martin Fowler Multi-Layer Web Applications <https://martinfowler.com/bliki/PresentationDomainDataLayering.html>`_
