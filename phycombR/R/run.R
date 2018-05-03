#' Run a Method on an Element
#'
#' This function is a wrapper that applies a single Method to each item in an
#' Element.  See Notes for details.
#'
#' @param methodlabel String that identifies the Method
#' @param elementlabel String that identifies the Element
#'
#' @note This function makes some assumptions about what is in a Method.  There
#' should be a file called \code{script.R}, which calls anything else that is
#' needed.  This should provide a function \code{RunMyMethod} that takes as
#' arguments the name of a tree file and of a trait file.  The result of this
#' function is to write a Results file.  In that file, each row is the outcome
#' for one item, and columns are the Method, the Element, the Item, and a
#' single value that is the Result.
#'
#' @export
run_method <- function(methodlabel, elementlabel)
{
    message(paste("running", methodlabel, "on", elementlabel))
    tfiles <- list.files(path = elementlabel, pattern = "*.tre", full.names = TRUE)
    sfiles <- list.files(path = elementlabel, pattern = "*.csv", full.names = TRUE)
    stopifnot(length(tfiles) == length(sfiles))
    n_items <- length(tfiles)

    ### Will eventually need to allow for methods not written in R.  Could at least
    ### require a standardized R wrapper, which can call out to whatever code.
    ### Or could eventually have non-R equivalents of phycombR (e.g., Rev).

    # Evaluates functions but does not run anything
    source(paste(methodlabel, "script.R", sep="/"), chdir=T)
    # Now there should be a function RunMyMethod(treefile, traitfile)

    if (requireNamespace("parallel", quietly = TRUE))
    {
        ans <- parallel::mclapply(1:n_items,
                                  function(i) RunMyMethod(tfiles[i], sfiles[i]),
                                  mc.cores=parallel::detectCores())
    } else {
        ans <- lapply(1:n_items, function(i) RunMyMethod(tfiles[i], sfiles[i]))
    }

    writeme <- data.frame("Method" = methodlabel, "Element" = elementlabel,
                          "Item" = 1:n_items, "Result" = unlist(ans),
                          stringsAsFactors=F)
    write.table(writeme, file=paste("Results/", methodlabel, "_", elementlabel,
                                    ".csv", sep=""),
                row.names=F, sep=",", quote=F)
}
