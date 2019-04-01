:orphan:

.. _eslint-airwaze-walkthrough:

===========================
Walkthrough: ESLint Airwaze
===========================

Concept
=======

We use linting to reduce the number of code smells we create, and to bring our code to a standard that other programmers in our group will be able to understand, and work with.

Terms:
    - **Ruleset**: a pre-defined set of rules, or conventions our code will follow.
    - **Lint**: code that does not follow our ruleset.
    - **Linting**: the process of removing lint.
    - **Linter**: a tool that scans our code, and highlights lint.

It is possible to follow a ruleset without using a linter. However, we are people and inevitably will make mistakes. We use linters to manage our ruleset, and to scan our code to ensure we are following rulesets. Many linters will run automatically, or are built into IDEs to make spotting lint as easy as possible. Using a linter allows us to focus on solving a problem instead of focusing on the ruleset.

Most linters will tell you what rule you have broken, and where that mistake was made. It is still up to us as the programmer to make the changes pointed out by our linter.

Ruleset
-------

We will be using the `Airbnb JavaScript Style Guide <https://github.com/airbnb/javascript>`_.

There are many different rulesets, and they have a few different names: style guide, ruleset, conventions, etc. They all refer to the same thing a pre-defined set of conventions/rules/styles we will follow when we write our code. Typically, before any code is commited it needs to follow all rules in the ruleset. Teams are responsible for defining their rulesets, many teams will adopt a widely used ruleset, and then modify it to meet their needs.

Common Rules addressed by Rulesets:
    - Whitespace: Spaces, or Tabs? How many? What should be indented?
    - Variable Naming Standards: CamelCase, pascalCase, snake_case?
    - Object Intialization: New keyword?? Literal syntax?
    - Brackets: Same line as code, or on their own line?
    - Comments: Single line? Multi line? Docstrings?
    - Line length: how long can a line be?

Setup
=====

We will be setting up ESLint for the Airwaze project we worked on in Week 1 of this class.

First we will need to create a new branch for our work. From either the branch you created last week, or the ``eslint-starter`` branch, create a new branch called ``eslint-solution``.

To use ESLint with this branch:
    - Install npm
    - Initialize npm
    - Configure ESLint for this project
    - npm test

Install NPM
-----------

On mac we will install NPM with ``$ brew install node``.

NPM stands for Node Package Manager, it is a package manager for JavaScript, and comes with Node.js. This package manager will allow us to download JavaScript modules from the NPM Registry. One of which is ESLint.

From your airwaze directory run ``$ npm init``. This initializes a new npm package. We will be installing ESLint into this package.

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


Walkthrough
===========

Let's Do Some Linting!
----------------------

* Run ``$ npm test`` and cringe at the "errors" that are found

  * Remember that errors in this case are lines of code that break an eslint rule
  * If you are not sure what the error is about, then lookup what the rule means here `ESLint Rules <https://eslint.org/docs/rules/>`_
    
    * The rule name will be in the far right column. Example rule name ``no-unused-vars``

* Fix one issue at a time, save your file, and run ``$ npm test`` again
 
  * You don't want to change too many lines at once without making sure your code still works
  * So save and reload your map in the browser to make sure your dots still show up

  .. image:: /_static/images/eslint-results.png

Bonus
=====

Setup `ESLint in VisualStudioCode <../../installations/vscode-eslint/>`_.

Resources
=========
* `ESLint Rules <https://eslint.org/docs/rules/>`_
