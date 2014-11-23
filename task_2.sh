#!/bin/bash

if (( $# == 0 ));
then
    whoami
else
eval var=\$$1
echo ${var}
fi