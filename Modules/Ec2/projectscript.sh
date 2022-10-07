#!/bin/bash

yum upgrade -y
yum install httpd
yum systemctl enable httpd
yum systemctl start httpd
