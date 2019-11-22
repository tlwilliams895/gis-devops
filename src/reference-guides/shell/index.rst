Shell Reference
===============

Concepts
--------

-  the shell is a program that runs inside the terminal

   -  it serves as a text-only command line interface (CLI) for
      interacting with the operating system
   -  shells are scripting languages but are most commonly used as a
      command line interpreter
   -  the most common shell language found on operating systems is the
      Bash (``bash``) shell but you may also encounter

      -  ZShell (``zsh``) on OSX
      -  PowerShell on Windows

   -  when the shell program is loaded (by opening a new terminal) it
      behaves in “interactive” mode
   -  interactive mode is the shell language running as a REPL [R(ead)
      E(valuate) P(rint) L(oop)] and is used for interpreting and
      executing commands entered through the terminal

      -  Read: a new line awaits a command
      -  Evaluate: the (bash / zsh) command is then interpreted and
         executed
      -  Print: after the command is issued to the operating system the
         output (if any) is then displayed on the next line
      -  Loop: the program then repeats back to the first step to await
         another command

-  a shell language has its own syntax for performing common OS
   operations and logic

   -  it can be used to write scripts to automate work that would
      otherwise need to be done by hand
   -  it can be used in REPL mode to interact with the operating system
   -  it provides built in commands as well as the ability to use OS
      programs known as the ``coreutils`` (on Linux)

-  there are many CLI tools beyond those included in the coreutils that
   can be installed for performing various actions on the operating
   system

   -  they are written in many different scripting languages like bash,
      python and javascript as well as low level languages like C
   -  most scripts are written in bash since it is the most commonly
      installed shell it is likely that no additional programs (script
      interpreters) need to be installed on the OS to execute the script

-  your local machines have GUI (graphical interfaces) programs that
   allow mouse and keyboard interaction but when working with remote
   servers there is no GUI available

   -  SSH (secure shell) is a protocol for remotely connecting to the
      shell of another machine
   -  most of the work must be done through SSH or shell scripts when
      interacting with remote servers in the cloud ## Basics

-  to open the shell we use a terminal emulator

   -  on OSX you can find this under Applications -> Utilities ->
      Terminal
   -  pin this program to your taskbar as you will be using it a lot!

-  in its simplest form the shell REPL can be described as a tool to
   navigate and interact with the file system of the operating system

   -  unix-based operating systems (Linux and OSX) offer a handful of
      built-in programs (known as the ``coreutils`` on Linux) that can
      be issued in the bash shell for interacting with the file system
   -  the core operations include creating, reading, updating and
      deleting files
   -  all other scripts and CLI programs are simply abstractions over
      these operations to make tedious work as simple as issuing a
      single program command

Practical Usage
---------------

-  when opening the shell you will be presented with the home directory

   -  ``~`` means the home directory (``/Users/username`` on OSX)
   -  your file explorer is simply a GUI that displays directories as
      folders and clicking into / out of a folder is the same as
      navigating into or out of a directory on the command line

-  a path is a file system path to a file or directory (like
   ``/Users/username``)

   -  **relative path**: means the path starting from the current
      directory path

      -  this is known as the “working directory” often abbreviated
         **CWD** for current working directory
      -  the CWD is automatically prefixed to any relative path provided
         (to produce an absolute path)

   -  **absolute path**: means the path starting from the root ``/``
      path

-  **when viewing documentation on CLI usage you will often see the
   following symbols used:**

   -  **the symbols themselves are not part of the command and are only
      used to denote their purpose in the command**
   -  ``$``: denotes the beginning of a command to be entered **on its
      own line**
   -  ``#``: denotes a comment by the author that should not be entered
   -  ``[]``: denotes an optional argument to a CLI program
   -  ``<arg-name>``: denotes a required argument to a CLI program
   -  ``/path/to/file``: denotes a **relative** or **absolute** path to
      the file or directory
   -  ``.ext``: denotes the file extension (``.txt``, ``.js``, ``.sh``
      etc)

-  whenever you see the term or CLI argument ``path`` or ``/path/to``
   used it can mean

   -  enter a **relative path** from the CWD the command is being issued
      from
   -  enter an **absolute path** starting from the root ``/`` directory

-  in unix-based operating systems everything is considered a “file”
   separated into three types

   -  directory files
   -  ordinary files
   -  device files (special files used by the OS) ## Entering Commands

-  entering commands into the shell involve

   -  [required] a program (the first term in the command)
   -  [optional] arguments to the program
   -  [optional] program modifier options or flags

      -  these are prepended with a ``-`` or ``--`` characters
      -  depending on the program they can modify the program behavior
      -  in some cases the flags themselves require arguments for
         further modification
      -  most of the time spaces separate the program from arguments,
         flags and flag-arguments

         -  some programs have their own standards that differ (refer to
            the CLI program documentation)
   -  to learn more about the native unix commands along with their arguments and flags (if present) use this site `Linux Commands <https://ss64.com/bash/>`__ 

.. code:: sh

  $ program <argument> -A --long-flag

  # a command whose flag requires an argument
  $ program <argument> -A <flag argument>
..

Common Commands
---------------

  view the path of the current (working) directory

  this is called the “working directory” because any commands (work) issued will all be made out of this directory

  **it is often referred to as the CWD (current working directory)**

.. code:: sh

  $ pwd
..

  view the files in a directory

  by default any files (ordinary, directories or device files) whose name begins with a ``.`` character are considered “hidden” and won’t be displayed

.. code:: sh

  # list the contents of a directory at a path
  $ ls <path/to/dir>
  # list the contents of the CWD
  $ ls
  # list the contents including hidden files
  $ ls -a
  # list the contents in long format (access mode, type etc)
  $ ls -l
  # combine the "all" and "long" flags together
  $ ls -al
..

  create a file

  there are many ways to create a file but the simplest (and safest)
  to use is ``touch``

.. code:: sh

  $ touch </path/to/file.ext>
  
  # create a file in the CWD
  $ touch <file-name.ext>
..

  create a directory

.. code:: sh

  $ mkdir </path/to/directory/dir-name>

  # make a directory in the CWD
  $ mkdir <dir-name>
  
  # make a directory called "my-dir" in home (~) directory
  $ mkdir ~/my-dir
..

  display (print) the contents of a file

  the simplest is ``cat`` which is technically used for concatenating but can also be used to display contents
  
  the downside is if the file is large its entire contents are dumped to the output which can be a pain to deal with

.. code:: sh

  $ cat </path/to/file.ext>
  
  # print a file in the CWD
  $ cat <file.ext>
..

  use ``less`` to print the contents “one page at a time”

  you can “scroll” with your mouse wheel or by using the ``J`` (scroll down) or ``K`` (scroll up) keys and exit using the ``Q`` key

.. code:: sh

    $ less </path/to/file.ext>
    
    # print a file in the CWD
    $ less <file.ext>
..

  print a string

  use the ``echo`` or ``printf`` command (``printf``, print format, is more widely supported across unix OSs)

.. code:: sh

  $ echo "something in this string"

  # using \n and \t
  $ printf "something here\nthis part is on a new line\tthis one starts with a tab character"

  # using substitution
  $ printf "something %s" "goes here"
  # produces: "something goes here" output
..

  copy a file or directory from a source path to a target path

.. code:: sh

  $ cp </path/to/source> </path/to/target>

  #copy a directory use the -r (recursive) flag
  $ cp -r </path/to/source> </path/to/target>

  # copy from somewhere else to CWD
  $ cp </path/to/source> .
..

  move a file
  
  if the target (last part of path) does not exist it will be
  created

.. code:: sh

  $ mv </path/to/source> </path/to/target>
  
  # copy from somewhere else to CWD
  $ mv </path/to/source> .
..

  delete a file or directory

  **WARNING THIS IS IRREVERSIBLE**: DO NOT USE THIS COMMAND LIGHTLY

.. code:: sh

  $ rm </path/to/file.ext>
  $ rm <path/to/dir>
  
  # remove from the CWD
  $ rm <file.ext>
  $ rm <dir-name>
..

  remove non-empty directory requires “recursing” through the directory and deleting all of its sub files

  **WARNING THIS IS IRREVERSIBLE**
  
  **DO NOT USE THIS COMMAND UNLESS YOU KNOW EXACTLY WHAT YOU ARE DOING**

.. code:: sh

    # presents a dialog for every sub-file before it is deleted
    $ rm -r <path/to/dir>
    
    # skips the dialog by "forcing" the removal
    $ rm -rf <path/to/dir>
    
    # if you are blocked by a permission error you likely should not be deleting the chosen file(s) and must gain super user permissions to do so
..

Learn More
----------

-  there are a heap of other commands and operators that can be used

   -  you can also combine multiple commands (using the output of one as
      the input to another)
   -  in particular you may want to learn about the following:

      -  redirection operator: ``>``
      -  append operator: ``>>``
      -  pipe operator: ``|``
      -  grep (search for terms in a file or output): ``grep``
      -  ``awk`` and ``sed`` powerful languages for text processing
         (find / replace etc)

-  check out the following resources to learn more

   -  `Bash scripting cheatsheet <https://devhints.io/bash#miscellaneous>`__
   -  `Linux Cheat Sheet Commands <https://linoxide.com/linux-command/linux-commands-cheat-sheet/>`__
   -  `What are the shell’s control and redirection operators? <https://unix.stackexchange.com/questions/159513/what-are-the-shells-control-and-redirection-operators>`__
