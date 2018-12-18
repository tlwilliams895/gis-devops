:orphan:

.. _walkthrough-swagger:

=====================
Walkthrough SwaggerUI
=====================

In this walkthrough, the instructor will guide through adding API documentation using `SwaggerUI <https://swagger.io/swagger-ui/>`_.

Getting Started
===============

Open Your Launchcart Project in Intellij
----------------------------------------

The same Launchcart project and repo you used for the REST studio.
Create and checkout a new branch named ``add-swagger`` with this command ``git checkout -b add-swagger``

Setup Intellij
--------------

Since we are going to be writing the ``swagger.yaml`` in IntelliJ, let's get a plugin to help out.

Click the magnifying glass in the upper right hand corner and type "Plugin". Select "Plugins" from the menu. Then select "Browse repositories...".

1. Click the magnifying glass in the upper right hand corder and type "Plugin".
2. Select "Plugins" from the menu.
3. Then select "Browse repositories...".
4. Search for "Swagger" in the search bar and install the "Swagger" plugin (there may be mutiple results; install the one with the most stars .
5. Restart Intellij after the plugin has installed.

Embed SwaggerUI into the Launchcart Project
-------------------------------------------

Clone the `SwaggerUI repository <https://github.com/swagger-api/swagger-ui/tree/2.x>`_ from Github. 

.. note:: We are downloading the SwaggerUI for 2.x branch.

Move Swagger to Your Project
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. In IntelliJ, create the directory ``launchcart/src/main/resources/static/swagger``
2. Navigate into the repo that you just cloned.
3. Copy the *contents* of ``swagger-ui/dist`` directory into ``launchcart/src/main/resources/static/swagger/`` directory.

.. note:: The ``dist/`` directory contains all of the HTML, CSS, and JavaScript required to generate a Swagger document

Setup Swagger ``.yaml`` File
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In folder ``launchcart/src/main/resources/static/swagger``:

1. Create a swagger.yaml file  ``touch swagger.yaml``.
2. Edit ``swagger/index.html`` to point at the local ``swagger.yaml``, like the example below:

.. code:: html

  <script>
  window.onload = function() {

    // Build a system
    const ui = SwaggerUIBundle({
      url: "http://localhost:8080/swagger/swagger.yaml",
      dom_id: '#swagger-ui',
      deepLinking: true,
      presets: [
        SwaggerUIBundle.presets.apis,
        SwaggerUIStandalonePreset
      ],
      plugins: [
        SwaggerUIBundle.plugins.DownloadUrl
      ],
      layout: "StandaloneLayout"
    })

    window.ui = ui
  }
  </script>


Load Swagger in the Browser
===========================

Start up SpringBoot and navigate to the url ``http://localhost:8080/swagger/index.html``. You should see a SwaggerUI page displayed.

Writing the Swagger YAML
========================

Next we need to begin writing the Swagger YAML file. Copy the following code into your ``swagger.yaml`` file located in the ``launchcart/src/main/resources/static/swagger/`` directory.

.. code:: yaml

  swagger: '2.0'
  info:
    description: |
    This is an example RESTful API
    version: 1.0.0
    title: LaunchCart API
    termsOfService: http://swagger.io/terms/
    contact:
      email: your.email@gmail.com
    license:
      name: Apache 2.0
      url: http://www.apache.org/licenses/LICENSE-2.0.html
  tags:
  paths:
  definitions:


Let's start with the ``/api/carts`` path.

Add an entry to the ``tags`` section, to add a header for all of the endpoints for the ``/api/carts`` path.

.. warning:: YAML is white-spaced based. Be *very* careful with tabs and spaces. You may also find the `YAML Reference <http://docs.ansible.com/ansible/latest/reference_appendices/YAMLSyntax.html>`_ helpful.

.. code:: yaml

  - name: cart
    description: Cart provides access to all of the items you are about to buy.

Also, let's add the ``GET`` endpoint for ``/api/carts`` in the ``paths`` section.

.. code:: yaml

  paths:
    /carts:
      get:
        tags:
        - cart
        summary: Returns all carts that exist..
        operationId: getAllCarts
        produces:
        - application/json
        responses:
          200:
            description: successful operation


Next, fill in the schema for the ``/api/carts`` endpoint. In order to do that, first check to see what the service is currently returning.

Review Cart JSON
----------------

* Register for an account on your LaunchCart app
* Add item(s) to your cart
* Visit ``http://localhost:8080/api/carts``
* You should receive something that looks like the below...

```nohighlight
[{"uid":1,"items":[{"uid":1,"name":"Chacos","price":1000.0,"newItem":true,"description":"I think they're sandals"}]}]
```

To represent the cart and it's contents, update the `/carts` definition to this:

.. code:: yaml

  paths:
      /carts:
          get:
              tags:
              - cart
              summary: Returns all carts that exist..
              operationId: getAllCarts
              produces:
              - application/json
              responses:
                  200:
                    description: successful operation
                    schema:
                      type: object
                      required:
                      - uid
                      - items
                      properties:
                        uid:
                          type: integer
                          format: int32
                          example: 34
                        items:
                          type: array
                          items:
                            $ref: "#/definitions/Item"
                          security:
                            - api_key: []


.. note::

   Make sure that your whitespace is correct. There can only be a one tab indent for every map.

   Incorrect indentation may cause your API endpoints not to show up or display erros.

Definitions
-----------

We can define types that are returned. Add the below ``yaml`` to the ``defintions`` section. Notice that this is referenced in the ``responses`` section of ``/cart``.

.. code:: yaml

  definitions:
    Item:
      type: object
      properties:
        uid:
          type: integer
          format: int32
        name:
          type: string
          example: "Chacos"
        price:
          type: number
          format: int64
          example: 1.00
        newItem:
          type: boolean
          example: true
        description:
          type: string
          example: "I think they're a type of sandals"


Now for Items
-------------

Add this to the ``tags`` section:

.. code:: yaml

  - name: item
    description: Items to be added to cart.


Add this to the ``paths`` section:

.. code:: yaml

    /items:
      get:
        tags:
        - item
        summary: Returns items
        operationId: getItems
        produces:
        - application/json
        responses:
          200:
            description: successful operation
            schema:
              type: array
              items:
                $ref: "#/definitions/Item"


But wait, ``/api/items`` has two optional query parameters ``/api/items?price=99&new=true``. Add ``parameters`` to ``item``.

.. code:: yaml

  parameters:
    - in: query
      name: price
      schema:
      type: double
      required: false
      description: match items by price
    - in: query
      name: new
      schema:
      type: boolean
      required: false
      description: match items by newItem true/false

Parameters
----------

There are two types of parameters: ``query`` and ``path``.  See the `Swagger documentatio <https://swagger.io/docs/specification/describing-parameters/>`_ for more info about documenting parameters.

Continue On
===========

Continue on to provide documentation for the rest of the LaunchCart API. It should be much easier now that the Cart definition has been created.
