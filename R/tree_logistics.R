#' Visualize a tree.
show.tree <- function(phy, title = NA, states = c(0, 1), adj = c(0.5, 0.5), 
                      tip.colors = c("#440154FF", "#35B779FF"))
{
    if ("hist" %in% attributes(phy)$names)
    {
        h <- history.from.sim.discrete(phy, states)
        if (length(states) > 2)
            tip.colors <- rainbow(length(states))
        plot(h, phy, cols=tip.colors, cex=0.8, show.tip.label=F,
             show.node.state=F, no.margin=T)
    } else {
        plot(phy, show.tip.label=F, no.margin=T)
        tiplabels(pch=19, frame="n", adj=adj, cex=0.8,
                  col=tip.colors[phy$tip.state[phy$tip.label]+1])
    }

    if (!is.na(title))
        title(title, line=-1)
}

#' Print each tree to a page of a pdf file.
plot.trees <- function(phy.all, filename = "trees.pdf", 
                       states = c(0, 1), adj = c(1,0.5))
{
    pdf(filename, width=8.5, height=11)
    for (i in seq_along(phy.all))
        show.tree(phy.all[[i]], zfill(i, 3), states, adj)
    quiet <- dev.off()
}

#' Fill with leading zeros to get an n-digit character string.
# http://tolstoy.newcastle.edu.au/R/help/00a/1076.html
zfill <- function(x, n)
{
    nc <- nchar(x)
    zeros <- paste(rep(0, n), collapse = "")
    paste(substring(zeros, nchar(x) + 1, n), substring(x, 1, nchar(x)),
          sep = "")
}

#' Create filename for tree.
name.treefile <- function(Z)
    paste("t", Z, ".tre", sep="")

#' Create filename for states.
name.statefile <- function(Z)
    paste("s", Z, ".csv", sep="")

#' Write files for each tree.
# Create tNNN.tre for tree and sNNN.csv for states.
write.trees <- function(phy.all, do.tree = TRUE, do.states = TRUE)
{
    for (i in seq_along(phy.all))
    {
        phy <- phy.all[[i]]
        Z <- zfill(i, 3)
        if (do.tree)
            write.tree(phy, file=name.treefile(Z))
        if (do.states)
            write.table(phy$tip.state, file=name.statefile(Z),
                        col.names=F, sep=",", quote=F)
    }
}

#' Read in tree file and states file.
read.tree.states <- function(Z)
{
    phy <- read.tree(name.treefile(Z))
    tip <- read.csv(name.statefile(Z), header=F, as.is=T)
    tip <- structure(tip$V2, names=tip$V1)
    phy$tip.state <- tip[phy$tip.label]

    return(phy)
}

#' Make root age equal to 1
scale.age.to.1 <- function(p)
{
    p$edge.length <- p$edge.length / max(branching.times(p))
    return(p)
}

#' Remove identifying information from tree number x
wipe.tree <- function(x)
{
    Z <- zfill(x, 3)
    phy <- read.tree.states(Z)
    # ensures tip.state is in the same order as tip.label

    phy$node.label <- NULL

    # standard tip names
    new.names <- paste("tip", 1:Ntip(phy), sep="")
    names(new.names) <- phy$tip.label
    phy$tip.label <- new.names[phy$tip.label]
    names(phy$tip.state) <- phy$tip.label

    write.tree(phy, file=name.treefile(Z))
    write.table(phy$tip.state, file=name.statefile(Z),
                col.names=F, sep=",", quote=F)
}

#' Copy tree files from another directory
copy.treefiles <- function(X)
{
	treefiles <- list.files(paste("../set", X, sep=""), "^t[0-9]{3}[.]tre$",
						    full.names = TRUE)
	# treefiles <- list.files("../setSKY", "^t[0-9]{3}[.]tre$", full.names = TRUE)
	junk <- file.copy(treefiles, ".")
}
