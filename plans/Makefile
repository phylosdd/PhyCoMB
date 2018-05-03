all: main.pdf

main.pdf: main.tex intro.tex proposal.tex workflows.tex views.tex tables.tex downloads.tex
	pdflatex main.tex
	bibtex main
	pdflatex main.tex
	pdflatex main.tex

clean:
	rm -f *.aux *.bbl *.blg *.log
