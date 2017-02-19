suppressMessages(require(diversitree))
suppressMessages(require(TreeSim))
source("../../R/tree_logistics.R")
source("../../R/traits.R")

#--------------------------------------------------
# Make trees
#--------------------------------------------------

# speciation rate increases toward the present, in time intervals of length 9
# note that intervals are measured from the tips backward in time
# so the root interval (slow speciation) is adjusted to be as long as necessary to get the right number of tips
interval <- 9

set.seed(0)
phy.all <- sim.rateshift.taxa(350, 50, c(0.3, 0.2, 0.1), c(0.05, 0.05, 0.05),
                              frac=c(1,1,1), c(0, interval, interval*2),
                              complete=F)

# ages <- sapply(phy.all, function(x) max(branching.times(x)))
# hist(ages)
# trees are all old enough to have all three intervals
# some very old trees have long slow start

phy.all <- lapply(phy.all, scale.age.to.1)
phy.all <- write.trees(phy.all, do.states=F)

#--------------------------------------------------
# Neutral trait
#--------------------------------------------------

phy.all <- list()
set.seed(0)
for (i in 1:50)
{
    phy <- read.tree(name.treefile(zfill(i, 3)))
    phy$tip.state <- neutral.trait(phy, c(0.1, 0), thresh=0.1)
    phy.all[[i]] <- phy

    write.table(phy$tip.state, file=name.statefile(zfill(i, 3)),
                col.names=F, sep=",", quote=F)
}

plot.trees(phy.all, adj=c(0.508, 0.5))
