suppressMessages(require(diversitree))
source("../../R/tree_logistics.R")
source("../../R/traits.R")

# Extract coral subtrees
suppressMessages(require(phytools))

# Huang & Roy (2015)
# supertree, complete sampling
# http://datadryad.org/resource/doi:10.5061/dryad.178n3
# extracted clade from ACR to AGA: 358 tips in all trees = coralA
#
# todo: better R for getting and reading this file
# wget http://datadryad.org/bitstream/handle/10255/dryad.66418/Huang%26Roy_Supertree.tre
# phy.all <- read.nexus("HuangRoy_CoralSupertree.nex")

for (i in 1:50)
{
    phy <- phy.all[[i*10]]
    nn <- findMRCA(phy, c("ACR_Acropora_abrolhosensis", "AGA_Pavona_xarifae"))
    phyA <- extract.clade(phy, nn)

    phyA$edge.length <- phyA$edge.length / max(branching.times(phyA))
    write.tree(phyA, file=name.treefile(zfill(i, 3)))

    print(Ntip(phyA))
    print(max(branching.times(phyA)))
}

# Neutral trait

phy.all <- list()
set.seed(0)
for (i in 1:50)
{
    phy <- read.tree(name.treefile(zfill(i, 3)))
    phy$tip.state <- neutral.trait(phy, 0.05, thresh=10)
    phy.all[[i]] <- phy

    write.table(phy$tip.state, file=name.statefile(zfill(i, 3)),
                col.names=F, sep=",", quote=F)
}

plot.trees(phy.all, adj=c(0.508, 0.5))

junk <- lapply(1:50, wipe.tree)
