:orphan:

.. _week9-aws-infrastructure:

========================
Setup AWS Infrastructure
========================

We will be manually setting up the AWS infrastructure for our web application.

Check Region
------------

Make sure you are in a U.S. region that does not have many projects in it.

After choosing a region you will need to create a new SSH key if you selected a different region.

Create VPC
----------

Navigate to the VPC section of the AWS Console. Create a new VPC for your Zika project. Remember to create it with the VPC Wizard so you can create a VPC with a public subnet easily.

Create VPC Subnets
------------------

After creating your VPC with one public subnet, you will also need to create 2 subnets in different availability zones for your RDS.

Create RDS Subnet Groups
------------------------

You will need to create 2 subnet groups from the 2 subnets you created earlier.

Create RDS
----------

After you have your RDS subnets you will need to create the RDS for your Zika application.

We have been using PSQL version 9.5 throughout this class. Look over last weeks materials if you need a reminder on the steps to setup your database.

Create Web-app EC2 
------------------

After creating your database you need to verify the database is active, accessible to the EC2s on your VPC.

So spin up an EC2 with ubuntu, SSH into it and then use telnet, or psql (from the terminal) to access the RDS.

Create Elasticsearch EC2
------------------------

Create another EC2 with ubuntu specifically for elasticsearch. Again SSH into the EC2 to make sure it is available, and accessible within the VPC.

Next steps
----------

You have a VPC, an RDS, and 2 EC2s! Our RDS doesn't have any information, and our EC2 don't have our webapp, or Elasticsearch, but the infrastructure is in place.