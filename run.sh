#!/bin/bash
. cmd.sh #source file 
. path.sh #source file 
set -e #https://stackoverflow.com/questions/19622198/what-does-set-e-mean-in-a-bash-script
mfccdir=`pwd`/mfcc_1 #set the directory to store the extracted mfcc 

#This step creates mfcc 
# First argument: `pwd`/train (where wav file identifiers are)
# Second argument: log/mfcc_log (log file) 
# Third argument: $mfccdir (see above) 
steps/make_mfcc.sh --mfcc-config conf/mfcc.conf --nj 40 --cmd "$train_cmd" `pwd`/train log/mfcc_log $mfccdir 

#This step converts scp --> hdf5 (python readable) 
# First argument: ./mfcc_cmvn.h5 (Convert all .scp files and store them in this file)
# Second argument: log/ark2h5 (log file)
steps/mfcc_cmv_ark2h5.sh train 10 ./mfcc_cmvn.h5 log/ark2h5 
