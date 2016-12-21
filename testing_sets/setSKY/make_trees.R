suppressMessages(require(diversitree))
source("../../R/tree_logistics.R")
source("../../R/traits.R")

# wild rate-shift trees
# many states, varying speciation rates, fairly-rapid transitions

n.states <- 8
lambda <- seq(0, 2, length.out=n.states)
pars <- c(lambda, rep(0.03, n.states), rep(0.1, n.states*(n.states-1)))

set.seed(0)
phy.all <- trees(pars, type="musse", n=50, max.taxa=350, max.t=Inf,
                 include.extinct=FALSE, x0=2)

# convert from multi to binary
change.to.12 <- function(p)
{
    s12 <- p$tip.state * 0
    s12[which(p$tip.state <= n.states/2)] <- 1
    s12[which(p$tip.state > n.states/2)] <- 2
    p$tip.state <- s12

    p
}

phy.12 <- lapply(phy.all, change.to.12)
plot.trees(phy.12, states=1:n.states)

phy.01 <- lapply(phy.12, change.to.01)
phy.1 <- lapply(phy.01, scale.age.to.1)
write.trees(phy.1)
