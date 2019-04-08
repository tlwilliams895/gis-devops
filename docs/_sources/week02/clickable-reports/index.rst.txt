.. _week2_clickable-reports:

=========================================
Project Week2: Zika Reports are Clickable
=========================================

We have a map from OSM, and we are creating a new Layer of Zika reports to geographically represent cases of Zika.

To complete our final primary objective we need to make our reports clickable!

Tasks:
    - Amend ReportController.java
    - Amend ReportControllerTests.java
    - Amend ReportRepository.java
    - Amend ReportRepositoryTest.java
    - Amend index.html
    - Amend script.js
    - Commit

Amend ReportController.java
---------------------------

Right now our ReportController class has one method in it that returns a FeatureCollection (GeoJSON) of all the reports in the database. However, we want to return only the reports that are in the click event.

In order to do this we will need to create a new endpoint that can get just the information about just a couple of reports at a time.

You will need to create a new endpoint, method handler, and query parameters about which reports to get from the database.

Again look at the `Airwaze studio <../../studios/airwaze/>`_ to see how we accomplished this in the past.

Amend ReportControllerTests.java
--------------------------------

Since we are adding new functionality to our ``ReportController.java`` file, we also need to write tests in ``ReportControllerTests.java``.

Amend ReportRepository.java
---------------------------

To get one report at a time, we will have to add to our ``ReportRepository.java`` file. Right now we just have base CRUD functionality provided by the JpaRepository class we are extending.

We will have to create a new method that will get only one report out at a time, based on some form of uniqely identifying information about that report. Look over the `AirportRepository.java file <https://gitlab.com/LaunchCodeTraining/airwaze-studio/blob/master/src/main/java/com/launchcode/gisdevops/data/AirportRepository.java>`_ for assistance.

Amend ReportRepositoryTests.java
--------------------------------

Since we are adding functionality to ``ReportRepository.java`` we also need to test for it in ``ReportRepositoryTests.java``.

Amend index.html
----------------

We are going to need some HTML structure to put this new Report information into.

Look over the `airwaze studio <../../studios/airwaze/>`_ to see how they used the ``index.html`` file to create an empty section of HTML to put Airport data into.

Amend script.js
---------------

We will have to add a click event handler to our map, which will have to loop through the features contained in the click event, and for each feature we will have to make a request to our new endpoint to get information we can display in our new HTML structure.

Look over the `airwaze studio <../../studios/airwaze/>`_ to see how they created a new onclick event, and how they made calls to the new endpoint.

Commit
------

After re-running your tests, and visually checking your map, and new click events commit and push your code!