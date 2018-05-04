#' Convert states from continuous to binary
#'
#' @param phy A tree (phylo, with tip.state attribute)
#' @param threshold Below/Above this value the trait is 0/1, respectively
#'
#' @return The same tree, with tip states modified
#'
#' @export
discretize_states <- function(phy, threshold = "median")
{
    states_cont <- phy$tip.state
    states_disc <- states_cont * 0

    if (threshold == "median")
        threshold <- stats::median(states_cont)

    states_disc[states_cont > threshold] <- 1

    phy$tip.state <- states_disc
    return(phy)
}

#' Convert from multi-state to binary
#'
#' @param phy A tree (phylo, with tip.state attribute)
#' @param n_states The number of states before this conversion
#'
#' @return The same tree, with tip states modified
#'
#' @export
multi_to_binary_states <- function(phy, n_states)
{
    s01 <- phy$tip.state * NA
    s01[which(phy$tip.state <= n_states/2)] <- 0
    s01[which(phy$tip.state > n_states/2)] <- 1
    phy$tip.state <- s01

    # history causes plotting trouble
    phy$hist <- NULL

    return(phy)
}

# Rename tip states: classe uses 1:2 but bisse uses 0:1
# change_to_01 <- function(p)
# {
#     p$tip.state <- p$tip.state-1
#     return(p)
# }

#' Require at least N tips of both states
#'
#' @param phy_all A list of trees (each with tip.state attribute)
#' @param N Require at least N tips in each state
#'
#' @return The subset of phy_all that meets the requirement
#'
#' @export
require_both_states <- function(phy_all, N = 1)
{
    tips <- lapply(phy_all, function(x) table(x$tip.state))
    keep <- sapply(tips, function(x) length(x) == 2 & all(x >= N))
    p_keep <- phy_all[keep]
    return(p_keep)
}

#' Simulate a neutral binary trait on a given tree
#'
#' @param phy A tree
#' @param qval Transition rate parameters; if only one value is given, it is assumed to apply to both q01 and q10
#' @param req The requirement for retaining the simulation outcome; either the
#'        minimum proportion of tips in each state (if 0 < req < 0.5) or the minimum
#'        number of tips in each state (if req >= 1)
#'
#' @return The tree, with the simulated states as tip.state attribute
#'
#' @export
neutral_trait_discrete <- function(phy, qval, req)
{
    stopifnot(req > 0 & (req <= 0.5 | req >= 1))
    st <- -1

    if (length(qval) == 1)
        qval <- rep(qval, 2)

    if (req < 1)
    {
        while(length(table(st)) < 2 | any(table(st) / ape::Ntip(phy) < req))
            st <- diversitree::sim.character(phy, qval, model="mk2", x0=0)
    } else {
        while(length(table(st)) < 2 | any(table(st) < req))
            st <- diversitree::sim.character(phy, qval, model="mk2", x0=0)
    }

	phy$tip.state <- st
    return(phy)
}

#' Simulate a neutral continuous-valued trait on a given tree
#'
#' @param phy A tree
#' @param rateval The rate for Brownian motion
#' @param discretize Whether to convert the trait to binary
#' @param ... Additional parameters to pass to \link{discretize_states}
#'
#' @return The tree, with the simulated states as tip.state attribute
#'
#' @export
neutral_trait_continuous <- function(phy, rateval, discretize = TRUE, ...)
{
	st <- diversitree::sim.character(phy, rateval, model="bm")
	names(st) <- phy$tip.label
	phy$tip.state <- st

    if (discretize)
        phy <- discretize_states(phy, ...)

    return(phy)
}
