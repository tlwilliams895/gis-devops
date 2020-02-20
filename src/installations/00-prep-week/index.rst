.. 
  TODO: slack, firefox, google accounts for sheets and forms
  VSCode extensions / auto save / other configs
  IntelliJ plugins / config

:orphan:

.. _installation_tooling:

===============================================
Installation: Essential Tooling & Configuration
===============================================

Before we begin learning we have to establish a common technological ground across all our machines. It’s important for everyone to have **parity** across machines so that nobody is left behind or delayed by inconsistent behaviors during lectures and project building.

In these instructions we will install and configure the many different tools used throughout the course. Most of these tools will not be used until several weeks from now. But they are important to install, configure, and test so that any incompatibilities can be discovered and resolved sooner rather than later.

Do not worry about feeling overwhelmed during these steps. Take your time and follow the directions step-by-step as your instructor guides you. Do not be embarassed to ask questions at any time if you are confused or want more information. 

.. 
  TODO: reconsider this - let students choose to do on their own or with guidance?

  **Do not skip ahead or rush on any section or step**

  Rushing will likely result in mistakes that delay the entire class

  Follow the instructor as they go through each installation and configuration

You will be exposed to a lot of new technologies and techniques during this process. You do not need to memorize or fully understand what is being done (but there are a lot of notes and comments for those that do). We will be exploring these tools in greater detail later when they are used in the course. By going through the process early you will be prepared to focus on learning rather than configuring and debugging.

Tools of the Trade
------------------

Below you will find a brief overview of each of the tools. Exploring these technologies from a high level will build a foundation for understanding them later in the course when they are used.

- **HomeBrew: a package manager for OSX (Mac) developer tools**
  
  - Installing system-wide tools is often a tedious process of downloading, unpacking, installing and configuring
  - HomeBrew makes this process easy and consistent for nearly all packages that you would need on your Mac
  - If you are familiar with Linux this is similar to the ``yum`` (RedHat based), ``apt/apt-get`` (Debian based) or ``pacman`` (Arch based) package managers

- **PostgreSQL: A database management system (DBMS) for relational data**

  - Includes the core DBMS and the ``psql`` CLI tool
  - The ``psql`` CLI tool allows us to connect to and manage databases using its SQL REPL interface
  - It can also be used to execute SQL commands directly from the command line

- **Python 3.X: the latest version of Python**

  - OSX comes pre-installed with a system version of Python 2.7 (2.X) that it uses for internal operations
  - Python 2 is a legacy version of Python that was replaced by Python 3
  - For the examples in this course we will be using modern Python libraries that require a 3.x version to execute
  - We will install the latest (3.X) version of Python alongside the system version so they can both be used for their respective cases

- **Docker For Mac: a set of tools for working with Docker containers**

  - Docker Machine: a Linux virtual machine that runs the Docker Engine
  - Docker Engine: the program used to provision and manage Docker containers running on a Docker Machine
  - Docker CLI: the command line program used issue commands to the Docker Engine

- **JDK 8: the Java Development Kit (version 8) includes all of the tools we need to write and execute Java code on our machine**

  - The Java standard library, debugger and compiler for writing Java code known as the "development kit"
  - The JRE (Java Runtime Environment) is the set of tools we need to actually execute Java after it’s been compiled
  - The JVM (Java Virtual Machine) is the “write once, run anywhere” tool that actually executes the byte code that Java gets compiled to

- **JetBrains IntelliJ IDEA: the IDE (Integrated Development Environment) we will use to write Java code**
  
  - An IDE differs from a TE (text editor) in that it includes many additional tools and features
  - Every IDE is designed for development in a specific language (sometimes with additional, but often limited, support for multiple languages)
  - IDEs are “heavier” in consuming resources (CPU/RAM) because they have to support so many more features
  - In exchange for the higher consumption they are better at handling large code bases, have integrated debugging, and other conveniences 

- **Node[JS]: Node is a JavaScript runtime for executing JavaScript outside of the browser**

  - Node is a runtime that includes a CLI tool we can use to execute JavaScript code or as a REPL shell (like the Bash or Python shell)
  - It is considered “headless” in that it runs outside of the browser 
  - It shares all of the JavaScript standard library besides those APIs that are browser based (like ``window`` and ``document``) while adding some that would not be accessible by the browser (like ``http`` and ``fs`` for file system access)
  - It comes with the Node Package Manager (NPM) which we will use to search and install packages (libraries and frameworks) for JavaScript

- **Visual Studio Code: the TE (text/code editor) we will use to write client-side code like HTML, CSS and JavaScript**
  
  - A lightweight text / code editor
  - Using free extensions it can be customized to rival the capabilities of a full-blown IDE (without any bloat from unused features)
  - It shines as a code editor for working with JavaScript due to the large community of JavaScript developers that use and develop extensions for it
  - *Interesting bit: VSC is actually written in JavaScript using a cross-platoform desktop framework called Electron!*

Installing HomeBrew
-------------------

- Installing HomeBrew is as easy as using it
- Enter the following command in your ``Terminal`` then accept all defaults while following the instructions

.. code-block:: bash

  $ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
..

- Confirm the installation was successful by entering

.. code-block:: bash

  $ brew --version

  # expect the following output (2.X.X, minor versions and commits are arbitrary)
  Homebrew 2.1.15
  Homebrew/homebrew-core (git revision 66ea9; last commit 2019-10-22)
  Homebrew/homebrew-cask (git revision 43442; last commit 2019-10-23)
..

.. 
  TODO: remove - using docker

.. _postgres:

Installing PostgreSQL
---------------------

- Now that we have installed HomeBrew the installation of PostgreSQL will be a breeze
- Enter the following into your ``Terminal``

.. code-block:: bash

  $ brew install postgresql
..

- Confirm the installation was successful by entering

.. code-block:: bash

  $ which psql

  # should output the following path
  /usr/local/bin/psql

  $ psql --version

  # should output the following, the versions may be different
  psql (PostgreSQL) 10.1
..

Installing Python 3.X
---------------------

- We will install the 3.X version of Python using HomeBrew as well
- Enter the following command in your ``Terminal``

.. code-block:: bash

  $ brew install python
..

- Enter the following commands in your ``Terminal`` to confirm the installation was successful

.. code-block:: bash

  $ which python

  # should output
  /usr/local/bin/python3
..

Installing Docker for Mac
-------------------------

- First you need to create a Docker Hub account (like GitHub but for Docker)

  - `Sign up for Docker Hub <https://hub.docker.com/signup>`_

- Next `install Docker for Mac <https://hub.docker.com/?overlay=onboarding>`_ and follow the instructional walkthrough
- Go to your desktop and right click the disk image of the installer to remove it

  - You can discard the ``.dmg`` file at this point

- Confirm the installation was successful by opening the Docker app

  - You can find it under Finder (file explorer) > Applications > Docker or through Spotlight

- When Docker is first opened you will have to do some initial configuration

  - On the ``Docker Desktop needs privileged access`` prompt select ``OK`` and enter your password
  - Next enter your Docker Hub credentials to log in

- Now select the Docker icon in your status bar

  - Click ``Preferences``
  - Click the ``Advanced`` tab
  - for ``CPUs`` ensure at least ``3`` cores are allocated
  - for ``Memory`` ensure at least ``5GiB`` are allocated
  - for ``Swap`` ensure at least ``1 GiB`` are allocated 

- Confirm that Docker is available on your machine by entering the following command in your ``Terminal``

.. code-block:: bash

  $ docker --version

  # expect the following output, the minor and build details are arbitrary
  Docker version 19.XX.X, build X
..

Installing JDK 8
----------------

- Download the `JDK 8 installer from Oracle <https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html>`_
  
  - Select the Mac OSX x64 version (about halfway down the list)

- Open (double click) the ``.dmg`` file to display the installer application
- Open (double click) the ``.pkg`` icon that appears to run the installer
  
  - Follow all instructions during installation and accept all the defaults
  - If you are confused at any point call over your instructor or refer to the `JDK 8 Installation for OS X documentation <https://docs.oracle.com/javase/8/docs/technotes/guides/install/mac_jdk.html>`_

- Go to your desktop and right click the disk image of the installer to unmount it
  
  - You can also discard the ``.dmg`` file from your downloads folder at this point

- Open your terminal application
  
  - This can be found from the Finder (file explorer) > Applications > Utilities > Terminal
  - Or by pulling up Spotlight using the hotkey ``CMD+SPACE`` and searching for ``Terminal``
  - Once opened in your dock right click the icon and select ``options > keep`` in dock for easy access later

- Enter the following commands to confirm the installation was successful
  
  - If your outputs do not match the expected outputs call over your instructor so they can sort you out
  
..

  **Note:** the ``$`` is a common symbol used in documentation to denote a command entered into the terminal (command line instruction)
  
  The actual command to enter is what comes after the ``$`` character

  Each line that begins with a ``$`` denotes a single (distinct) command to enter

  Lines beginning with ``#`` are comments

  Lines beginning with neither ``$`` nor ``#`` are outputs from the previous command


.. code-block:: bash

  $ which java

  # should output the following
  /usr/bin/java
..


.. code-block:: bash

  $ java -version

  # expect the following output, the minor version is arbitrary
  java version "1.8.X"
..

Installing IntelliJ
-------------------

- Installs the Intellij IDEA CE (Community Edition) Java IDE
- `Download the IntelliJ installer <https://www.jetbrains.com/idea/download/#section=mac>`_
- Open (double click) the ``.dmg`` file
- Drag the Intellij IDEA icon into your Applications folder
- Go to your desktop and right click the disk image of the installer to remove it

  - You can discard the ``.dmg`` file at this point

- Confirm the installation was successful by opening the Intellij IDEA app

  - You can find it under Finder (file explorer) > Applications > Intellij IDEA CE
  - Once opened right click the icon in your dock and select ``options > keep in dock`` for easy access later 

Installing NodeJS
-----------------

- NodeJS can be installed directly or through a tool called NVM
- NVM (Node Version Manager) is a virtual environment manager for NodeJS
- We will use NVM rather than the direct install for a cleaner management of globally installed packages (packages that are available system-wide)
- Before installing NVM we have to confirm or create our shell profile files.

  - These are known as "shell profile configuration files"
  - We will explore these files in greater detail later in the course
  - For now we just need to ensure that they exist as NVM utilizes them during its installation and configuration process

- In your ``Terminal`` enter the following commands:

.. code-block:: bash

  # echo is a command used to "echo" or print out a string to the console
  # $SHELL is an environment variable in your system that holds the path to your active shell program
  # here we are saying "print out the path to my active shell"

  $ echo $SHELL

  # should output
  /bin/bash
..
  
  If it outputs ``/bin/zsh`` then you are using the ZShell
  
  You can follow the same steps but replace anything that says ``bash`` with ``zsh``

  Now enter the following command:

.. code-block:: bash

  # the cat command can be used to display the contents of a file
  
  # if the file is empty you will see a blank output
  # if the file has contents you will see them as the output
  # if the file doesn't exist you will receive an error output

  # this command will display the contents of the .bashrc file in your home (~) directory

  # if you are on ZShell enter cat ~/.zshrc
  $ cat ~/.bashrc
..

  if you do not receive an error then the file exists and you can skip the next step
  
  if you get the following output: ``cat: .bashrc: No such file or directory`` then enter the following command:

.. code-block:: bash

  # touch is a command used to create new files
  # this command will create the .bashrc file in your home (~) directory

  # if you are on ZShell enter touch ~/.zshrc
  $ touch ~/.bashrc
..

  reissue the previous ``cat`` command to confirm it was created.
  
  you can press the up arrow in your terminal to find a previously entered command. 
  
  you will receive a blank output since the file was just created
  
  if you receive an error ask your instructor to sort you out

- Now we have confirmed or created the file needed for the NVM installation
- Enter the following command into your ``Terminal`` to download and run the NVM installer

.. code-block:: bash

  # curl is a CLI tool for making network requests
  # here it is used to download the installer script
  # the script is then piped (|) to the bash interpreter for execution

  $ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash
..

- Confirm that the installation and configuration were succesful

  - In your ``Terminal`` enter the following command

.. code-block:: bash
  
  $ nvm --version

  # expect the following output, the version may be different
  0.35.0
..

  If you receive an error call over your instructor to sort you out

- Next we will install the NodeJS version we will be using in this course and setting it as our default system version

  - Enter the following command in your ``Terminal``

.. code-block:: bash
  
  # the --lts flag instructs NVM to install the latest long term support version

  $ nvm install --lts

  # expect the following output, the versions may change as the LTS version changes

  Installing latest LTS version.
  Downloading and installing node v12.13.0...
  Downloading https://nodejs.org/dist/v12.13.0/node-v12.13.0-darwin-x64.tar.xz...
  ######################################################################## 100.0%
  Computing checksum with shasum -a 256
  Checksums matched!
  Now using node v12.13.0 (npm v6.12.0)
..

- You can now confirm that both ``node`` and ``npm`` are working by checking their versions

  - Enter the following commands in your ``Terminal``

.. code-block:: bash

  $ node --version

  # expect the following output, the version is arbitrary and may change as LTS version changes
  v12.13.0
..

.. code-block:: bash

  $ npm --version

  # expect the following output, the version is arbitrary and depends on the current Node LTS 
  6.12.0
..

Installing VSCode
-----------------

- Installs the VSC (Visual Studio Code) text/code editor
- `Download the VSC installer <https://code.visualstudio.com/docs/setup/mac>`_
- Open (double click) the ``.dmg`` file
- Drag the Visual Studio Code icon into your Applications folder
- Go to your desktop and right click the disk image of the installer to remove it

  - You can discard the ``.dmg`` file at this point

- Confirm the installation was successful by opening the VSC app

  - You can find it under Finder (file explorer) > Applications > Code
  - Once opened right click the icon in your dock and select ``options > keep in dock`` for easy access later 

Congratulations!
----------------

You made it through the installation and configuration. Most of the tedious and frustrating aspects of the course are now behind you. From this point forward you can focus on learning how to use these technologies to build solutions instead of tearing your hair out! 
