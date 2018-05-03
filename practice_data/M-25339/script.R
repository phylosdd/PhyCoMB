require("phycombR")
require("diversitree")

RunMyMethod <- function(tfile, sfile)
{
    phy <- read_tree_states(treefile=tfile, statefile=sfile)
    ans <- run_mcmc(phy)
    summarize(ans)
}

run_mcmc <- function(phy)
{
    lnL <- make.bisse(phy, phy$tip.state)
    n_par <- length(argnames(lnL))
    age <- max(branching.times(phy))
    prior <- make.prior.exponential(age)

    # Pilot chain: determine mcmc parameters, remove burnin

    par_start <- rep(age/2, n_par)
    nsteps <- 250
    burnin <- 50

    ans <- mcmc(lnL, par_start, nsteps=nsteps, w=age, upper=age*100,
                prior=prior, print.every=0)
    init <- suggest_mcmc_params(ans[-seq(burnin),])

    # Real chain

    nsteps <- 1000

    ans <- mcmc(lnL, init$par_start, nsteps=nsteps, w=init$w,
                upper=init$upper, prior=prior, print.every=0)

    # write.csv(ans, outfile, row.names=F)
    return(ans)
}

# Convert MCMC results into a single number
summarize <- function(ans)
{
    r_diff <- with(ans, (lambda0 - mu0) - (lambda1 - mu1))
    any(c(sum(r_diff > 0), sum(r_diff < 0)) / length(r_diff) > 0.975)
}

# Given some mcmc samples, suggest control parameters
suggest_mcmc_params <- function(ans)
{
    i_par <- seq(from=2, to=ncol(ans)-1)

    w <- round(apply(ans[,i_par], 2, max) - apply(ans[,i_par], 2, min), 2)
    upper <- round(apply(ans[,i_par], 2, max) * 5, 2)
    par_start <- as.numeric(ans[which.max(ans$p), i_par])

    return(list(w=w, upper=upper, par_start=par_start))
}
