#!/bin/bash

### The purpose of this script is to download all the materials needed to
### generate test datasets that are present in PhyCoMB.

# Huang D, Roy K (2015) The future of evolutionary diversity in reef corals.
#    Philosophical Transactions of the Royal Society B 370(1663): 20140010.
#    https://doi.org/10.1098/rstb.2014.0010
#    https://doi.org/10.5061/dryad.178n3
# File contains posterior set of 1000 trees.

wget http://datadryad.org/bitstream/handle/10255/dryad.66418/Huang%26Roy_Supertree.tre
mv Huang\&Roy_Supertree.tre HuangRoy2015_CoralSupertree.nex
