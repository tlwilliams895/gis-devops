.. 
  SLIDES: cover answers to objectives
  WALKTHROUGH: diagnosing and resolving CORS issues
    sample client served from a container
    sample API codebase
    use branches to separate CORS resolution headers
      origin not allowed
      method not allowed: POST request
      headers not allowed: content-type header (application/json)
    dev tools console to view CORS warnings
    update API (manually or branch switching) to allow origins / headers / methods
  COMMANDS: sample syntax for node/express and java/spring
    node/express: CORS middleware
    java/spring: CrossOrigin annotation
    using env variables

:orphan:

.. _cors_index:

=============================
Cross Origin Resource Sharing
=============================

:ref:`cors_objectives` for this module

Lesson Content
==============

- 

Walkthrough
===========

- :ref:`cors_walkthrough`

Resources
=========

.. 
  TODO: "commands.rst" doc naming, used here for consistency until discussed
  something more general ("notes.rst"?) to account for syntax/implementation and CLI commands
  or split into "commands.rst" and "syntax.rst"?

- :ref:`cors_commands` 
- `OWASP SOP Presentation [video] <https://www.youtube.com/watch?v=zul8TtVS-64>`_
- `Derric Gilling Guide to CORS <https://www.moesif.com/blog/technical/cors/Authoritative-Guide-to-CORS-Cross-Origin-Resource-Sharing-for-REST-APIs/>`_
- `MDN CORS Guide <https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS>`_
- `IETF Same Origin Security <https://tools.ietf.org/pdf/rfc6454.pdf#10>`_
- `W3 CORS specification <https://www.w3.org/TR/cors/>`_
