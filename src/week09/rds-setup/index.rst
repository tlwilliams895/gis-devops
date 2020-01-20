:orphan:

.. _week9-rds-setup:

====================
RDS First Time Setup
====================

We will need to manually setup our RDS. So far throughout this class we have been setting up our database with Hibernate which has been creating our tables for us, and copying data in from our CSVs. We will be doing this manually today, so we don't have to send up two different builds of our project.

Connect to web app EC2
----------------------

Our RDS is only accessible from within the VPC so we will need to SSH into one of our EC2s preferably the one that will house our web-app.

Install postgresql
------------------

In order to use PSQL to access our RDS this EC2 will need to have the postgrescli.

We are working with a linux distribution that uses the aptitude package manager so we can install postgrescli with ``sudo apt-get postgresql postgresql-contrib``. This command will instal postgresql, and postgresql-contrib. Both are necessary to communicate with our RDS.

Connect to RDS
--------------

Now we will need to connect to our RDS using postgresqlcli.

``psql -h [RDS-ENDPOINT] -p 5432 -U [RDS-master-user] -d [RDS-master-database-name]`` should get us in.

Create Users
------------

You will need to create the users for your zika application. Look at your environment variables in IntelliJ. What did we call the user before? Do you have multiple users? Do they have passwords? Should they have passwords?

Create tables
-------------

We have used Hibernate, and an ``import.sql`` file to load the data into our datbase, but now that we are moving to a production environment we don't want our web app to touch the database everytime the app turns off, or on. So we are going to manually setup our database the first time.

This is going to require us to create the tables in our database manually. Look in your local version of PSQL. What tables do we have? What are their columns? What are their data types?

Populate Tables
---------------

After creating the structure of our database, we need to populate it with information. Look at your ``import.sql`` file. It is copying data from CSV files into the database. You will need to replicate these steps from your EC2. In order to do this you will need to copy your CSV files to your EC2. How can you do this?

After copying over the CSV files, you will need to run the statements. Look into the psql terminal -c and -f flags. They will help you in copy data from one EC2 to an RDS.

Test it Out
-----------

After you have run your copy statements psql back into the RDS and perform some select, and count statements to make sure your data exists in the database.