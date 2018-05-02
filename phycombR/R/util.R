#' Fill with leading zeros to get an n-digit character string
#'
#' code is from http://tolstoy.newcastle.edu.au/R/help/00a/1076.html
#'
#' @param x The input string, which is to be padded
#' @param z The desired total length of the output string
#'
#' @return The string x preceded by (z-x) zeros.  Or if x is too long to pad, it is returned unchanged.
#'
#' @export
zfill <- function(x, z)
{
    nc <- nchar(x)
    if (z < nc)
        warning("String is already long enough.")
    zeros <- paste(rep(0, z), collapse = "")
    return(paste(substring(zeros, nchar(x) + 1, z), substring(x, 1, nchar(x)),
                 sep = ""))
}

#' Make random unique labels
#'
#' Generating random labels keeps testing more "blind" than numbering things in order.
#'
#' @param num The number of labels to create
#' @param len The length of each label
#' @param seed Passed to set.seed()
#' @param file The name of the file to which to write the labels
#'
#' @return A vector of labels
#'
#' @export
make_labels <- function(num = 100, len = 3, seed = NULL, file = NULL)
{
    if (!is.null(seed))
        set.seed(seed)

    aaa <- replicate(num*2, paste(sample(LETTERS, len, replace = TRUE), collapse = ""))
    aaa <- unique(aaa)[1:num]

    # (would have been more fun to use three-letter words)
    # http://www.wordfind.com/3-letter-words/ http://www.tnellen.com/ted/scrabble/scrabble_words_3.html

    if (!is.null(file))
    {
        cat(aaa, file = file, sep = "\n")
        message(paste("Wrote result to", file))
    }
    return(aaa)
}
