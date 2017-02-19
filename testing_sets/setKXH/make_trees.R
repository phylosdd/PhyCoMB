suppressMessages(require(diversitree))
suppressMessages(require(parallel))
source("../../R/tree_logistics.R")

# RG2015 Fig4
shape <- "fast"
pars.all <- list("slow" = c(0.5, 1.0, 0, 0, 0.001, 0.001), 
                 "fast" = c(0.5, 1.0, 0, 0, 0.1, 0.1),
                 "null" = c(0.5, 0.5, 0, 0, 0.01, 0.01)
                 )
pars <- pars.all[[shape]]

# Avoid trivial trees
make.tree <- function(i, pars)
{
    Ntip <- function(phy)
        ifelse(inherits(phy, "phylo"), length(phy$tip.label), 0)

    phy <- NULL
    while (Ntip(phy) < 1 | length(table(phy$tip.state)) < 2 |
           any(table(phy$tip.state) / Ntip(phy) < 0.25))
        phy <- tree.bisse(pars, max.taxa = 200, x0=0)

    return(phy)
}

# TODO: figure out how to set seeds for parallel computation

phy.all <- mclapply(1:50, make.tree, pars, mc.cores=detectCores())
plot.trees(phy.all)

# Scale to age 1 (delaying until now because breaks plotting history)
phy.1 <- mclapply(phy.all, scale.age.to.1, mc.cores=detectCores())
write.trees(phy.1)

junk <- lapply(1:50, wipe.tree)
