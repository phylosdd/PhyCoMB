suppressMessages(require(diversitree))
source("../../R/tree_logistics.R")

pars <- c(0.1, 0.1, 0.01, 0.01, 0.05, 0.02)

set.seed(0)
phy.all <- trees(pars, type="bisse", n=50, max.taxa=500, max.t=Inf,
                 include.extinct=FALSE, x0=NA)

plot.trees(phy.all)
write.trees(phy.all)
