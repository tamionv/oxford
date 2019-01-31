full_solve.pdf: ex1.png ex4.png ex5.png ex6.png
	pdflatex full_solve.tex && open full_solve.pdf &

%.png : %.dot
	dot -Tpng $< > $@

.PHONY: full_solve.pdf
