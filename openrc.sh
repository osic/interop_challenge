#!/bin/bash

# Get project name
echo "Please enter your OpenStack Project Name: "
read -sr OS_INPUT
export OS_PROJECT_NAME=$OS_INPUT

# Get user name
echo "Please enter your OpenStack User Name: "
read -sr OS_INPUT
export OS_USERNAME=$OS_INPUT

# Get keystone password.
echo "Please enter your OpenStack Password: "
read -sr OS_INPUT
export OS_PASSWORD=$OS_INPUT
