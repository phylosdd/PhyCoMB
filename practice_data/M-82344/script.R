## FiSSE model with 2-tailed p-value

require("phycombR")
require("phangorn")
source("funcs.R")

RunMyMethod <- function(tfile, sfile)
{
    phy <- read_tree_states(treefile=tfile, statefile=sfile)
    run_fisse(phy)
}

run_fisse <- function(phy)
{
    ans <- FISSE.binary(phy, phy$tip.state)
    ans$pval2 <- min(ans$pval, 1-ans$pval)*2
    return(ans$pval2 < 0.05)
}
