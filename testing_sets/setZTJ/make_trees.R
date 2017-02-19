suppressMessages(require(diversitree))
source("../../R/tree_logistics.R")
source("../../R/traits.R")

# bamm test trees, dd_k4 (final 50)
# http://datadryad.org/resource/doi:10.5061/dryad.hn1vn
phy.all <- read.tree("dd_k4.tre", skip=450)
phy.all <- lapply(phy.all, scale.age.to.1)

# Neutral trait
set.seed(0)
for (i in 1:50)
{
    phy.all[[i]]$tip.state <- neutral.trait(phy.all[[i]], 0.01)
}

plot.trees(phy.all, adj=c(0.508, 0.5))
write.trees(phy.all)

junk <- lapply(1:50, wipe.tree)
