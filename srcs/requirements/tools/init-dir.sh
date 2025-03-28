#!/bin/bash


if [ ! -d "/home/${USER}/data" ] && [ ! -d "/Users/${USER}/data" ] 
then
	mkdir -p /home/${USER}/data/db_vol
	mkdir -p /home/${USER}/data/wp_vol
fi