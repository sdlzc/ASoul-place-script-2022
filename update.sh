#!/bin/sh
screen -S reddit -X quit
git pull
pip install -r requirements.txt 
screen -S reddit -dm python3 main.py

