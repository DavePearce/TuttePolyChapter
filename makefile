TARGET = PearceRoyle
DEPS = conclusion.tex implementations.tex krantz.cls performance.tex synopsis.tex

all: $(TARGET).pdf

%.pdf : %.tex $(DEPS)
	@for X in 1 2 3 ; do \
        ( echo "---------------- Latex ($$X) ----------------" && pdflatex  $< && bibtex $*) \
	done

# %.pdf : %.dvi
# 	@echo "---------------- dvipdf ----------------" && dvipdfm $<

# %.ps : %.dvi
# 	@echo "---------------- dvips ----------------" && dvips -f < $< > $@

clean:
	rm *.bbl *.aux *.dvi *.log *.ps *.pdf *~ *.blg *.bak
