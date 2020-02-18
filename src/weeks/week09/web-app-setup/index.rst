:orphan:

.. _week9-web-app-setup:

=============
Web App Setup
=============

Project Changes for Deployment
------------------------------

To prepare our project for deployment we need to make a few changes.

ORM
^^^

We don't want our ORM (Hibernate) to make drop, or create any tables in our database so we will need to change our ``application.properties`` file. Change the ``spring.jpa.hibernate.ddl-auto`` to ``update``.

Dynamic Linking
^^^^^^^^^^^^^^^

You will want to make sure you are using dynamic links in your Javascript files. Instead of using ``http://localhost:8080/api/routes`` you will want to use ``/api/routes`` the browser will automatically make the request against the same server. This way you don't have to change the links everytime the IP address of your server changes.

Environment Variables
^^^^^^^^^^^^^^^^^^^^^

Hopefully you have been using environment variables throughout your project. If you haven't you're going to need to in order to keep things simple between your development environment and production environment.

What are our potential environment variables:
- Database Host (localhost, RDS endpoint)
- Database Name
- Database Port
- Database User
- Database User Password
- Elasticsearch Cluster URL
- Elasticsearch Cluster Name
- Testing Database Information

If you have these values hard coded in your application you will have to change each one of them before you can deploy your app. Or you can turn them into environment variables.

Build JAR
---------

Once you are ready to ship your application you will need to build a new JAR.

You will want to run the Gradle ``bootRepackage`` task which will build you a new JAR file.

Move JAR to EC2
---------------

You are going to have to move this file to your Web App EC2 somehow. SCP and S3 are 2 potential options.

Create Unit
-----------

After you move your JAR to the correct location, give it permission to run and set it's user you can create a Systemd Unit file and start your application as a service.

Create your Unit File at this location: ``/etc/systemd/system/zika.service``

.. sourcecode:: bash
   
   [Unit]
   Description=Zika Dashboard
   After=syslog.target
   
   [Service]
   User=zika
   EnvironmentFile=/etc/opt/zika/zika.config
   ExecStart=/usr/bin/java -jar /opt/zika/app.jar SuccessExitStatus=143
   Restart=always

   [Install]
   WantedBy=multi-user.target


Create Unit Configuration
-------------------------

Since we are using Environment Variables we will have to provide them in a unit configuration file.

Create your Unit File at this location: ``/etc/opt/zika/zika.config``

.. sourcecode:: bash

   APP_PORT=8080
   APP_DB_HOST=zika-example-db.cq2s2klvmrfq.us-west-2.rds.amazonaws.com
   APP_DB_PORT=5432
   APP_DB_NAME=zika
   APP_DB_USER=zika_app_user
   APP_DB_PASS=verysecurepassword
   ES_CLUSTER_URL=10.0.0.237
   ES_CLUSTER_NAME=docker-cluster
  ES_CLUSTER_PORT=9300


Start Unit
----------

Now that you have created the unit, and it's configuration go ahead and enable and start the service.

``sudo systemctl enable zika``
``sudo systemctl start zika``

Troubleshoot Unit
-----------------

You will want to watch the logs to make sure it starts properly. ``journalctl -fu zika``

Watch the logs and make sure it starts properly if it doesn't read the stack dump to determine the issue. The issue could be one of many different things, read the error log and try to determine what the issue is by talking to an instructor, or fellow class mate.

Test Out Web-app
----------------

After the application starts correctly navigate in your browser to your EC2 public endpoint on the correct port and see your application running.

Next Steps
----------

From here you can continue working on your project to clean up any issues, or optimize how it runs in the cloud. Or you can start configuring your application to work with your EC2 that should be running Elasticsearch.