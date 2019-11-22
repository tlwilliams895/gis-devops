Git Reference
=============

Version Control Systems
----------------------

  VSC: a program that tracks the history (changes) of files in a directory over time

-  version control is a critical aspect of software development
-  it allows for developer(s) to keep track of all of the changes to a codebase over time
-  this information can be used to reflect on how a codebase was developed
- a VSC can be used to view the state of a codebase at different points in time and even revert to previous states when needed
- Git is by far the most popular VCS but others include SubVersion (SVN) and Mercurial
   

Git as a VCS
------------

-  learn more about git in detail by reading the (free) `Git Book <https://git-scm.com/book/en/v2>`__

-  Git is a special kind of VCS that is equal parts powerful, collaborative and efficient
-  Git works by storing the diffs (differences) between files that it has tracked in its linear history

-  instead of storing complete copies (``version1.txt``, ``version2.txt``) it only stores the line-by-line differences between the saved states of the file(s) it tracks

-  it supports **branching** chronological tracks of history so that collaborative and experimental work can be tracked without affecting other branches of history

-  it has support for reconciling “differences in history” when collaborating with teammates on a single project repo

Three Components of Git
-----------------------

  **repository**: the aggregate of history and metadata associated with the project

-  this is the heart of a project version controlled by Git
-  often referred to as a **repo**

  **branch**: a linear timeline of changes to files

-  repos are made up of (at least one) branch
-  the default branch every repo begins with is called **master**
-  other branches can “branch off” of a source branch (master or any other) to create tangential historical timelines

   -  think of this like a tree where smaller sub-branches can sprout from a main branch
   -  except git also allows the distinct history of those sub-branches to be joined back with the branch they originated from to form a single continuous history
   - joining branches back together is called **merging**

-  these timelines can be used to test out a tangential idea or (most commonly) for collaborating with multiple teammates on a single project repo
-  alternative branches can be “merged” back into their parent branch to join their histories into a single linear timeline

  **commit**: every branch is made up of commits which are save points in the the branch’s timeline

-  a commit has a unique identifier known as a commit hash
  
  -  this can be used to roll back and view that distinct point in history

-  every commit includes information about the file(s) that were changed
-  the changes are stored as diffs of each changed file from the last commit to the current one
-  they also include a message (describing the changes) along with timestamp and author information for accountability

Local Workflow
--------------

-  every new coding adventure should begin with initializing a Git
   repository

   -  this allows you to version control your project over time
   -  the history (and the current state or edge of that history) are
      critically important to keep track of

- you can initialize a Git repo at any time even if a directory already has project files in it
  
  - the only downside is that the history will begin from that starting point instead of from the beginning
  - but it is best to setup Git first so that the entire history can be tracked

  initialize a directory with git to create a git repo

.. code:: sh

  # issue from inside the directory you want git to version control
  $ git init
..

  once git is initialized you can begin creating project files

-  by default all files in a git directory are considered “untracked” (because git doesn’t know what you want to keep or throw away)

  view the status of your git repo to see the changes of tracked files and presence of untracked files

.. code:: sh
  
  # issue from anywhere in the repo directory
  $ git status
..

-  this will show you what files are tracked or untracked and any changes that have been detected to tracked files
-  the first time you issue this in your new repo all of the files will be considered untracked
-  new files must be **staged** to begin having their changes tracked by git
-  whenever you reach a stable point of some changes you are making you should “stage” (a precursor to committing) the files you want to keep

  stage the files to take a snapshot their current state (last edit) and prepare for a save

.. code:: sh

    # stage a single file
    $ git add </path/to/file.ext>
    
    # or to stage all files in the current working directory
    $ git add .
..

-  if the files were previously untracked (from the ``status``) command then this will mark them as tracked

   - this means git will now monitor these files for changes from this point forward

-  if the files were previously tracked (marked as “modified” in the ``status`` command) then this means to snapshot the latest changes in preparation for saving (committing)

   -  **NOTE: this is not the same as saving (committing) changes to your branch’s history!**
   -  think of it as a “pre-commit” snapshot for git to prepare itself before saving in history

Commits
-------

  once the changes have been staged we can save the staged snapshots in a commit

.. code:: sh

    # the -m flag is a shorthand for adding the message in a single command
    $ git commit -m "commit message goes here"
    
    # if you want to use the default text editor (defined in your shell preferences, usually VIM or Nano) leave it off
    $ git commit
    # you will now be presented with the text editor to write your message
.. 

-  this is called "committing your changes"
-  committing means to add a save point in the history **of the branch you are on**
-  every commit is made up of

   -  a timestamp (automatic)
   -  author details (automatic)
   -  file diffs (automatic)
   -  a message describing the changes (manual)

  once you have committed (saved in history) your changes you can view them using the git log

.. code:: sh 

  # verbose (default view) mode
  $ git log

  # short mode
  $ git log –oneline

  # both modes displays the git log output using “less”
  # press J to scroll down and K to scroll up 
  # press Q to quit
..

-  use the git log to see information about the history of **the current branch**
-  this will show you the linear timeline of commits starting from the most recent commit (at the top) to the first commit (at the end)
-  if you are on a non-default branch (something other than ``master``) then the log will display

   -  the history (commits) of this current working branch followed by the history of the source branch (what the working branch was branched off of)

Committing Best Practices
^^^^^^^^^^^^^^^^^^^^^^^^^

  as you work on your project you want to **continuously update git** 
  
  there is little benefit to a version control system that is not “versioned” (meaning changes are committed in massive blocks that are difficult to review or roll back to)

-  think of commits as a way to save and describe how your codebase is changing over time

    -  be descriptive and selective as to how you organize those changes
    -  but don’t be so granular as to commit for every line that changes

-  commit a file whenever it reaches a stable point (whenever it is working as expected)
-  in some cases it is okay to commit multiple changed files if they are all part of a single “overall” change

  **ALWAYS provide a useful commit message to describe the changes**

-  do not be lazy with “made some changes” type of messages that offers nothing of value to you or anyone else going through the development history!
-  the first 80 character is the “header” and is sometimes all you need
-  if you need to add extra context skip a line and add a “body” to the commit with those additional details

    - be aware that long commit messages usually indicate that too many changes are being committed - keep things concise

Branches
--------

-  branches are used for

   -  separating experimental and tangential changes from a source
      branch (typically ``master``)
   -  separating individual “features” into branches so that multiple
      team members can collaborate on a codebase without conflicting
      with each other

-  branches are meant to be short sub-paths of history for experimentation or implementation of individual features 

   -  they are designed to maintain their own “extended” history without impacting the history of the branch they originated from
   -  they can be merged into their source branch when you want to keep the feature and add the history of its development to the overall history stored in the source branch
   -  or discarded and pruned when you want to throw away the history and start fresh from the source branch

Creating New Branches
^^^^^^^^^^^^^^^^^^^^^

-  creating a new branch means to branch off of a historical starting point (most often the previous history of another branch)
-  the history of the new branch begins with the last commit on the branch it originated from
-  you must always switch to the right source branch (usually ``master``) before creating a new one

  create a new branch

.. code:: sh 
 
  # create and check out the new branch
  $ git checkout -b <branch-name>
..

-  each branch has its own history (made up of commits)

   - the commits will include all of the history of the source branch in addition to any commits made on the new branch to form a linear history

  you can repeat the previous local workflow by writing code, staging and committing to build up the history of the new branch

Switching Branches
^^^^^^^^^^^^^^^^^^

-  you are always working on a single branch called the “working branch” (much like the CWD or current working directory)

  switching between branches with different histories is a wild effect where the actual files themselves reflect the current historical state of the working branch

  when you switch a branch you can watch your editor appear to create / delete / modify files instantaneously as you switch between points in history!

-  switching branches is called “checking out” a branch

   -  you are actually telling git to move its “HEAD” position (like the needle head on a record) to a new source of history

  checkout a branch to switch from one to another

.. code:: sh

  $ git checkout <branch-name>

  $ git checkout
..

-  if you want to check out a particular point in history you can use the git log to see all the commits

   -  get the commit hash (unique ID of the commit) and use that to checkout that point in history
   -  this means to (temporarily) display the state of the code in that point in history

.. code:: sh

  # verbose output (author, timestamp etc)
  $ git log

  # shorthand output (COMMIT_HASH MESSAGE format)
  $ git log --oneline

  # select a commit hash and check it out
  $ git checkout COMMIT_HASH
..

  when a feature branch is complete and you want to “merge” the histories between the feature and the source branch that it originated from

.. code:: sh

   # usually the source branch will be master
   $ git checkout <source-branch-name>

   $ git merge <feature-branch name>
..

Branching Best Practices
^^^^^^^^^^^^^^^^^^^^^^^^

- sub-branches are generally referred to as "feature branches" because they are used to encapsulate the history and changes associated with a single new feature (a bug fix, refactor or new addition)

-  do not make branches off of sub-branches as it will be more challenging and confusing to reconcile them during merging
-  always branch off of the ``master`` branch to keep your main branch history clean while working on separate features

   -  in advanced collaboration these rules may be stretched to fit the needs of an employed development team

   -  otherwise nested branches add unnecessary complexity to small or casual teams and certainly to individual developers

.. TODO: merge conflicts
.. TODO: stashing

Collaborating with Git
----------------------

-  use a “remote repository” which serves as a git repo on a remote
   server

   -  multiple members of a team can interact with that “source of
      truth” to collaborate independently and remotely
   -  you can also use this to back up your work externally from your
      machine
   -  remote git providers: GitHub, GitLab, etc

-  the process of collaborating with a remote repository involves 3
   phases revolving around the implementation of new features on
   “feature branches”

   -  *Pushing*: sending changes from your local branch history to the
      remote branch history
   -  *Pulling*: downloading changes from the remote branch history to
      your local branch history
   -  *Merging*: the process of reviewing and merging feature branches
      into the main branch using the remote Git provider UI

Collaboration Workflow
----------------------

-  to begin working on a new project create a repo on your chosen remote
   Git provider

   -  you can then register the URL of the remote repo to your local
      repo
   -  once the remote repo is registered locally (for teach team
      member’s local machine) development work can begin
   -  the local workflow remains the same with the new additions of
      pushing your local changes and pulling the changes others have
      made to the repo to stay synchronized

-  add a remote

   -  first you must create the repo on the remote Git provider site
   -  then copy the git URL of the repo and register it as a remote
      locally

      -  every team member must register the remote locally so that they
         can begin pushing and pulling from it

   -  a remote is registered using a shorthand name and a URL
   -  you can have any number of remotes registered on a repo but by
      convention the “primary” remote is called ``origin``

   .. code:: sh

      $ git remote add REMOTE_NAME REMOTE_URL
      # by convention we use the remote name "origin"
      $ git remote add origin REMOTE_URL
      # remove a remote
      $ git remote remove REMOTE_NAME

Cloning
-------

-  cloning is the process of replicating an existing remote repo locally

   -  for creating a new project

      -  rather than creating the repo locally first you can use cloning
         to generate the project repo and register the remote in one
         command

   -  working on existing code

      -  you can clone any public repo locally to learn how it works or
         begin collaborating (if you are given permission of course)

   -  restoring the remote backup of your code

      -  if you need to work from a different machine or had a hard
         drive failure

-  cloning will

   -  create a new directory with the name of the remote repo

      -  it will create the directory in the CWD the command is issued
         from

   -  add a default remote “origin” that points at that remote repo

-  to clone a repo

.. code:: sh

   # clones the repo in the current directory
   $ git clone REMOTE_REPO_URL
   # clone the repo somewhere else (dont forget to provide a repo name or its contents will be dumped into that directory path)
   $ git clone /path/to/directory/repo-name
   # if the repo directory doesnt exist it will be created in this process

Pushing
-------

-  pushing means to reflect the local history to the remote history *for
   the current branch*

   -  history of your local branch -> history on the remote branch

-  the first time you push should be off of the ``master`` branch
-  to push a branch you need to provide information about where (remote)
   and what name (branch name) should be copied there

   -  almost always you should push the same branch name as you have
      locally otherwise you may run into confusing branch names

   .. code:: sh

      $ git push REMOTE_NAME BRANCH_NAME
      # for pushing to origin on master (first push)
      $ git push origin master

-  a local branch can be linked to a remote branch by setting it as the
   “upstream”

   -  this means future pushes don’t need to describe the remote name or
      branch name

      -  and pulling works the same

   -  *THIS IS PER BRANCH (MUST BE DONE FOR EACH NEW BRANCH TO BE
      LINKED)*

   .. code:: sh

      $ git push -u REMOTE_NAME BRANCH_NAME
      # for pushing to origin master and setting the upstream link
      $ git push -u origin master

   -  you can issue this command on any push but it only needs to be
      done once

Pulling
-------

-  pulling the remote history means to reflect the remote history of the
   branch in your local history

   -  one team member can push changes
   -  the other can pull those down
   -  the remote repo serves as the source of truth between the
      collaborators

-  every time you check out an existing branch you should pull it before
   doing any work

   -  this ensures that your local history is always synchronized with
      the remote

   .. code:: sh

      $ git pull REMOTE_NAME BRANCH_NAME
      # or if you have already set the upstream branch linking (see above)
      $ git pull

Merge Requests
--------------

-  merge requests are a way for collaborators to merge branches in a controlled manner

   -  gives an opportunity for code review by other collaborators before
      integrating the changes (merging the histrory)
   -  also an opportunity (through web hooks) to trigger CI/CD behavior

-  every remote repo provider has a naming convention for opening reviewable request to merge one branch into another

   -  GitHub: “open a pull request”
   -  GitLab: “open a merge request”

-  the requested merge can first be reviewed before merging

   -  if changes are requested then they can be made and pushed up for
      further review
   -  when things are proper you can “merge” the branches
   -  after merging make sure to switch to the source branch locally and
      pull the changes to synchronize
   -  you can then delete the feature branch since its history is now
      merged