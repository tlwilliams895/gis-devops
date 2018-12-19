:orphan:

.. _swagger-studio:

=============================
Studio: Springfox and Swagger
=============================

In this studio, we will be learning how to use Springfox to autogenerate the Swagger docs.

Getting Started
===============

Create a ``add-springfox`` branch off of your ``launchcart/rest-studio-solution`` branch.

.. warning:: Do *not* create the branch off of the walkthrough studio, since we manually created Swagger docs in that branch.

Configure Springfox
===================

Add these to the ``dependencies`` block in ``build.gradle``: ::

    compile(group: 'io.springfox', name: 'springfox-swagger2', version: '2.9.2')
    compile(group: 'io.springfox', name: 'springfox-swagger-ui', version: '2.9.2')


Add ``@EnableSwagger2`` annotation to ``LaunchcartApplication.java``

.. code-block:: java

  @EnableSwagger2
  @SpringBootApplication
  public class LaunchcartApplication {

    public static void main(String[] args) {
      SpringApplication.run(LaunchcartApplication.class, args);
    }
  }

Within the same class, add a ``Docket`` bean to allow for some code-based configuration of Springfox:

.. code-block:: java

  @Bean
  public Docket apiDocket() {
    return new Docket(DocumentationType.SWAGGER_2)
        .select()
        .apis(RequestHandlerSelectors.any())
        .paths(PathSelectors.any())
        .build();
  }



View the Generated Swagger Documentation
========================================

Now start your application. Navigate to http://localhost:8080/login to log in, and then go to http://localhost:8080/swagger-ui.html to view the generated Swagger docs.

.. Warning::

  Because of authentication code included in the LaunchCart application, this URL will not load unless you are logged in.

Tasks
=====

Bypassing Login
---------------

Figure out how to change ``AuthenticationInterceptor.preHandle`` to allow the Swagger docs to load when you are NOT logged in.

.. hint::

  Log out of LaunchCart, and then try to access `your Swagger docs page <http://localhost:8080/swagger-ui.html>`_ with your browser's developer tools opened to the Network tab.

  Note which resource requests return 4xx errors. You'll need to modify ``AuthenticationInterceptor.preHandle`` to allow these requests through.

Display Only API Endpoints
--------------------------

Swagger is currently showing *all* endpoints, including non-API endpoints that return HTML. Figure out how to display *only* ``/api`` endpoints in the Swagger report.

.. hint:: You should refer to `section 6.1 of Baeldung's Springfox tutorial <https://www.baeldung.com/swagger-2-documentation-for-spring-rest-api#advanced>`_. And note that while we create a configuration bean above, we haven't put it to use yet!

Turn in your Work
=================

* Commit and push your work to GitLab.
* Create a merge request and post it to slack.
* Notify the instructor that you are done, along with the name of the branch that you completed your work in.
