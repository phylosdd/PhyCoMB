suppressMessages(require(diversitree))
source("../../R/tree_logistics.R")
source("../../R/traits.R")

# diversitree's trees() is missing the "quasse" switch
trees <- function (pars, type = c("bisse", "bisseness", "bd", "classe",
                                  "geosse", "musse", "quasse", "yule"), n = 1,
                   max.taxa = Inf, max.t = Inf, include.extinct = FALSE, ...) 
{
    if (is.infinite(max.taxa) && is.infinite(max.t)) 
        stop("At least one of max.taxa and max.t must be finite")
    type <- match.arg(type)
    f <- switch(type, bisse = tree.bisse, bisseness = tree.bisseness, 
                bd = tree.bd, classe = tree.classe, geosse = tree.geosse, 
                musse = tree.musse, yule = tree.yule, 
                quasse = tree.quasse) # added 
    trees <- vector("list", n)
    i <- 1
    while (i <= n) {
        trees[[i]] <- phy <- f(pars, max.taxa, max.t, include.extinct, ...)
        if (include.extinct || !is.null(phy)) 
            i <- i + 1
    }
    trees
}

# rates from diversitree tutorial
lambda <- function(x) sigmoid.x(x, 0.1, 0.2, 0, 2.5)
mu <- function(x) constant.x(x, 0.03)
char <- make.brownian.with.drift(0, 0.025)
pars <- c(lambda, mu, char)

set.seed(0)
phy.all <- trees(pars, type="quasse", n=50, max.taxa=200, x0=0,
                 single.lineage=FALSE)
# (slow to run)

phy.all <- lapply(phy.all, discretize.states)

plot.trees(phy.all, adj=c(0.5, 0.5))
write.trees(phy.all)
