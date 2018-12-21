:orphan:

.. _elasticsearch2-studio:

==============================
Elasticsearch Queries Studio 2
==============================

In this studio you will practice working with indices (deleting, reindexing) and mappings. You will also run some filtered and geo queries on Elasticsearch.

Loading Data
============

First, let's delete the data in the ``twitter`` index:::

  DELETE /twitter

As we did yesterday, let's load some data. Create a script: ::

  $ touch load_data_geo.sh
  $ chmod +x load_data_geo.sh

Then copy/paste the contents of this `gist <https://gist.github.com/chrisbay/8ef471ed1ac903c2bcaa2b82b49917a4>`_. Save and run the script: ::

  $ ./load_data_geo.sh

Your Tasks
==========

Carry out each of the following tasks. Once you have a successful query for each, save the command in a ``.txt`` file for submission.

1. What is the data type of the ``location`` field in the ``twitter`` index? What should it be?
2. Fix the issue with ``location`` by creating a mapping for a new index ``twitter_geo`` that defines ``location`` as a ``geo_point`` field. **Hint**: To build the JSON that you'll need to create the new mapping for ``twitter_geo``, you can copy the reponse from fetching the mapping for ``twitter`` and modify it.
3. Reindex ``twitter`` into ``twitter_geo``.
4. Find all tweets with between 5 and 10 likes, inclusive of those endpoints.
5. Find all tweets by Mary Jones that have at least 2 likes.
6. Find all tweets that contain the text "Elasticsearch", including mispellings up to distance of 3 away.
7. Find all tweets that have a location (Hint: Try the exists query https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-exists-query.html)
8. Find all tweets that do not have a location
9. Find the average number of likes for tweets that have a location
10. Find the average number of likes for tweets that do not have a location
11. Find all tweets with locations within 500km of Boise, ID

Turning In Your Work
====================

Submit your queries to an instructor via Slack once you're finished.
