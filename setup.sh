#!/bin/bash

# Make sure that pip3 is installed and up to date
sudo apt-get install python3-pip

# Install dependencies for elpy
pip3 install jedi
pip3 install flake8
pip3 install autopep8
pip3 install yapf
