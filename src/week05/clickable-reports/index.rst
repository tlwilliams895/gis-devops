:orphan:

.. _week5_clickable-reports:

==========================================
Project Week 5: Zika Reports are Clickable
==========================================

We have a map from OSM, and we are creating a new Layer of Zika reports to geographically represent cases of Zika.

To complete our final primary objective we need to make our reports clickable!

Tasks:
    - Amend index.html
    - Amend script.js
    - Commit

Amend index.html
----------------

We are going to need some HTML structure to put this new Report information into.

Look over the `airwaze studio <../../studios/airwaze/>`_ to see how they used the ``index.html`` file to create an empty section of HTML to put Zika Report data into.

Amend script.js
---------------

We will have to add a click event handler to our map. Within the click event handler, we will need to iterate over any selected features, and add information about the feature to the empty HTML structure we created above. Using JavaScript template literals is a great way to do this. Our Airwaze studio is an example of how to do this.

Look over the `airwaze studio <../../studios/airwaze/>`_ to see how they created a new onclick event, and how they made calls to the new endpoint.

Commit
------

After re-running your tests, and visually checking your map, and new click events commit and push your code!

Back to :ref:`week5_project`.
