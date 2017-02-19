suppressMessages(require(diversitree))
source("../../R/tree_logistics.R")
source("../../R/traits.R")

pars <- c(0.1, 0.04, 0.03, 0.03, 0.05, 0)

set.seed(0)
phy.all <- trees(pars, type="bisse", n=150, max.taxa=500, max.t=Inf,
                 include.extinct=FALSE, x0=0)

# require at least 10 tips of both states (substantial acq bias)
phy.keep <- require.both.states(phy.all, N=10)

plot.trees(phy.keep[1:50])
write.trees(phy.keep[1:50])

junk <- lapply(1:50, wipe.tree)
