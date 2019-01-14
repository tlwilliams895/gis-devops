:orphan:

.. _walkthrough-sonarqube:

======================
Walkthrough: Sonarqube
======================

Follow along with the instructor as we configure Sonarqube.

Setup
=====

Create a new story branch in your ``airwaze-studio`` repoo. Name it ``add-sonarqube``.  When finished with this walkthrough you can merge it into your ``master`` branch.

Continuous Inspection
=====================

Sonarqube is an open source tool for continuous inspection of code quality including: bug detection, code smells, and security vulnerabilities.

We will use Sonarqube to analyze our Java code. It will search for duplicate code, unused variables/parameters, code smells, and much more. Fixing the issues found by sonarqube helps to
keep our code consistent between developers and hopefully more secure and stable. Consider sonarqube to be Eslint for Java, with more features. Note that sonarqube will analyze multiple language, however for this class we are only using it for Java.

Sonarqube runs as a service. Project configuration and reports are viewable in your browser via web interface. Defaults to ``http:localhost:9000`` if installed locally.

Sonarqube can integrate with other tools such as gradle and jenkins.

Install and Configure Sonarqube
===============================

* Go to `https://www.sonarqube.org <https://www.sonarqube.org>`_
* Click **Download**
* Choose the latest vesion **Community Edition 7.5**
* Unzip the downloaded file to ``~/sonarqube-7.5``. (Note your version may vary)
* Open a terminal and run this command ``$ ~/sonarqube-7.5/bin/macosx-universal-64/sonar.sh start``
* Now go to this address in your browser: ``http:localhost:9000``
* Login with default user. username: admin password: admin (<- example of not changing defaults. very bad!)
* Enter ``airwaze`` as the project key

Configure your Java Project
===========================

* Add this line to ``plubins`` in ``build.gradle`` file

::

    id "org.sonarqube" version "2.6"

* Will look like this after

::

  plugins {
	id "com.github.sgnewson.gradle-jenkins-test" version "0.5"
	id "org.sonarqube" version "2.6"
  }

Run Sonarqube Gradle Task
=========================

* In terminal or via the Gradle menu in Intellij, run the ``sonarqube`` gradle task (note it's under **other** in intellij gradle menu)
* This gradle task runs other gradle tasks like ``compileJava`` and then creates a report that is viewable on the sonarqube web app


View the Results in Sonarqube
=============================

* Navigate to ``http://localhost:9000/projects``
* Click on the project name
* On the project page, click on the numbers in each category to get a detailed report about that topic
