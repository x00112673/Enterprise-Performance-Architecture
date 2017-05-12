#!/bin/bash
echo "Please enter your username"
read name 
if [ "$name" == "$USER" ]
	then
		ps
else echo "Access Denied"
fi
