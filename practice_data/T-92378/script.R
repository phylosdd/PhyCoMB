### Apply jitter and chronopl to coral tree

library("phycombR")

phy0 <- read.tree("../T-83768/t004.tre")
set.seed(0)

for (i in 1:12)
{
    phy <- phy0
    phy$edge.length <- phy0$edge.length * rnorm(length(phy0$edge.length), 1, 0.2)
    phy <- chronopl(phy, lambda=1)

    Z <- zfill(i, 3)
    phy <- scale_root_age(phy)
    write.tree(phy, file=name_treefile(Z))
    message(is.ultrametric(phy))
}
