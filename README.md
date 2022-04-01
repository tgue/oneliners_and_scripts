# Onliners and Scripts 
This repository is an attempt at collecting tips and tricks in bash and Unix that can be of use to most people in the Human Evolution program.

Please add your onliners to [onliners.md](onliners.md)

If you have standaline scripts then please add them to the repository.
Then add following information to the [Standalone Scripts Readme](standalone_script_readme.md):

* The purpose of the script
* What's the input for the script
* What's the output
* A typical command, i.e:

```
bash my_script.py -i my_input.txt -o my_output.txt
```
 
 
 ### PSMCfrombam.sh
 
 Script to run PSMC on UPPMAX. loops over a file of sample names. 
Starts from bam file, creates vcf with samtools and outputs final MSMC files.  You need generate_multihetsep.py, bamCaller.py and utils.py from msmc tools (https://github.com/stschiff/msmc-tools).  
You also need mask files which are available in the umbrella project (for hg19). 

