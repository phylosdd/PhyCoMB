This is a set of example data for figuring out the needed PhyCoMB database structure.

Most of this was assembled using code that I think will be useful for future contributors.
It is in the [`phycombR`](https://github.com/phylosdd/PhyCoMB/tree/master/phycombR) package (which is currently one directory above this one).

Two sorts of content are mixed together here, though I tried to keep them as separate as possible.
(1) Content that should be included in the real database/website.
(2) Content that I needed to make (1), or for (1) to make sense.
Most of (2) is in `phycombR`, but it also includes some things noted below.


# Trees

Each directory named `T-xxxxx` is a _Tree_ object.
Each `.tre` file in there is a Newick file for a single tree.
The way those `.tre` files were made is explained in the `script.R` file.
I think everything in each `T-xxxxx` should be included in the database structure.


# Traits

Each directory named `A-xxxxx` is a _Trait_ object.
Each `.csv` file in there is one set of trait values per species.
The way those `.csv` files were made is explained in the `script.R` or `source.txt` file.
I think everything in each `A-xxxxx` should be included in the database structure.


# Elements

Each directory named `E-xxxxx` is a _Element_ object.
It is composed of one _Tree_ and one _Trait_.
These could simply be links in the database, except for one complication: the number of items in the given `T-xxxxx` and `A-xxxxx` might not match (in number or name).
It therefore seemed best to copy over items from the corresponding `T-xxxxx` and `A-xxxxx` directories, renaming and duplicating as necessary.
The `assemble.R` script does this.
For the real database, I think we might not need to store all these redundant `.tre` and `.csv` files---they could be generated by a script when a user is interacting with the downloaded database.


# Methods

todo


# Results

todo


# Other stuff

The `tables.html` file provides information on the various levels of organization:

  * Mapping between _Trees_, _Traits_, and _Elements_.  This is the same information as in the `assemble.R` files.
  * Definition of _ReferenceSets_ and _BenchmarkSets_ and their relations to _Elements_.  This information is not present elsewhere in this example data.
  * Metadata for the components (NumItems, Type, Comment, etc.)  I could fill this out more thoroughly if it would help.

The `report.R` file is a placeholder for now.
I could fill it in to produce summaries like it would be nice for users to browse on the database website eventually.

In `downloads/` are files that were obtained from elsewhere.
They are not directly useable for our analyses, but they are the raw material for some Trees or Traits.
I think they don't need to be in the database structure if they can be obtained by a script when a user is interacting with the downloaded database.

The `run.R` script is what I used to run each _Method_ on each _Element_.
Probably no need for this in the database structure.