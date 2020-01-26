:orphan:

.. _walkthrough-certificates:

============
Certificates
============

In this walkthrough, we will be looking at how we can use certificates to verify our identity with a server.

Try Without Certificate
=======================

We have hosted an application `here <https://ec2-52-53-180-16.us-west-1.compute.amazonaws.com/user>`_.

Clicking that link takes you to the website over https using port 443, however we don't recognize their Certificate Authority, and we don't have a personal certificate to identify ourselves. We will need to add both of these to our browser in order to access this web application and move past this screen:

.. image:: /_static/images/certificates/restricted-access.png

We have two things to add to our browser to bypass this issue and to use this web application:
  #. Add the Certificate Authority
  #. Add our Personal Identification

Add the Certificate Authority
=============================

We first need to add the Certificate Authority to our browser.

The Certificate Authority certificate will be generated on the server that controls the web application. There are many publicly recognized Certificate Authorities, for the most part these Certificate Authorities are automatically added to your browser when you visit a website. However, this web application is using a private Certificate Authority to control and manage the access of this web application. We will need to contact the owner of the Certificate Authority to access the Certificate Authority certificate.

Since this is a web app, and Certificate Authority controlled by LaunchCode as a part of this class we created a Certificate Authority certificate named ``ca.crt`` in the s3 bucket: ``s3://launchcode-gisdevops-cert-authority/certs/``.

You can view the file with the following command: ``aws s3 ls s3://launchcode-gisdevops-cert-authority/certs/``.

.. image:: /_static/images/certificates/check-s3-bucket.png

You will notice two files: ``ca.crt`` that is the Certificate Authority certificate that will need to be added to our trusted Certificate Authorities, and we have ``student-cert.p12`` this is our identification certificate. Depending on the web applications needs to monitor or control access you may be issued a specific to you certificate. In this case to keep things simple we will all be using the same certificate which defines our role a student in the GIS DevOps class.

Go ahead and cp both of these files to your local machine: ``aws s3 cp --recursive s3://launchcode-gisdevops-cert-authority/certs ./certs`` this command will copy over both files to a folder named ``certs/`` off of your current location.

.. image:: /_static/images/certificates/copy-from-s3-bucket.png

Now that we have the files we can add them to our browser. Let's add the Certificate Authority certificate first.

Our examples will use Firefox as the browser, however the process for adding a Certificate Authority and a personal identification certificate should be similar across all major browsers.

In Firefox I need to access the browser ``Preferences``, also commonly marked as ``Settings``. The page should look something like this:

.. image:: /_static/images/certificates/preferences.png

From you here you want to select ``Privacy & Security`` which will take you to a page that looks like this:

.. image:: /_static/images/certificates/privacy-and-security.png

At the bottom of this page you will find the ``Certificates`` section:

.. image:: /_static/images/certificates/firefox-certificates.png

Click the ``View Certificates...`` button which will lead to a pop up window like this:

.. image:: /_static/images/certificates/certificate-manager.png

While writing this walkthrough my browser defaulted to showing the ``Authorities`` tab, which coincidentally is where we need to add our Certificate Authority certificate ``ca.crt``.

Click the ``Import...`` button to import the Certificate Authority certificate we downloaded earlier. From here select the ``ca.crt`` at the location you downloaded it to.

.. image:: /_static/images/certificates/add-ca.png

Click ``Open`` and another box will ask you what this Certificate Authority can do in your browser. Make sure to select ``Trust this CA to identify websites.``

.. image:: /_static/images/certificates/identify-websites.png

Finally click ``OK``. You can also View this certificate if you want as well. The window asked specifically if we want to trust ``The LaunchCode Foundation Certificate Authority``, and should have added an entry to your ``Authorities`` tab. It should look something like this:

.. image:: /_static/images/certificates/launchcode-foundation-ca.png

That's it we have added the new Certificate Authority certificate! Next step is to add our personal identification certificate.

Add Personal Identification
===========================

We downloaded an additional file earlier that will need to be added so that we can properly identify ourselves with the Certificate Authority we just added. Just like the previous step this was done for us by the Sys Admin, or owner of the server that controls the Certificate Authority we are trying to access.

Open the ``Certificate Manager`` again, and this time navigate to the ``Your Certificates`` tab.

.. image:: /_static/images/certificates/your-certificates.png

As you can see my certificates for this browser are currently empty. I want to add my personal identification certificate that we downloaded earlier from S3 here. Again click ``Import`` this time from the ``Your Certificates`` tab. Select the other file the .p12 file and click ``Open``.

.. image:: /_static/images/certificates/add-personal-identification-cert.png

When the personal identification certificate was create it was encrypted with a password, in order to add this personal identification certificate we will need to provide that password. This is again information we would need to get from the Sys admin, or server owner.

.. image:: /_static/images/certificates/encryption-password.png

We encrypted this certificate with the password: ``launchcode`` so enter that in the prompt. Upon completion you should see your newly added certificate:

.. image:: /_static/images/certificates/student-cert.png

That's it we just added our personal identification certificate.

Try it Out
==========

Let's navigate back to the link we looked at `earlier <https://ec2-52-53-180-16.us-west-1.compute.amazonaws.com/user>`_.

.. hint::

   You may need to close your browser and reopen it, or you can open a private browser to completely refresh the cache. ``Ctrl+Shift+r`` may work as well. Try these out if you don't see the alert about identifying yourself.

Before we even see the page we get an alert:

.. image:: /_static/images/certificates/identify-yourself.png

The website is asking us to identify ourselves via a personal identification cert, the cert we just added should be found in the drop down box. Select that cert and click ``OK``.

Now we see the webapp! We have successfully added a certificate authority, and a personal identification certificate and can access the web app.

.. image:: /_static/images/certificates/webapp.png


Why is the webapp asking us to login if we have gone through the hassle of adding the certificate authority? The Certificate Authority allows us to use HTTPS, TLS/SSL encryption and port 443, instead of the un-encrypted protcol HTTP and port 80. This has nothing to do with the web app itself, but the underlying infrastructure. We are now using a more secure port, and encryption for our web traffic.

The web app still may need it's own authentication, and authorization which is why we are seeing the login page. This webapp doesn't do anything, but if you'd like to login you can use the credentials username: ``launchcode-devops`` and password: ``launchcode`` which will take you to the last screen:

.. image:: /_static/images/certificates/login.png

Optional
========

From previous cohorts we have learned that you won't be asked to create your own Certificate Authorities very often, but will need to install certificates into your browsers regularly to access various servers.

However, if you'd like to learn more about how we created this checkout creating a :ref:`walkthrough-certificate-authority`.