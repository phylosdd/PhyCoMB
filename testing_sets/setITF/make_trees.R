suppressMessages(require(diversitree))
suppressMessages(require(TESS))
source("../../R/tree_logistics.R")
source("../../R/traits.R")

# Make trees

set.seed(0)
phy.all <- tess.sim.taxa(n=50, 350, max=1000, lambda=0.1, mu=0.03,
                         massExtinctionTimes=c(50),
                         massExtinctionSurvivalProbabilities=c(0.1))
phy.1 <- lapply(phy.all, scale.age.to.1)
write.trees(phy.1)

# Neutral trait

phy.all <- list()
set.seed(0)
for (i in 1:50)
{
    phy <- read.tree(name.treefile(zfill(i, 3)))
    phy$tip.state <- neutral.trait(phy, 0.01)
    phy.all[[i]] <- phy

    write.table(phy$tip.state, file=name.statefile(zfill(i, 3)),
                col.names=F, sep=",", quote=F)
}

plot.trees(phy.all, adj=c(0.508, 0.5))

junk <- lapply(1:50, wipe.tree)
