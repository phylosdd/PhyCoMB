suppressMessages(require(diversitree))
source("../../R/tree_logistics.R")
source("../../R/traits.R")

# trees are the same as another set
copy.treefiles("AJW")

# real state is A or B
# hidden state determines if A <-> B transitions are slow or fast
#     1: A, slow
#     2: A, fast
#     3: B, slow
#     4: B, fast

qmat <- matrix(0, nrow=4, ncol=4)
# few switches between "slow" and "fast" state:
qmat[1,2] <- qmat[3,4] <- qmat[2,1] <- qmat[4,3] <- 0.5
# symmetric trait change when "slow":
qmat[1,3] <- qmat[3,1] <- 0.1
# symmetric trait change when "fast":
qmat[2,4] <- qmat[4,2] <- 10
diag(qmat) <- -rowSums(qmat)

phy.all <- list()
set.seed(0)
for (i in 1:50)
{
    phy <- read.tree(name.treefile(zfill(i, 3)))
    phy$tip.state <- neutral.trait(phy, qmat, thresh=10, model="mkn", x0=1)
    phy.all[[i]] <- phy
}

plot.trees(phy.all, states=1:4)

phy.01 <- lapply(phy.all, multi.to.binary.states, 4)

write.trees(phy.01, do.tree=F)
plot.trees(phy.01, adj=c(0.508, 0.5))

junk <- lapply(1:50, wipe.tree)
