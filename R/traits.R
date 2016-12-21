#' Rename tip states: classe uses 1:2 but bisse uses 0:1
change.to.01 <- function(p)
{
    p$tip.state <- p$tip.state-1
    return(p)
}

#' Convert from continuous to binary
discretize.states <- function(p)
{
    states.cont <- p$tip.state
    states.disc <- states.cont * 0
    states.disc[states.cont > median(states.cont)] <- 1

    p$tip.state <- states.disc
    return(p)
}

#' Require at least N tips of both states
require.both.states <- function(p, N = 1)
{
    tips <- lapply(p, function(x) table(x$tip.state))
    keep <- sapply(tips, function(x) length(x) == 2 & all(x >= N))
    p.keep <- p[keep]
    return(p.keep)
}

#' Simulate a neutral binary trait on a given tree
neutral.trait <- function(phy, qval, thresh = 0.10)
{
    st <- -1

    # require at least "thresh" of each state
    if (thresh < 1)
    {
        while(length(table(st)) < 2 | any(table(st) / Ntip(phy) < thresh))
            st <- sim.character(phy, rep(qval, 2), model="mk2")
    } else {
        while(length(table(st)) < 2 | any(table(st) < thresh))
            st <- sim.character(phy, rep(qval, 2), model="mk2")
    }

    return(st)
}

#' Simulate a neutral continuous-valued trait on a given tree
continuous.trait <- function(phy, rateval)
{
	st <- sim.character(phy, rateval, model="bm")
	names(st) <- phy$tip.label
	phy$tip.state <- st
    return(discretize.states(phy)$tip.state)
}
