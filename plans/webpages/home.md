# Welcome to the Phylogenetic Comparative Methods Benchmark database

The purpose of PhyCoMB is to facilitate robustness testing of phylogenetic comparative methods.
We accumulate and curate testing datasets that challenge the methods used for learning about macroevolution from phylogenies.

(Note: The eventual vision is for PhyCoMB to apply to many different macroevolutionary questions.
For now, however, we are focusing just on the question of an association between a discrete-valued trait and rates of lineage diversification.)

# How should I use PhyCoMB?

PhyCoMB is for both methods users and methods developers.
You can interact with PhyCoMB as either a viewer or a contributor.

  * [View how various methods perform across many testing datasets](view.md)
  * [Contribute new testing datasets](link_here_eventually)
  * [Contribute new methods](link_here_eventually)

# Why benchmarking?

A paper introducing a new phylogenetic comparative method generally includes essential simulations that examine its power and bias and reveal the parameter space in which it will be most beneficial.
These simulations typically follow the assumptions of the underlying model.
Poor behavior, however, may arise when those assumptions are not met.
Because all empirical datasets have been shaped by processes outside the assumptions of any model, methods should routinely be tested in many situations beyond their specific focus.
Testing that reveals strengths and weaknesses before methods are widely adopted could bring greater stability to the field.
In practice, it is time-consuming or impossible for a single developer to craft diverse testing datasets that encompass the biological phenomena likely to "break" his/her new method.
Benchmarking removes some of that burden.
We hope that with an existing suite of datasets on which methods can be run, robustness testing and comparing performance across methods will become routine.

Visit [PhyCoMB on GitHub](https://github.com/phylosdd/PhyCoMB) for development and contact information.

Funding is provided by the joint program of the US National Science Foundation (NSF; [DEB-1655478](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1655478)) and the US-Israel Binational Science Foundation ([BSF](http://www.bsf.org.il/)).
