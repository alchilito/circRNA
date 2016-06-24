#!/bin/bash

qstat | grep $1 | awk '{print $1}' | xargs qdel
