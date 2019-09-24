#' Check a tree file submitted to PhyCoMB
#'
#' This check function is run on each new tree file submitted to PhyCoMB.
#' It expects the file to contain exactly one line, which is a Newick string.
#'
#' @param treefile The name of the file to be checked
#'
#' @return TRUE if the check passes, FALSE if it doesn't
#'
#' @export
check_treefile <- function(treefile)
{
    phy <- try(ape::read.tree(file = treefile))
    methods::is(phy, "phylo")
}

#' Check a trait file submitted to PhyCoMB
#'
#' This check function is run on each new trait file submitted to PhyCoMB.  It
#' expects the file to contain one line per tip as "tiplabel,tipstate", i.e.,
#' CSV format without column or row names.  Each state should be 0 or 1 (but do
#' we want to allow NA in order to test with missing data?).
#'
#' @param statefile The name of the trait file to be checked
#'
#' @return TRUE if the check passes, FALSE if it doesn't
#'
#' @export
check_statefile <- function(statefile)
{
    tip <- try(utils::read.csv(statefile, header=F, as.is=T))
    ans <- FALSE
    if (methods::is(tip, "data.frame"))
        if (ncol(tip) == 2)
            if (all(tip[,2] %in% c(0,1)))
                ans <- TRUE
    return(ans)
}

#' Check a tree-trait combination submitted to PhyCoMB
#'
#' This check function is run on each item in a TestElement submitted to
#' PhyCoMB.  It expects a perfect match between the tip labels in the tree and
#' in the trait matrix.
#'
#' @param treefile The name of the tree file against which it will be checked
#' @param statefile The name of the trait file to be checked
#'
#' @return TRUE if the check passes, FALSE if it doesn't
#'
#' @export
check_tree_trait <- function(treefile, statefile)
{
    ans <- FALSE
    if (check_treefile(treefile) & check_statefile(statefile))
    {
        phy <- ape::read.tree(file = treefile)
        tip <- utils::read.csv(statefile, header=F, as.is=T)
        if (nrow(tip) == ape::Ntip(phy))
            if (all(sort(tip[,1]) == sort(phy$tip.label)))
                ans <- TRUE
    }
    return(ans)
}
