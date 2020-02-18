:orphan:

.. _oauth2:

============
Visual OAuth
============

In this walkthrough we will be using an interactive learning tool to explore OAuth. The Visual OAuth tool will give you a background on Authentication, Authorization and OAuth 2.0. After learning some background knowledge you will have an opportunity to explore the most common OAuth flow used in modern web development. The interactive section will walk you through each step of the **Authorization Code Grant Flow** used in the OAuth 2.0 handshake of a **Multi-Host Application**.

.. note::
  Recall that **Multi-Host Applications** host their client (front-end code) and API (back-end code) on separate servers. In other words, this design architecture physically separates the concerns of the View from the Model and Controller layers. This design has become a standard for data-driven web apps that utilize front-end frameworks like React or Angular.
  
.. note::
  Multi-Host Application design is a modern best practice because it allows the front-end and back-end teams to develop and deploy autonomously. So long as their interface of communication (consuming and exposing the Web API endpoints and behaviors) remains constant both teams can deliver rapid solutions to changing business requirements without holding back or needing to coordinate internal changes with the other.

Get Started
===========

This walkthrough will require you to run the Visual OAuth application locally on your machine. As part of the setup you will get to learn how to register your own GitHub OAuth Application! Head over to the `GitHub repo for Visual OAuth <https://github.com/LaunchCodeEducation/visual-oauth>`_ and follow the instructions in the ``README.md`` file to start learning.