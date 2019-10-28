#! /usr/bin/env bash

pip install --upgrade git+https://github.com/LaunchCodeEducation/sphinx-bootstrap-theme.git@master

bash build -c

mv docs/ build-preview/
