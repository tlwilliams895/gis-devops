:orphan:

=======
Tooling Installation & Configuration
=======

Before we begin learning we have to establish a common technological ground across all our machines. It’s important for everyone to have **parity** across machines so that nobody is left behind or delayed by inconsistent behaviors during lectures and project building.

In these instructions we will install and configure the following tools. Note that some of these tools will not be used until later in the course. But they are important to install, configure, and test against so that any incompatibilities can be discovered and resolved sooner rather than later.

Tools of the Trade
-----

- **JDK 8: the Java Development Kit (version 8) includes all of the tools we need to write and execute Java code on our machine**

  - The Java standard library, debugger and compiler for writing Java code known as the "development kit"
  - The JRE (Java Runtime Environment) is the set of tools we need to actually execute Java after it’s been compiled
  - The JVM (Java Virtual Machine) is the “write once, run anywhere” tool that actually executes the byte code that Java gets compiled to

- **JetBrains IntelliJ IDEA: the IDE (Integrated Development Environment) we will use to write Java code**
  
  - An IDE differs from a TE (text editor) in that it includes many additional tools and features
  - Every IDE is designed for development in a specific language (sometimes with additional, but often limited, support for multiple languages)
  - IDEs are “heavier” in consuming resources (CPU/RAM) because they have to support so many more features
  - In exchange for the higher consumption they are better at handling large code bases, have integrated debugging, and other conveniences 

- **Visual Studio Code: the TE (text/code editor) we will use to write client-side code like HTML, CSS and JavaScript**
  
  - It installs as a lightweight text editor but through free extensions can be customized to rival the capabilities of a full-blown IDE (without any bloat from unused features)
  - It shines as a code editor for working with JavaScript due to the large community of JavaScript developers that use and develop extensions for it
  - Interesting bit: VSC is actually written in JavaScript using a framework called Electron!

- **Docker For Mac: a set of tools for working with Docker containers**

  - Docker Machine: a Linux virtual machine that runs the Docker Engine
  - Docker Engine: the CLI tool used to provision and manage Docker containers running on a Docker Machine

- **Node[JS]: Node is a JavaScript runtime for executing JavaScript outside of the browser**

  - Node is a CLI tool that we can use to execute JavaScript code or as a REPL shell (like the Bash or Python shell)
  - It is considered “headless” in that it runs outside of the browser 
  - It shares all of the JavaScript standard library besides those APIs that are browser based (like ``window`` and ``document``) while adding some that would not be accessible by the browser (like ``http`` and ``fs`` for file system access)
  - It comes with the Node Package Manager (NPM) which we will use to search and install packages (libraries and frameworks) for JavaScript

- **Python 3.7: the latest version of Python**

  - OSX comes pre-installed with a system version of Python 2.7
  - For some examples in this course we will be using modern Python libraries that require a 3.x version to execute
  - We will install the latest (3.7) version of Python alongside the system version so they can both be used for their respective cases

- **PostgreSQL: A database management system (DBMS) for relational data**

  - Includes the core DBMS and the ``psql`` CLI tool
  - The ``psql`` CLI tool allows us to connect to and manage databases using its SQL shell interface
  - It can also be used to execute SQL commands directly from the command line

Installing JDK 8
----------

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
  - **Note:** the ``$`` is a common symbol used in documentation to denote a command entered into the terminal (command line program)
  - The actual command to enter is what comes after the ``$`` character

.. code-block:: bash

  $ which java
..

  should output: ``/usr/bin/java``

.. code-block:: bash

  $ java -version
..

  should output: ``java version "1.8.X" (X can be anything)``

Installing IntelliJ
----------

- Installs the Intellij IDEA CE (Community Edition) Java IDE
- `Download the installer <https://www.jetbrains.com/idea/download/#section=mac>`_
- Open (double click) the ``.dmg`` file
- Drag the Intellij IDEA icon into your Applications folder
- Go to your desktop and right click the disk image of the installer to remove it

  - You can discard the ``.dmg`` file at this point

- Confirm the installation was successful by opening the Intellij IDEA app

  - You can find it under Finder (file explorer) > Applications > Intellij IDEA CE
  - Once opened right click the icon in your dock and select ``options > keep in dock`` for easy access later 
