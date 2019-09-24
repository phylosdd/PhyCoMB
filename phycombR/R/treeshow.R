### Not part of the package yet! ###

#' Visualize a tree.
show_tree <- function(phy, title = NA, states = c(0, 1), adj = c(0.5, 0.5), 
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
plot_trees <- function(phy.all, filename = "trees.pdf", 
                       states = c(0, 1), adj = c(1,0.5))
{
    pdf(filename, width=8.5, height=11)
    for (i in seq_along(phy.all))
        show.tree(phy.all[[i]], zfill(i, 3), states, adj)
    quiet <- dev.off()
}
