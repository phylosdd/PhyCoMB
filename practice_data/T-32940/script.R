### A single birth-death tree with 500 tips

library("phycombR")

set.seed(1)
phy <- tree.bd(c(1, 0.1), max.taxa=500)
phy <- scale_root_age(phy)

write.tree(phy, file=name_treefile("001"))
