# Unique names.
# Don't want to number in order, to keep things more blind.
# Delete from labels.txt when used.

# (would have been more fun to use three-letter words)
# http://www.wordfind.com/3-letter-words/ http://www.tnellen.com/ted/scrabble/scrabble_words_3.html

set.seed(0)

aaa <- replicate(1050, paste(sample(LETTERS, 3, replace = TRUE), collapse = ""))
aaa <- unique(aaa)[1:1000]

cat(aaa, file = "labels.txt", sep = "\n")
