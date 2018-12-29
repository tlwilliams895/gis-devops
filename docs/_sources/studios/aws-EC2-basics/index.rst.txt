:orphan:

.. _aws-EC2-basics-studio:

=========================
Studio: AWS Devops Basics
=========================
x

Overview
========

Your goal is to deploy a Spring Boot project to a remote server and verify its execution. This will establish the basics for working in a cloud environment.

Set Up Project
==============

* Build your latest branch of Airwaze Studio project https://gitlab.com/LaunchCodeTraining/airwaze-studio or check out and build the ``elasticsearch-starter`` branch.
* Change ``src/main/resources/import.sql`` to:

::

  COPY route(src, src_id, dst, dst_id, airline, route_geom) from '/home/airwaze/routes.csv' DELIMITER ',' CSV HEADER;
  COPY airport(airport_id, name, city, country, faa_code, icao, altitude, time_zone, airport_lat_long) from '/home/airwaze/Airports.csv' DELIMITER ',' CSV HEADER;

* Go into IntelliJ's Gradle tool window, and click on ``Tasks > build > bootRepackage``
* Verify the jar appears here ``/YOUR-AIRWAZE-REPO/build/libs/app-0.0.1-SNAPSHOT.jar``
* We are going to deploy the ``.jar`` file to a cloud server

.. note::

  The file name ``app-0.0.1-SNAPSHOT.jar`` comes from the ``jar`` property in ``build.gradle``.

Start an Instance on AWS
========================

1. Go and login to the aws console login link for this class.

   * The aws console link should look like this https://123456.signin.aws.amazon.com/console
   * The numbers at the front will be different for every user

2. Make sure you are using the **N. Virginia** region. Your currently selected region shows up in the top right.

Screen shot of AWS console with arrow pointing to Region menu

  .. image:: /_static/images/aws-region.png
     :alt: Screen shot of AWS console with arrow pointing to Region menu

3. Go to the EC2 Dashboard:
    * Click on ``Services`` in the page header.
    * Locate and click on ``EC2`` under **Compute**.

Screen shot of AWS console with a red arrow pointing to the EC2 link in the Services dropdown

  .. image:: /_static/images/ec2-in-services.png
     :alt: Screen shot of AWS console with a red arrow pointing to the EC2 link in the Services dropdown

4. On the EC2 Dashboard
    * Locate and click the ``Instances`` link in the sidebar

Screen shot of AWS console with a red arrow pointing to the Instances link in the sidebar

  .. image:: /_static/images/instances-in-sidebar.png
     :alt: Screen shot of AWS console with a red arrow pointing to the Instances link in the sidebar

5. On the Instances screen
    - Locate and click the ``Launch Instance`` button at the top of the page

Screen shot of AWS console with a red circle around the Launch Instance button

  .. image:: /_static/images/launch-instance-button.png
     :alt: Screen shot of AWS console with a red circle around the Launch Instance button

Starting an AWS Instance
========================

When creating a new instance, Amazon provides multiple free **Amazon Machine Images** (AMIs) to choose from. This is a pre-configured operating system installation with multiple tools ready for use. For this exercise, we want to use the **Ubuntu Server 16.04 LTS** AMI. Locate it in the list of "Quick Start" images and click its ``Select`` button.

Screen shot showing Ubuntu Server selection in AMI screen

  .. image:: /_static/images/ubuntu-server-ami.png
     :alt: Screen shot showing Ubuntu Server selection in AMI screen

Instace Details
---------------

Next, the console will ask which type of instance to set up. Your choice here defines the amount of virtual CPU cores, RAM, and network perforance you want. This also directly affects the cost of the running instance. Select the ``t2.micro`` service, then click **Configure Instance Details**.

Screen show with t2.micro selected and red circle highlighting the selection

  .. image:: /_static/images/t2-micro-instance.png
     :alt: Screen show with t2.micro selected and red circle highlighting the selection

Next, click **Configure Instance Details**

* We aren't going to change anything on this page now
* However, please take a quick look at the properties that you can change on this page

  .. image:: /_static/images/click-configure-instance-details.png

Next, click **Add Storage**

  .. image:: /_static/images/click-add-storage.png

Storage
-------

On this screen, you can choose what storage is available to your instance. AWS will provision a virtual volume in Elastic Block Store to serve as the volume(s) mounted in your instance. By default, it will create an 8 GiB volume to serve as the instance's root volume.

* The default 8 GiB volume is sufficient for this application.
* Click on **Add Tags** to progress to the next step.

Screen shot showing pre-filled 8 GiB storage selection

  .. image:: /_static/images/storage-options.png
     :alt: Screen shot showing pre-filled 8 GiB storage selection

Add Tags
--------

The **Add Tags** screen is helpful to "name" our ec2 instance. Since lots of us are going to be creating instances, please click **Add Tag** add a ``Name`` tag with a value of something unique and relevant to you, example ``blakes-ec2-walkthrough``.

Screen shot demonstrating an empty Add Tags screen and the Add Tag button

  .. image:: /_static/images/add-tags-screen-v3.png
     :alt: Screen shot demonstrating an empty Add Tags screen and the Add Tag button

Next click **Configure Security Group**

  .. image:: /_static/images/click-configure-security-group.png
     :alt: Screen shot showing arrow pointing to button "Next: Configure Security Group"

Security Groups
---------------

The Security Group controls network traffic in and out of the server you are creating. You can create rules for different kinds of traffic on different ports. Examples: ``SSH``, ``HTTP``, ``port 8080``.

Configuring the security groups for your server is critical for protecting your instance from unauthorized remote access. 
The organization or indiviaul who created the AWS account is liable for the costs generated by any instances that are setup, in this case LaunchCode is that origanization. 
An openly-accessible instance can risk your infrastructure security and accumulate great costs to your organization if it were to be compromised.

1. Create a new security group for your instance with a unique name
2. Add a useful description for the security group so you know its purpose in the future
3. Change the existing rule's source to **My IP**

   * This allows remote ``SSH`` access to your instance, but only from the **IP you're currently using** to access AWS
   * NOTE: This is your IP at the time of configuration. Later on if your IP changes for some reason you will NOT be able to login until you adjust the security group to look for your new IP.
   * This configuration only applies to servers that use this Security Group

Screen shot showing Create Security Group page with My IP circled in red to highlight the selection

  .. image:: /_static/images/security-group-setup.png
     :alt: Screen shot showing Create Security Group page with My IP circled in red to highlight the selection

Next click **Review and Launch** button in the bottom right

Review Screen
-------------

This screen gives you a final chance to review and change the settings you chose for this instance.

* Each section is collapsable and expandle by clicking on the section Title
* When you're done reviewing, click **Launch**

Setting up a KeyPair
--------------------

This will open a popup on the screen that allows you to configure a key pair for the instance. This will generate the key necessary to SSH into the instance and without this you will not be able to access your instance. 
In an enterprise environment, there will likely already be multiple key pairs set up that you would use here. For the purpose of this project, create a new key pair:

* Select **Create a new key pair** in the first select box
* Give your key pair a good name, possibly the same name you gave your security group
* Click **Download Key Pair**
* Choose **Save File** to your computer
* Store this ``*.pem`` file in a good location and do not lose it. A suggestion is to put them in ``~/.ssh`` folder.
  
  * You can move your newly downloaded file there by running:
  * ``mv ~/Downloads/your-keypair.pem ~/.ssh``

* Click **Launch Instances**

Your Instance Details
---------------------

AWS will now begin launching your instance. After Launching your instance will be availabe in the list of EC2 Instances. You can click the identifier for your instance to monitor it as it starts up. This will take you back to the Instances dashboard. In the **Description** tab of your instance you can see important properties such as ``public DNS``, ``IP``, ``running state``, ``instance type``, ``links to security group(s)``, ``key pair``, etc.

Screen shot showing Instances dashboard and a running instance. A red circle is around the Public DNS entry.

  .. image:: /_static/images/instances-dashboard-launching.png
     :alt: Screen shot showing Instances dashboard and a running instance. A red circle is around the Public DNS entr

Configure and Setup Airwaze Application on Cloud Server
=======================================================

At this point we have created a server in the cloud, but at this point it's just a server. We haven't deployed our application to it yet. In the next steps we will deploy the Airwaze application to our new server.

Set up SSH
----------

* Open the terminal.
* Navigate to your user's ssh configuration folder:::

  $ cd ~/.ssh

* Copy your instance's \*.pem file to your .ssh folder(If you haven't already):::

  $ cp /path/to/*.pem .

* Change the permissions for this file to read-only by your user:::

  $ chmod 400 name-of-pem.pem

* Using the Public DNS you noted before and your \*.pem file, access your AWS instance:::

  $ ssh -i ~/.ssh/name-of-pem.pem ubuntu@PUBLID-DNS-OF-SERVER-HERE

.. note::

  Note the ``ubuntu`` part of the above command is the user/role you are attempting to connect with on the remote computer.

* The ssh program will likely warn that the authenticity of your host can't be established since it's not seen it before. Respond "yes" to continue connecting. It will add it to the list of known hosts and continue the connection process.
* The remote terminal will appear

Screen shot of terminal showing successful SSH connection to AWS instance

  .. image:: /_static/images/ssh-to-instance.png
     :alt: Screen shot of terminal showing successful SSH connection to AWS instance

Congratulations! You have successfully created and connected to an instance running in the cloud.

Setup Linux Server to Run the App
---------------------------------

Now that you have a server running in the cloud, you need to use it to do some work. Let's prepare the server to run our application.

Create Application User
-----------------------

First, you don't want the application running under your system account, so we need to create a new user:::

  (On remote server)
  ubuntu$ sudo adduser --system airwaze


Secure Copy Files to Server
---------------------------

* Leave your ``ssh`` session open and open a new terminal prompt for **your local machine**
* You can do this by hitting keys ``Command + T`` while in your terminal
* We are going to upload our app jar file and the two csv files to the server
* We'll use ``scp`` to securely transmit the file to our server

::

  (On local computer, NOT in ssh session)
  $ scp -i ~/.ssh/name-of-pem.pem /path/to/local/app.jar ubuntu@ec2-public-dns.us-east-2.compute.amazonaws.com:/home/ubuntu/app.jar
  $ scp -i ~/.ssh/name-of-pem.pem /path/to/local/*.csv ubuntu@ec2-public-dns.us-east-2.compute.amazonaws.com:/home/ubuntu/routes.csv





Ubuntu Doesn't Have Everything We Need?
---------------------------------------

The remotes servers will not come with everything we need already isntalled. However it does come with a tool that makes it easy to install software.
`apt-get <https://help.ubuntu.com/community/AptGet/Howto>`_ is the "Package Manager" that comes with Ubuntu. We will use it to install the JDK and other tools we need.

Install JDK on Server
---------------------

We need Java to run our app, we will install it using ``apt-get``::

  (On remote server)
  ubuntu$ sudo apt-get update
  ubuntu$ sudo apt-get install openjdk-8-jdk
  ubuntu$ java -version

Copy Files to App User Folder
-----------------------------

Now, on the server, move the file to the airwaze home directory, and make it owned and executable by that user. Notice the changes in ``ls -l`` after the owner and permissions calls are made.::

  (On remote server)
  ubuntu$ sudo mv ~/app.jar /home/airwaze/app.jar
  ubuntu$ sudo mv ~/*.csv /home/airwaze
  ubuntu$ cd /home/airwaze
  ubuntu$ ls -l
  ubuntu$ sudo chmod 500 /home/airwaze/app.jar
  ubuntu$ ls -l

Now the airwaze user can execute app.jar.::

  -rw-r--r-- 1 airwaze airwaze   881432 May 20 01:23 Airports.csv
  -r-x------ 1 airwaze airwaze 46309179 May 20 01:22 app.jar
  -rw-r--r-- 1 airwaze airwaze  6464492 May 20 01:23 routes.csv

Install Postgis
---------------

Before trying to start the application, we'll install ``postgres`` locally so we can start Airwaze Studio. 
Normally you would install the database on it's own server. Installing the database on the same cloud server ** is something you would *never* do in a real cloud instance**. 
We are doing it here to get practice working with cloud servers, we will learn how to use postgresql differently later this week.::

  (On remote server)
  $ sudo apt-get update
  $ sudo apt-get install postgresql postgresql-contrib postgis
  
Edit Postgresql Config File
---------------------------

::

  (on remote server)
  ubuntu$ psql -U postgres

* The above should throw an error like ``psql: FATAL:  Peer authentication failed for user "postgres"``
* We need to edit a postgresql config file. You can do that in ``nano`` or ``vi``

::

  (On remote server)
  ubuntu$ sudo nano /etc/postgresql/9.5/main/pg_hba.conf

* In the configuration filr, you'll see that almost all of the lines are commented out with ``#``
* Find the section that matches the text in the red box
* Change the text ``peer`` to be ``md5``. Be careful to change the correct line
* Save your changes to the file

.. image:: /_static/images/edit-psql-hba-conf.png 

::
  
  (Section in red box shoud look like this after editing it)
  # "local" is for Unix domain socket connections only
  local   all             all                                     md5

Now Create User and Database
-------------------------------------

::

  (on remote server)
  (restart postgresql)
  ubuntu$ sudo /etc/init.d/postgresql restart

  (when prompted provide password of your choice, but be sure to remember it)
  ubuntu$ sudo -u postgres createuser --pwprompt --superuser airwaze_db_user

  (now open a psql# shell)
  ubuntu$ psql -U airwaze_db_user -d postgres
  postgres=# CREATE DATABASE airwaze;
  
  (install postgis extensions in airwaze database)
  postgres=# \c airwaze;
  airwaze=# CREATE EXTENSION postgis;
  airwaze=# CREATE EXTENSION postgis_topology;
  airwaze=# CREATE EXTENSION fuzzystrmatch;
  airwaze=# CREATE EXTENSION postgis_tiger_geocoder;

Setup Service for App
---------------------

Now that the app is on the cloud server and the database is ready, we can set up ``systemd`` to run this app as a service.

In order to use ``systemd``, we have to make a script in ``/etc/systemd/system`` to tell the service how to run our app.::

  (On remote server)
  ubuntu$ sudo vim /etc/systemd/system/airwaze.service

Press ``i`` to start inserting text into the file and paste the following:::

  [Unit]
  Description=Airwaze Studio
  After=syslog.target

  [Service]
  User=airwaze
  ExecStart=/usr/bin/java -jar /home/airwaze/app.jar SuccessExitStatus=143
  Restart=always

  [Install]
  WantedBy=multi-user.target

Once this service definition is in place, set the service to start automatically on boot with systemd using the ``systemctl`` utility and also start now::

  (On remote server)
  ubuntu$ sudo systemctl enable airwaze
  ubuntu$ sudo systemctl start airwaze

And you can view the logs for the service with ``journalctl``.::

  (On remote server)
  ubuntu$ journalctl -f -u airwaze.service


Configure Security Group
------------------------

Now that your application is running, open up a new port in our Security Group from before to allow for web communications.

* Return to the AWS web console
* Click ``Security Groups`` in the sidebar

Screen shot of the AWS sidebar with a red circle around Security Groups

  .. image:: /_static/images/security-groups-list.png
     :alt: Screen shot of the AWS sidebar with a red circle around Security Groups

* Select the security group with the name you used before

Screen shot of the security group list with the demonstration security group selected

  .. image:: /_static/images/select-your-security-group.png
     :alt: Screen shot of the security group list with the demonstration security group selected

* Click the ``Inbound`` tab and ``Edit`` the inbound traffic list

Screen shot of the security group settings with a red circle around the selected Inbound tab

  .. image:: /_static/images/security-group-inbound-tab.png

* Add a new ``Custom TCP`` rule for port 8080 and select ``My IP`` for the source

Screen shot of Edit inbound rules display with a new rule of 8080 to "My IP" added with red circles around the 8080 port and "My IP"

  .. image:: /_static/images/add-web-to-security-group.png
     :alt: Screen shot of Edit inbound rules display with a new rule of 8080 to "My IP" added with red circles around the 8080 port and "My IP"

* Click ``Save``. This opens up a new port in the Security Group just for your IP. The Airwaze app is set up to listen to port 8080 and communicating with that port from your browser will allow you to communicate with the application.

* Open your browser
* Go to your server on port 8080:

  * http://ec2-public-dns.us-east-2.compute.amazonaws.com:8080


If you kept ``journalctl`` running from before, you should see the logs progress as your browser communicates with the app.

Congratulations! You now have your own application in the cloud!

Next Steps
==========

Your map is currently showing up on the screen; however, the map is not showing any airports.  Troubleshoot the application and figure out why the airports are not showing up.  Be sure to use your browser's developer tools.

When you have found the problem, build a new copy of your jar and deploy it on your server.

Bonus Mission
=============

* Use Environment Variables to dynamically change the port that your application is served on.

* Using the instructions above, deploy another one of your SpringBoot application to AWS.  Consider using the LaunchCart Project https://gitlab.com/LaunchCodeTraining/launchcart/tree/rest-studio.
