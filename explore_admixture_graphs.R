library(admixtools)
library(dplyr)


f2=f2_from_geno("primitive.770K.graph",maxmiss=0.15,auto_only=FALSE) 
#default is to only use sites without missing data, auto_only = FALSE because admixtools2 assumes your species has 22 autosomes and ignores the rest


for (m in 0:5){
  best.s=.Machine$integer.max
  for (i in 1:100){
    set.seed(i) #keep track of random seed, in order to reproduce models
    opt_results = find_graphs(f2, numadmix = m, outpop = 'YAK',stop_gen = 10000, stop_gen2 = 30, plusminus_generations = 10) 
    #search parameters as in Meyer preprint
    
    winner = opt_results %>% slice_min(score, with_ties = FALSE)
    s=winner$score[[1]]
    if (s<=best.s*1.1){ 
      #plot graphs with LL close to the currently best model
      pdf(paste('plots/graph',m,i,s,'pdf',sep='.'))
      print(plot_graph(winner$edges[[1]]))
      dev.off()
      if (s<best.s){
        best.M=winner
        best.s=s      
      }
    }
  }
  assign(paste('best.M',m,sep=''),best.M) #save the best model for a cetrain m
}



save.image("graphs.RData")
#load('graphs.RData')

#test which graph fits better (if $p is high, then the more complicated model does not provide a significantly better fit, regardless of a possibly better likelihood)
fits = qpgraph_resample_multi(f2, list(best.M0$graph[[1]], best.M1$graph[[1]]), nboot = 100)
compare_fits(fits[[1]]$score_test, fits[[2]]$score_test)

