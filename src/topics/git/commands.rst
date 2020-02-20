:orphan:

.. _git_commands:

======================
Git Commands Reference
======================

Create a New Branch
-------------------

#. ``git status`` to make sure you are on the branch you want to make a branch from
#. ``git checkout -b NEW-BRANCH-NAME`` creates branch NEW-BRANCH-NAME and switches to it

Switch to an Existing Branch
----------------------------

#. ``git fetch`` to make sure you have an updated list of branches
#. ``git branch -a`` show a list of all existing branches
#. ``git checkout BRANCH-NAME`` will checkout the branch BRANCH-NAME

Commit and Push
---------------

How to commit and push your changes to a remote repo.

#. ``git status`` to review branch and files that have changed
#. ``git add .`` stage your changes
#. ``git commit -m "a short message about what you changed"``
#. ``git push`` push commit to remote repo

Other Helpful Commands
----------------------

* ``git log`` see list of commits on your current branch
* ``git pull`` pull in the latest changes for your current branch from origin
* ``git fetch`` make your local repo aware of any new changes on origin
* ``git reset --hard`` WARNING!! Removes all local changes that have NOT been committed 