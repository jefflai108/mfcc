# MFCC Extraction 
A much simpler version of mfcc extraction. Referenced from http://kaldi-asr.org and Jesús Villalba <jesus.antonio.villalba@gmail.com>

Steps to extract mfcc features from audios. More like a future reference for myself.

## Explanation of what each file does: 
1. Every file is written in bash (shell script).  

2. conf/mfcc.conf is the mfcc configuration file. Change the sampling frequency according to the audio file. e.g. All the audio files are sampled at 8k, then set --sample-frequency=8000. One can also change the low-freq and high-freq setting to the desired bandwith. e.g. Telephone data has narrowband 300 and 3700, hence set --low-freq=300 and --high-freq=3700. 

3. cmd.sh is to submit job on the server (to my understanding). It is related to distrbuted computing and it is important to not drain the memory of a single machine. 

4. path.sh is to set the environment variable. Generally, one only needs to reset the kaldi path "export KALDI_ROOT=" to where one's original kaldi directory resides. I usually create a symbolic link at the previous directory with command `ln -s 'directory path' 'filename'`, and set the kaldi path to it.  

5. steps/make_mfcc.sh uses steps/ and utils/ directories to perform mfcc extraction. Go to line 60, the command `scp=$data/wav.scp`. Make sure your scp file in the train directory agrees. e.g. if the scp file is called `beautiful_shit_wav.scp`, then change the command to `scp=$data/beautiful_shit_wav.scp`

6. train/ directory contains: 
	
	a. wav.scp contains tuples of wav file key and location of the wav file  
	
	b. utt2spk contains tuples of wav file key and their respective labels 

## To run, follow the procedure: 
1. First and foremost, create a symbolic link to Jesus directory: `ln -s 'jesus directory path' 'jesus directory name'` or `git clone /home/janto/usr/src/hyperion/hyperion .`

2. Create train/directory. Then, create the wav.scp (and utt2spk) file inside the train directory:
	
	a. If your audio files are already in .wav format. You're lucky. Simply reference with slightly modify the scripts `new_flac_to_wav.sh` or `gen_wav_scp.sh`. This will create the scp file for you. 
	
	b. If your audio files are in other format such as .sph .raw, then you need to use the bash library `sox` to convert the audio files to .wav. Reference the script `convert_to_wav.sh`. 
		
		I. For example, every line of the scp file should look something like this: 
		`vacvd sox -r 16000 -b 16 -e signed-integer /export/a11/oplchot/nist-sre-train2008/vacvd-x.raw -t wav -r 16000 -|` 
		Let's try to decode this. 
		
		II. vacvd is your file key. 
		
		III. sox is a very popular library for audio processing. /export/a11/oplchot/nist-sre-train2008/vacvd-x.raw is your audio file path. Everything before the file path and after sox is the characterisitc of the original audio file. Everything after the file path is the desired characteristic of your target audio file. 
		
		IV. For example, -r 16000 specifies samling rate at 16k. -t wav specifies your target audio file is in .wav format. 
		
		V. Last but not least, you need "-|" at the end. 
		
		
3. ./run.sh (if permission denied, do chmod u+x run.sh). This should create a mfcc directory and store the raw_mfcc_train.#.scp files. And store everything in mfcc_cmvn.h5
	
	a. `mfccdir=pwd/mfcc_1` set the directory to store the extracted mfcc. e.g. specifying `mfccdir=pwd/beautiful/shit/mfcc/` will store the extracted mfcc at /beautiful/shit/mfcc/
	
	b. `steps/make_mfcc.sh --mfcc-config conf/mfcc.conf --nj 40 --cmd "$train_cmd" pwd/train log/mfcc_log $mfccdir` 
		
		I. This function creates the extracted mfcc in binary files. 
		
		II. conf/mfcc.conf is where our mfcc configuration file locates at 
		
		III. `pwd`/train is where our train directory locates at 
		
		IV. log/mfcc_log is where the script will store the log files. It is helpful for debugging. 
	
  
 
