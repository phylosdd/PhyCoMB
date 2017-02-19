suppressMessages(require(diversitree))
source("../../R/tree_logistics.R")
source("../../R/traits.R")

# carnivora, 280 spp, almost complete, supertree
# http://bmcbiol.biomedcentral.com/articles/10.1186/1741-7007-10-12#MOESM5
# first tree is the best one; repeat 50 times, but resolve polytomies randomly
phy <- read.nexus("carnivora.nex")
phy <- scale.age.to.1(phy[[1]])

set.seed(0)
for (i in 1:50)
    write.tree(multi2di(phy), file=name.treefile(zfill(i, 3)))

# simulate a moderate-rate neutral trait
phy.all <- list()
set.seed(0)
for (i in 1:50)
{
    phy <- read.tree(name.treefile(zfill(i, 3)))
    phy$tip.state <- neutral.trait(phy, 1, thresh=10)
    phy.all[[i]] <- phy

    write.table(phy$tip.state, file=name.statefile(zfill(i, 3)),
                col.names=F, sep=",", quote=F)
}

plot.trees(phy.all, adj=c(0.508, 0.5))

junk <- lapply(1:50, wipe.tree)
