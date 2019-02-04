:orphan:

.. _eslint-airwaze-walkthrough:

===========================
Walkthrough: ESLint Airwaze
===========================

Setup
=====

* Open the ``airwaze`` project/repository that you have used previously.
* Do a ``git status`` to see if you had any unfinished business, if so please add and commit
* Once you have a **clean** ``git status``, checkout and create a new branch with ``git checkout -b add-eslint``
* Run ``bootRun`` and view your map in the browser to confirm a working state before adding any new functionality

Let's Add ESLint
================

* Open your ``.gitignore`` file and add ``**/node_modules``
* In terminal go to ``airwaze/src/main/resources``
* Run ``$ npm init``. **See below** for prompts

  1. airwaze
  2. enter to accept default
  3. js to display airports and routes
  4. enter to accept default
  5. test
  6. press enter for remaining questions

* Review the ``package.json`` file that was just created
* Run ``$ npm install eslint --save-dev``
* Run ``$ npm install eslint-plugin-import --save-dev``
* Run ``$ ./node_modules/.bin/eslint --init`` **See below** for how answer prompts

  1. Use a popular style guide.
  2. Pick Airbnb
  3. NO to using React
  4. Pick JavaScript for config file type
  5. Yes to installing airbnb dependency

* Review the file that was just created ``.eslintrc.js``
* Update the ``"scripts"`` property in ``package.json`` to the below::

    "scripts": {
        "test": "eslint static/js/script.js"
    },


Override the Airbnb indentation rule
====================================

Modify ``.eslintrc.js`` to look like this. If you don't, you will get numerious ``indent`` errors because Airbnb lint rules detault to two spaces. We are doing this because 
we want to use 4 space identation instead of the default 2 that the Airbnb ruleset defines. `See rules here <https://github.com/airbnb/javascript>`_

::

  {
      "extends": "airbnb-base",
      "rules": {
          "indent": ["error", 4]
      }
  }


Let's Do Some Linting!
======================

* Run ``$ npm test`` and cringe at the "errors" that are found

  * Remember that errors in this case are lines of code that break an eslint rule
  * If you are not sure what the error is about, then lookup what the rule means here `ESLint Rules <https://eslint.org/docs/rules/>`_
    
    * The rule name will be in the far right column. Example rule name ``no-unused-vars``

* Fix one issue at a time, save your file, and run ``$ npm test`` again
 
  * You don't want to change too many lines at once without making sure your code still works
  * So save and reload your map in the browser to make sure your dots still show up

  .. image:: /_static/images/eslint-results.png

Let's Make this Easier
======================

It's totally fine to view linting errors in the console, but we can also use editors to alert us of these issues as we write the code. We are going to setup VisualStudio Code to "auto lint" using our defined linting rules. After we set this up, we won't have to save and re-run ``$ npm test``.

* Open Visual Studio Code (if you don't have it, you should use ``$npm test`` to lint your code)
* Open your Airwaze project

  * You only have to open the /airwaze-project/src/main/resources folder, because that is where the js and eslint files are
  
* Click on extensions (the squareish icon in the left menu)
* Enter eslint into the search box
* Click install
* Click reload

  .. image:: /_static/images/vs-code-eslint-plugin.png

* Now go to your ``script.js`` files and look for red underlined code
* Hover over the code for an explanation of the error

  .. image:: /_static/images/vs-code-show-errors.png

Resources
=========
* `ESLint Rules <https://eslint.org/docs/rules/>`_
