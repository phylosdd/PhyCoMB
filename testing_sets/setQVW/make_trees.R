suppressMessages(require(diversitree))
source("../../R/tree_logistics.R")
source("../../R/traits.R")

# carnivora trees
copy.treefiles("QFD")

# simulate a neutral trait
phy.all <- list()
set.seed(0)
for (i in 1:50)
{
    phy <- read.tree(name.treefile(zfill(i, 3)))
    phy$tip.state <- neutral.trait(phy, c(3, 0), thresh=10, x0=0)
    phy.all[[i]] <- phy

    write.table(phy$tip.state, file=name.statefile(zfill(i, 3)),
                col.names=F, sep=",", quote=F)
}

plot.trees(phy.all, adj=c(0.508, 0.5))

junk <- lapply(1:50, wipe.tree)
