:orphan:

.. _week9-elasticsearch-setup:

===================
Elasticsearch Setup
===================

SSH Into EC2
------------

To setup our Elasticsearch cluster we will need to first secure shell into the server.

Install Docker
--------------

Install Docker with: ``sudo apt-get install docker-ce``

Verify it installed correctly by running ``docker --version``.

Create New ES Cluster in Docker
-------------------------------

We essentially want to create and run a new container that is similar to the one we have been using locally.

We did that earlier in the class with a command like: ``docker run --name "es" -p 9200:9200 -p 9300:9300 -e discovery.type=single-node -e cluster.name=elasticsearch -t -d elasticsearch:6.5.4``

Test it Out
-----------

After the container is up and running. Curl it with: ``curl 127.0.0.1:9200``. You should see a JSON response that includes information about the cluster, including the cluster name which should be elasticsearch.

Test it from Web App EC2
------------------------

This resource will ulitmately be used by our web app EC2. So after testing that the cluster is up and running on it's own server, we should make sure we can access it from the EC2 of our web application.

SSH into your Web App EC2.

From here you will want to curl the elasticsearch cluster. Above we used: ``curl 127.0.0.1:9200``. Now we want to use the internal IP address of our Elasticsearch EC2. So it may look like this: ``curl 10.0.1.103:9200``.

If you see the same output you saw in the previous step we know our Web app EC2 can communicate with Elasticsearch on a different server.

You may need to go back and change your Web app config file to match the IP address of this Elasticsearch EC2.

Next Steps
----------

Your application should be deployed and it should have elasticsearch functionality. From here you should troubleshoot your application, or work on an automated CI/CD pipeline with Jenkins, bash scripts, Travis, or GitLabCI.

The goal would be for your application to deploy itself when any change is made to your master branch. This will take some work, and has only been partially explored so far in class so you will need to do some research, and trial and error on your own. Talk with other classmates, and the instructor to figure out what you will need to do.