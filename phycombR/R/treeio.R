#' Create filename for tree
#'
#' @param Z The identifier (probably created with \link{zfill})
#'
#' @return A string: t + Z + .tre
#'
#' @export
name.treefile <- function(Z)
{
    return(paste("t", Z, ".tre", sep=""))
}

#' Create filename for states
#'
#' @param Z The identifier (probably created with \link{zfill})
#'
#' @return A string: s + Z + .csv
#'
#' @export
name.statefile <- function(Z)
{
    return(paste("s", Z, ".csv", sep=""))
}

#' Write files for each tree
#'
#' Two files are written: one containing the tree (tNNN.tre), one containing
#' the tip states (sNNN.csv).
#'
#' @param phy.all A list of trees
#' @param z The padded length of the tree's label (e.g., 3 if it's called 014)
#' @param do.tree Whether to create a file for each tree
#' @param do.states Whether to create a file for each set of tip states
#'
#' @export
write.trees <- function(phy.all, z = 3, do.tree = TRUE, do.states = TRUE)
{
    for (i in seq_along(phy.all))
    {
        phy <- phy.all[[i]]
        Z <- zfill(i, 3)
        if (do.tree)
            ape::write.tree(phy, file=name.treefile(Z))
        if (do.states)
            write.table(phy$tip.state, file=name.statefile(Z),
                        col.names=F, sep=",", quote=F)
    }
}

#' Read in tree file and states file
#'
#' @param Z The identifier (probably created with \link{zfill})
#'
#' @return A phylo object, with states in the tip.state attribute
#'
#' @export
read.tree.states <- function(Z)
{
    phy <- ape::read.tree(name.treefile(Z))
    tip <- read.csv(name.statefile(Z), header=F, as.is=T)
    tip <- structure(tip$V2, names=tip$V1)
    phy$tip.state <- tip[phy$tip.label]

    return(phy)
}

# Copy tree files from another directory
# copy.treefiles <- function(X)
# {
#     treefiles <- list.files(paste("../set", X, sep=""), "^t[0-9]{3}[.]tre$",
#                             full.names = TRUE)
#     junk <- file.copy(treefiles, ".")
# }
