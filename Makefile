.PHONY: clean open doc

doc: report.tex report.bib
	latexmk -pdf $<

clean:
	latexmk -C
	rm -rf report.bbl
	rm -rf report.run.xml

open: doc
	open report.pdf
