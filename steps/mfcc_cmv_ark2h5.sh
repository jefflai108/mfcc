#!/bin/bash

cmd=run.pl

KERAS_PATH=$(pwd -P)/keras
HYP_PATH=$(pwd -P)/hyperion

export PATH=$HYP_PATH/hyperion/bin:$PATH
export PYTHONPATH=$HYP_PATH:$KERAS_PATH:$PYTHONPATH

if [ -f path.sh ]; then . ./path.sh; fi
. parse_options.sh || exit 1;

delta_opts="--delta-window=3 --delta-order=2"

input_lists="$1" # train
num_jobs=$2 # 10
output=$3   # ./mfcc_cmvn.h5
logdir=$4   # ./exp/ark2h5

mkdir -p $logdir

tmp=./exp/tmp
mkdir -p $tmp

echo "$0 [info] preparing lists"

for list in $input_lists
do
    cat ./mfcc_1/raw_mfcc_${list}.*.scp
done | awk '
{ if(!($1 in ids)) { print $0; ids[$1]=1}}' | sort > $tmp/mfcc.scp

mfcc_list=""
for((i=1;i<=$num_jobs;i++));do
    mfcc_list=$mfcc_list" "$tmp/mfcc.$i.scp
done
utils/split_scp.pl $tmp/mfcc.scp $mfcc_list

echo "$0 [info] mfcc in $input_list + cmvn"

feats="ark,s,cs:apply-cmvn-sliding --norm-vars=true --center=true --cmn-window=300 scp:$tmp/mfcc.JOB.scp ark:- |"

$cmd JOB=1:$num_jobs $logdir/copy_feats.JOB.log \
      copy-feats "$feats" ark,scp:$tmp/mfcc_cmvn.JOB.ark,$tmp/mfcc_cmvn.JOB.scp || exit 1

cat $tmp/mfcc_cmvn.*.scp > $tmp/mfcc_cmvn.scp


echo "$0 [info] mfcc in $input_list + deltas + cmn + vad to hdf5: $output"

$cmd $logdir/ark2hyp.log \
     ark2hyp.py --input-file $tmp/mfcc_cmvn.scp \
     --output-file $output \
     --chunk-size 100


