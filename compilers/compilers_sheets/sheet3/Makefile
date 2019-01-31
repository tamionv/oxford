full_solve.pdf: ex3.png ex4.png
	pdflatex full_solve.tex && open full_solve.pdf &

ex3.png:
	dot -Tpng ex3.dot > ex3.png

ex4.png:
	dot -Tpng ex4.dot > ex4.png

.PHONY: ex3.png ex4.png full_solve.pdf
