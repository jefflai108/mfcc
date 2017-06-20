#imfcc
A much simpler version of mfcc extraction. Referenced from http://kaldi-asr.org and Jesús Villalba <jesus.antonio.villalba@gmail.com>

Steps to extract mfcc features from audios. More like a future reference for myself.

Explanation of what each file does: 
1. Every file is written in bash (shell script).  
2. conf/mfcc.conf is the mfcc configuration file. 
3. cmd.sh is to submit job on the server (to my understanding). It is related to distrbuted computing and it is important to not drain the memory of a single machine. 
4. path.sh is to set the environment variable. Generally, one only needs to reset the kaldi path "export KALDI_ROOT=" to where one's original kaldi directory resides.  
5. steps/make_mfcc.sh uses steps/ and utils/ directories to perform mfcc extraction.
6. train/ directory contains: 
	a. wav.scp contains tuples of wav file key and location of the wav file  
	b. utt2spk contains tuples of wav file key and their respective labels 

To run, follow the procedure: 
1. Convert audio file to .wav format. Reference the script convert_to_wav.sh 
2. Create train/ directory. Reference the script new_flac_to_wav.sh or gen_wav_scp.sh and an example of the train/ directory.
3. ./run.sh (if permission denied, do chmod u+x run.sh). This should create a mfcc directory and store the raw_mfcc_train.#.scp files. And store everything in mfcc_cmvn.h5
  
 
