### Simulate neutral discrete traits on single birth-death tree

library("phycombR")

set.seed(0)

phy0 <- read.tree("../T-32940/t001.tre")
phy_all <- list()

for (i in 1:15)
{
    phy <- neutral_trait_discrete(phy0, 1, 0.1)

    print(table(phy$tip.state))

    phy_all[[i]] <- phy
}

write_trees(phy_all, do_tree=F)
