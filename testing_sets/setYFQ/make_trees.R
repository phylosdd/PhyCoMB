suppressMessages(require(diversitree))
source("../../R/tree_logistics.R")
source("../../R/traits.R")

# lam111 lam112 lam122 lam211 lam212 lam222 mu1 mu2 q12 q21
pars <- c(0.1, 0.1, 0, 0, 0.05, 0.1, 0.03, 0.03, 0, 0)

set.seed(0)
phy.all <- trees(pars, type="classe", n=50, max.taxa=500, max.t=Inf,
                 include.extinct=FALSE, x0=1)

plot.trees(phy.all, states=1:2)

phy.01 <- lapply(phy.all, change.to.01)
write.trees(phy.01)

junk <- lapply(1:50, wipe.tree)
