suppressMessages(require(diversitree))
source("../../R/tree_logistics.R")

pars <- c(0.1, 0.15, 0.03, 0.03, 0.01, 0.01)

set.seed(0)
phy.all <- trees(pars, type="bisse", n=50, max.taxa=1000, max.t=Inf,
                 include.extinct=FALSE, x0=NA)

prune.tree <- function(phy0)
{
    dropme <- sample(1:1000, 500)
    phy <- diversitree:::drop.tip.fixed(phy0, dropme)
    phy$tip.state <- phy0$tip.state[-dropme]
    phy$hist <- NULL # pruning seems to break plotting history
    phy
}

phy.samp <- lapply(phy.all, prune.tree)

plot.trees(phy.samp)
write.trees(phy.samp)
