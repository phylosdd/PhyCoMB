[PhyCoMB logo/title](home.md)

# View Method Performance

There are three steps to generate a report of how well specific phylogenetic comparative methods perform on our testing datasets:

  1. **Task:** select a focal macroevolutionary question
  2. **Methods:** select analysis techniques
  3. **Elements:** select testing datasets

_[To Michal:
The contents of the later sections depend on the selections in the earlier sections.
So each section should only appear after selections have been made above it.
]_

## 1. Select Task

Specify the macroevolutionary question of interest, or the "task" that methods will undertake.
Choose one of the following:

[] | ID | Name | Num Methods
-- | -- | -------- | -----------
x | Task-SDD-test   | Discrete trait and lineage diversification: Is there an association? | 2
. | Task-SDD-amount | Discrete trait and lineage diversification: How large is the effect? | 0

_[To Michal:
The preceding table should not be hard-coded like my example above.
The first column should be something like a radio button, so that the user can select one Task.
The ID and Name columns should be filled in from the information about Tasks in the database.
The Num Methods column should be determined by the number of Methods in the database for that Task.
For our practice data, currently only Task-SDD-test is applicable.
]_

## 2. Select Methods

Specify which methods to focus on.
Choose one or more of the following:

[x] | ID | Name | Model-based | Num Elements
--- | -- | ---- | ----------- | ------------
x | M-25339 | 95% CI from BiSSE MCMC | yes | 4
x | M-82344 | original FiSSE | no | 5

_[To Michal:
Again, the preceding table should not be hard-coded like my example above.
The Methods that are shown should be only those that apply to the selected Task.
Clicking an ID number should link to a page providing the full information on that Method.
The first column should be something like checkboxes, so that the user can select one or more Methods; there will eventually be a lot of Methods, so the [x] at the top makes it easy to "select all" or "select none".
The Num Elements column should be determined by the number of Elements for which the Method has a result for this Task.
The rest of the columns should be filled in from the information about Methods in the database.
We will definitely want ID and Name, and probably some other columns too, like Model-based, Keywords, or Contributor (see the list of fields in Section 6.7).
]_

## 3. Select Elements

Specify which testing datasets to include.

- [x] Benchmark Set: a pre-defined set of testing datasets
- [ ] Reference Sets: choose your own types of testing datasets
- [ ] Particular Elements: choose only the specific testing datasets you want

_[To Michal:
Only one of the three options should be selected.
The Benchmark radio button should be selected by default.
That's enough for now, but eventually the other options will be useful.
Below are examples of what would happen if the user selects the second or third.
]_

- [ ] Benchmark Set: a pre-defined set of testing datasets
- [x] Reference Sets: choose your own types of testing datasets
- [ ] Particular Elements: choose only the specific testing datasets you want

[ ] | ID | BenchmarkSet | Name | Num Elements
--- | -- | ------------ | ---- | ------------
. | R-10013 | | divergence time estimation with empirical trees | 1
. | R-23473 | Power | bisse sims, same param values, vary tree age | 1
. | R-31990 | | bisse assumptions are met | 1
. | R-49185 | FalsePositive | fast discrete neutral traits on empirical trees | 1
. | R-66447 | FalsePositive | slow continuous neutral traits on empirical trees | 1

_[To Michal:
I've filled in this table based on our practice data.
Clicking an ID number should link to a page providing the full information on that ReferenceSet (see the fields in Section 6.4).
The first column is for the user to select rows.
The last column should show the total number of Elements in the ReferenceSet.
]_

- [ ] Benchmark Set: a pre-defined set of testing datasets
- [ ] Reference Sets: choose your own types of testing datasets
- [x] Particular Elements: choose only the specific testing datasets you want

_[To Michal:
This option if for advanced users only.
It should show a text entry box where the user can provide the IDs of specific Elements, or upload a file containing those IDs.
There should also be a link to get a (very large) table of information about all the Elements---like the "Elements table" in the "search_all" view of the current website.
]_

## Get Report

_[To Michal:
A button should appear after everything above is selected.
When clicked, it takes the user to a new page with the Report, which would look like Figure 3.
From there, the user can click through to more detailed reports on each Method individually.
]_
