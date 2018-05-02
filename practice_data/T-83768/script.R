### From coral supertrees, extract a clade

library("phycombR")
require("phytools")

phy_all <- read.nexus("../downloads/HuangRoy2015_CoralSupertree.nex")

for (i in 1:10)
{
    phy <- phy_all[[i*10]]
    nn <- findMRCA(phy, c("ACR_Acropora_abrolhosensis", "AGA_Pavona_xarifae"))
    phyA <- extract.clade(phy, nn)

    Z <- zfill(i, 3)
    phyA <- scale_root_age(phyA)
    write.tree(phyA, file=name_treefile(Z))

    message(paste(Ntip(phyA), "tips in tree", i))
}
