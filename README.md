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


### explore\_admixture\_graphs.R
 
Minimal [script](explore_admixture_graphs.R) for using [admixtools2](https://uqrmaie1.github.io/admixtools/index.html) and its find\_graphs() function to systematically search for admixture graphs. Doing this in ad systematic way is a major advance compared to the manual approach of crafting input graphs for qpGraph which can easily be biased by someones own ideas or end up with models that fit okay-ish but do not make sense in a temporal or geographic way.

It reads Plink bed/bim/fam files only containing the populations one wants to use for the reconstruction of admixture graphs. More description can be found in the admixtools2 [documentation](https://uqrmaie1.github.io/admixtools/articles/graphs.html#exploring-different-graphs-1).
 
Some thoughts:
* A single run of find\_graphs() only takes a couple of minutes, so one can run it multiple times to explore the search space (especially on Uppmax). The script is using 100 runs per number of migrations but my observation is that the higher *m* gets, the more local optima exist. For *m=4*, e.g. only ~5% of the runs ended up with the best likelihood. Consequently, it might make sense to run more iterations for higher values of *m*.
* In my specific case, I had eight populations (7 plus outgroup). From the literature, this seems to be about the sample size that is feasbile in other studies. I haven't tried other settings (yet). I could imagine that the search space just becomes so big at some point, that even if an individual run of find\_graphs() is rather fast, it won't be feasible to exhaustively explore the entire search space.
* I am plotting graphs with scores close to the currently best solution and the best graph per *m* is stored as best.M*m*. Other graphs can be reproduced since I am setting random seed = iteration number.
* qpgraph\_resample\_multi() and compare\_fits() are useful functions to compare how well two different graphs fit the data. A graph with higher $m$ naturally has a higher chance to produce a better likelihood. Using these functions, one can compare the fit of graphs with different *m* whether the higher *m* is actually a significantly better fit -- if not, one should pick the parsimonious option and use the one with lower *m*.
* While writing this, a [preprint](https://www.biorxiv.org/content/10.1101/2022.05.08.491072v2) dropped describing and benchmarking the find\_graphs() function and providing some more detailled recommendations on how to use it.
