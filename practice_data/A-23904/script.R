### Simulate one neutral median-threshold trait on each coral tree

library("phycombR")

set.seed(0)

treefiles <- list.files("../T-83768", "^t[0-9]{3}[.]tre$", full.names=T)

phy_all <- list()
i <- 1

for (tf in treefiles)
{
    phy <- read.tree(tf)
    phy <- neutral_trait_continuous(phy, 1)
    phy_all[[i]] <- phy
    i <- i + 1
}

write_trees(phy_all, do_tree=F)
