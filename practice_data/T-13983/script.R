### A set of bisse trees

library("phycombR")

set.seed(0)

pars <- c(15, 6, 4.5, 4.5, 7.5, 0.75)

phy_all <- trees(pars, type="bisse", n=25, max.taxa=Inf, max.t=1,
                 include.extinct=FALSE, x0=NA)
phy_keep <- require_both_states(phy_all, 10)[1:15]

write_trees(phy_keep)

dir.create("../A-11463")
moveme <- list.files("./", pattern = "^s[0-9]{3}[.]csv$")
file.copy(moveme, to="../A-11463")
file.remove(moveme)
