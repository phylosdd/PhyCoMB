suppressMessages(require(diversitree))
source("../../R/tree_logistics.R")
source("../../R/traits.R")

pars <- c(0.1, 0.1, 0.03, 0.03, 0.025, 0)
# chose q01 so acquisition bias isn't too terrible

set.seed(0)
phy.all <- trees(pars, type="bisse", n=100, max.taxa=500, max.t=Inf,
                 include.extinct=FALSE, x0=0)

# require at least 10 tips of both states
phy.keep <- require.both.states(phy.all, N=10)
# tips <- lapply(phy.all, function(x) table(x$tip.state))
# keep <- sapply(tips, function(x) length(x) == 2 & all(x >= 10))
# phy.keep <- phy.all[keep]

plot.trees(phy.keep[1:50])
write.trees(phy.keep[1:50])
