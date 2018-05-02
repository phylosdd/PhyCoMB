### Maybe this run_method() function should go inside the phycombR package.
### But for now it seems better not to hide away its assumptions.  Namely, a
### file M-xxxxx/script.R that provides everything needed via a function called
### RunMyMethod.

suppressMessages(library("phycombR"))
suppressMessages(library("parallel"))

run_method <- function(methodlabel, elementlabel)
{
    message(paste("running", methodlabel, "on", elementlabel))
    tfiles <- list.files(path = elementlabel, pattern = "*.tre", full.names = TRUE)
    sfiles <- list.files(path = elementlabel, pattern = "*.csv", full.names = TRUE)
    stopifnot(length(tfiles) == length(sfiles))
    n_items <- length(tfiles)

    ### Will eventually need to allow for methods not written in R.  Could at least
    ### require a standardized R wrapper, which can call out to whatever code.

    # Evaluates functions but does not run anything
    source(paste(methodlabel, "script.R", sep="/"), chdir=T)
    # Now there should be a function RunMyMethod(treefile, traitfile)

    ans <- mclapply(1:n_items, function(i) RunMyMethod(tfiles[i], sfiles[i]), mc.cores=detectCores())
    writeme <- data.frame("Method" = methodlabel, "Element" = elementlabel, "Item" = 1:n_items, "Result" = unlist(ans), stringsAsFactors=F)
    write.table(writeme, file=paste("Results/", methodlabel, "_", elementlabel, ".csv", sep=""), row.names=F, sep=",", quote=F)
}

# run_method("M-25339", "E-90821")
# run_method("M-25339", "E-17888")
# run_method("M-82344", "E-17888")
# run_method("M-82344", "E-90821")
# run_method("M-82344", "E-29543")
# run_method("M-25339", "E-29543")
