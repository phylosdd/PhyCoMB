#' Create filename for tree
#'
#' @param Z The identifier (probably created with \link{zfill})
#'
#' @return A string: t + Z + .tre
#'
#' @export
name_treefile <- function(Z)
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
name_statefile <- function(Z)
{
    return(paste("s", Z, ".csv", sep=""))
}

#' Write files for each tree
#'
#' Two files are written: one containing the tree (tNNN.tre), one containing
#' the tip states (sNNN.csv).
#'
#' @param phy_all A list of trees
#' @param z The padded length of the tree's label (e.g., 3 if it's called 014)
#' @param do_tree Whether to create a file for each tree
#' @param do_states Whether to create a file for each set of tip states
#'
#' @export
write_trees <- function(phy_all, z = 3, do_tree = TRUE, do_states = TRUE)
{
    for (i in seq_along(phy_all))
    {
        phy <- phy_all[[i]]
        Z <- zfill(i, 3)
        if (do_tree)
            ape::write.tree(phy, file=name_treefile(Z))
        if (do_states)
            utils::write.table(phy$tip.state, file=name_statefile(Z),
                               col.names=F, sep=",", quote=F)
    }
}

#' Read in tree file and states file
#'
#' @param Z The identifier (probably created with \link{zfill})
#' @param treefile The name of a Newick tree file
#' @param statefile The name of a CSV trait file
#'
#' @return A phylo object, with states in the tip.state attribute
#'
#' @note Provide EITHER Z OR treefile and statefile.
#'
#' @export
read_tree_states <- function(Z = NULL, treefile = NULL, statefile = NULL)
{
    if (!is.null(Z))
    {
        treefile <- name_treefile(Z)
        statefile <- name_statefile(Z)
    }

    phy <- ape::read.tree(treefile)
    tip <- utils::read.csv(statefile, header=F, as.is=T)
    tip <- structure(tip$V2, names=tip$V1)
    phy$tip.state <- tip[phy$tip.label]

    return(phy)
}

# Copy tree files from another directory
# copy_treefiles <- function(X)
# {
#     treefiles <- list.files(paste("../set", X, sep=""), "^t[0-9]{3}[.]tre$",
#                             full.names = TRUE)
#     junk <- file.copy(treefiles, ".")
# }

#' Copy and adjust tree and state files to create an element
#'
#' The end result is an equal number of name-standardized treefiles and
#' statefiles.
#'
#' @param treelabel Label of Trees to use
#' @param traitlabel Label of Traits to use
#'
#' @return Boolean indicating success or failure
#'
#' @export
assemble_element <- function(treelabel, traitlabel)
{
    tgetme <- list.files(paste("../", treelabel, sep=""), "*.tre")
    sgetme <- list.files(paste("../", traitlabel, sep=""), "*.csv")

    z <- max(nchar(c(length(sgetme), length(tgetme))))

    tfiles <- name_treefile(sapply(1 : length(tgetme), zfill, z))
    r1 <- file.copy(paste("../", treelabel, "/", tgetme, sep=""), tfiles)

    sfiles <- name_statefile(sapply(1 : length(sgetme), zfill, z))
    r2 <- file.copy(paste("../", traitlabel, "/", sgetme, sep=""), sfiles)

    r3 <- TRUE
    if (length(tfiles) != length(sfiles))
    {
        if (length(tfiles) == 1)
        {
            r3 <- file.copy(tfiles, name_treefile(sapply(2 : length(sfiles), zfill, z)))
        } else if (length(sfiles) == 1) {
            r3 <- file.copy(sfiles, name_statefile(sapply(2 : length(tfiles), zfill, z)))
        } else {
            warning("Don't know how to match up tree files with trait files.")
            r3 <- FALSE
        }
    }

    return(all(r2, r3, r3))
}
