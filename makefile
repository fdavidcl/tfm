main.pdf: main.tex titlepage.tex reference/reference.tex inffus/AutoencoderReview.tex
	pdflatex --shell-escape main.tex
	bibtex main
	pdflatex --shell-escape main.tex
	pdflatex --shell-escape main.tex

reference/reference.tex: reference/join.rb
	cd reference; ruby join.rb

clean:
	rm -f main.pdf *.aux *.blg *.log *.bbl *.toc *.out
