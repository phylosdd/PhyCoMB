suppressMessages(require(diversitree))
source("../../R/tree_logistics.R")
source("../../R/traits.R")

# trees are the same as another set
copy.treefiles("KXH")

# Evolving continuous-valued trait.  Set threshold at median value.
phy.all <- list()
set.seed(0)
for (i in 1:50)
{
    phy <- read.tree(name.treefile(zfill(i, 3)))
    phy$tip.state <- continuous.trait(phy, 1)
    phy.all[[i]] <- phy

    write.table(phy$tip.state, file=name.statefile(zfill(i, 3)),
                col.names=F, sep=",", quote=F)
}

plot.trees(phy.all, adj=c(0.508, 0.5))
