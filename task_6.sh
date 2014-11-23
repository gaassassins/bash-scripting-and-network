#!/bin/bash

source ~/set.conf

fn=$(date +"%Y-%m-%e.bak")

zip -9 -r $fn ~/$subdir
mv $fn /tmp