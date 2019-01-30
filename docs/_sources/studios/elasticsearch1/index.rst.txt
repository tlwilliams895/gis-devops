:orphan:

.. _elasticsearch1-studio:

==========================
Elasticsearch Query Studio
==========================

Elasticsearch Installation
==========================

We need to install Elasticsearch and Kibana locally. Elasticsearch is built on Lucene, a Java library, so you may be prompted to install a particular version of Java that is a dependency of the current version of Elasticsearch.

On Mac, use Homebrew: ::

    $ brew install elasticsearch
    $ brew install kibana


And then, to start up the server: ::

    $ brew services start elasticsearch
    $ brew services start kibana

In your browser, navigate to http://localhost:5601 to access Kibana. Select the *Dev Tools* view from the left-hand pane.

Check that the installation and starteup were successful by checking the cluster's health: ::

    GET /_cat/health?v

All being well, the output should look something like this: ::

    epoch      timestamp cluster              status node.total node.data shards pri relo init unassign pending_tasks max_task_wait_time active_shards_percent
    1516231703 17:28:23  elasticsearch_cheryl yellow          1         1      5   5    0    0        5             0                  -                 50.0%


.. note::

    If you don't receive something like the response above, restart the service using: ``brew services restart SERVICE_NAME`` (where ``SERVICE_NAME`` is either ``elasticsearch`` or ``kibana``.


Cluster health is expressed as the color green, yellow, or red.

* **Green** - everything is good (cluster is fully functional)
* **Yellow** - all data is available but some replicas are not yet allocated (cluster is fully functional, but more vulnerable to data loss/corruption)
* **Red** - some data is not available for whatever reason (cluster is partially functional)

.. note::

    When a cluster is red, it will continue to serve search requests from the available shards but you will likely need to fix it ASAP since there are unassigned shards.

You can see from the output that we have 1 node and 0 shards (since there's no data yet).
Let's confirm we don't have any indices yet. ::

    GET /_cat/indices?v


Your response should just show headers and no content: ::

    health status index                                    uuid                   pri rep docs.count docs.deleted store.size pri.store.size

Loading Data
============

Create a file ``load_data.sh`` and make it executable:::

    $ touch load_data.sh
    $ chmod +x load_data.sh

Open it in an editor and copy/paste the contents of this `gist <https://gist.github.com/chrisbay/415a961d3524fc7c91dbbf88513308d8>`_.

Run the script to create some documents:::

    $ ./load_data.sh

.. note::

    If an error occurs while running the script, delete the index. Get help from an instructor and then try again.

    You can delete an index this way: ``DELETE /twitter/``


Your Tasks
==========

Now you'll get some practice with Elasticsearch. Carry out each of the following tasks. Once you have a successful query/command for each, save the commend in a ``.txt`` file for submission

1. Get information about the ``twitter`` index
2. Fetch the first 10 documents of the index
3. Fetch the last 10 documents of the index
4. Add a document to the index
5. Fetch the document that you just added
6. Delete a the document that you just added from the index
7. Get all tweets by John Smith
8. Get the average number of likes for all tweets

Turning In Your Work
====================

Submit your queries to an instructor via Slack once you're finished.
