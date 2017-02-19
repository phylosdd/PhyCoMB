suppressMessages(require(diversitree))
suppressMessages(require(phytools))
source("../../R/tree_logistics.R")
source("../../R/traits.R")

# trees are the same as another set
copy.treefiles("AJW")

# Trait stops evolving in one clade.

phy.all <- list()
set.seed(0)
for (i in 1:50)
{
    phy <- read.tree(name.treefile(zfill(i, 3)))
    phy$tip.state <- neutral.trait(phy, 10)

    nn <- findMRCA(phy, c("ACR_Acropora_tenella", 
                          "ACR_Acropora_acuminata", 
                          "ACR_Acropora_scherzeriana"))
    fix.tips <- extract.clade(phy, nn)$tip.label
    print(length(fix.tips))
    phy$tip.state[fix.tips] <- 0

    phy.all[[i]] <- phy

    write.table(phy$tip.state, file=name.statefile(zfill(i, 3)),
                col.names=F, sep=",", quote=F)
}

plot.trees(phy.all, adj=c(0.508, 0.5))

junk <- lapply(1:50, wipe.tree)
