#' Rescale the tree to specified root age
#'
#' @param phy The tree to rescale
#' @param age The desired root age
#'
#' @return The rescaled tree
#'
#' @export
scale_root_age <- function(phy, age = 1)
{
    phy$edge.length <- phy$edge.length / max(ape::branching.times(phy))
    return(phy)
}

#' Remove identifying information from a tree
#'
#' Two files are written: one containing the tree, one containing the tip
#' states.  In these files, the tip names are wiped of identifying information.
#'
#' @param x The number of the tree (e.g., 14)
#' @param z The padded length of the tree's label (e.g., 3 if it's called 014)
#'
#' @export
wipe_tree <- function(x, z)
{
    Z <- zfill(x, z)
    phy <- read_tree_states(Z)
    # ensures tip.state is in the same order as tip.label

    phy$node.label <- NULL

    # standard tip names
    new_names <- paste("tip", 1:Ntip(phy), sep="")
    names(new_names) <- phy$tip.label
    phy$tip.label <- new.names[phy$tip.label]
    names(phy$tip.state) <- phy$tip.label

    ape::write.tree(phy, file=name_treefile(Z))
    write.table(phy$tip.state, file=name_statefile(Z),
                col.names=F, sep=",", quote=F)
}
