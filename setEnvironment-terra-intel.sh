#!/bin/bash

module unload PrgEnv-cray
module load PrgEnv-intel

module unload craype-sandybridge
module load craype-haswell

module list

export PATH=${HOME}/scorep-4.0-install/bin:${PATH}
export LD_LIBRARY_PATH=${HOME}/scorep-4.0-install/lib:${LD_LIBRARY_PATH}

