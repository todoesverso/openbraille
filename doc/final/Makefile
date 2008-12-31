# Simple Makefile for documentation

############
# Commands #
############
LATEX=latex
PDFLATEX=pdflatex

##############
# Extensions #
##############
TEXAUX=*.out *.aux *.lof *.lot *.log *.toc *.glo
OUTS=*.dvi *.pdf
###########
# Targets #
###########

default: all

all: main.pdf main.dvi

dvi: main.dvi

pdf: main.pdf

main.pdf: main.tex
	$(PDFLATEX) main.tex ;\
	$(PDFLATEX) main.tex ;\
	$(PDFLATEX) main.tex


main.dvi: main.tex 
	$(LATEX) -interaction=nonstopmode main.tex ;\
	$(LATEX) -interaction=nonstopmode main.tex ;\
	$(LATEX) -interaction=nonstopmode main.tex

purge: clean
	rm -f $(OUTS)
clean: 
	rm -f $(TEXAUX)

.PHONY: default all dvi pdf clean purge
