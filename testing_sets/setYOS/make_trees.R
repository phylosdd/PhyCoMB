suppressMessages(require(diversitree))
source("../../R/tree_logistics.R")
source("../../R/traits.R")

# hisse-inspired
# two binary traits, aka four states
#
# only one state increases speciation
# so it is not over-represented, transition rates out of that state are higher
#
# then collapse to a binary trait

lambda <- c(rep(0.5, 3), 1)
mu <- rep(0.1, 4)
qs <- rep(0.1, 12)
qs[10:12] <- 0.22
pars <- c(lambda, mu, qs)

set.seed(0)
phy.all <- trees(pars, type="musse", n=50, max.taxa=350, max.t=Inf,
                 include.extinct=FALSE, x0=1)
plot.trees(phy.all, states=1:4)

phy.01 <- lapply(phy.all, multi.to.binary.states, 4)
phy.01 <- lapply(phy.01, scale.age.to.1)

write.trees(phy.01)

junk <- lapply(1:50, wipe.tree)
