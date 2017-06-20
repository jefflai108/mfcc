# mfcc
A much simpler version of mfcc extraction. Referenced from http://kaldi-asr.org and Jesús Villalba <jesus.antonio.villalba@gmail.com>

Steps to extract mfcc features from audios. More like a future reference for myself.

Explanation of what each file does: 
1. Every file is written in bash (shell script).  
2. conf/mfcc.conf is the mfcc configuration file. 
3. cmd.sh is to submit job on the server (to my understanding). It is related to distrbuted computing and it is important to not drain the memory of a single machine. 
4. path.sh is to set the environment variable. Generally, one only needs to reset the kaldi path "export KALDI_ROOT=" to where one's original kaldi directory resides.  
5. steps/make_mfcc.sh uses steps/ and utils/ directories to perform mfcc extraction.

To run, follow the procedure: 

1. ./run.sh (if permission denied, do chmod u+x run.sh) 
 
