## Makefile - Makefile for the uw-wkrpt package.
## Copyright (C) 2003  Simon Law
##
##   This program is free software; you can redistribute it and/or modify
##   it under the terms of the GNU General Public License as published by
##   the Free Software Foundation; either version 2 of the License, or
##   (at your option) any later version.
##
##   This program is distributed in the hope that it will be useful,
##   but WITHOUT ANY WARRANTY; without even the implied warranty of
##   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##   GNU General Public License for more details.
##
##   You should have received a copy of the GNU General Public License
##   along with this program; if not, write to the Free Software
##   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
##

# Set the package name
PACKAGE = uw-wkrpt

# Use pdfLaTeX for best results
LATEX = pdflatex
LATEX2PDF = $(LATEX) --output-format=pdf

# MakeIndex parameters
MAKEINDEX = makeindex
GIND = gind.ist
GGLO = gglo.ist

# Bibliography
BIBTEX = bibtex

TEXI2PDF = PDFLATEX="$(LATEX2PDF)" texi2dvi -l latex -p

TEXFILES=\
         $(PACKAGE)*.aux\
         $(PACKAGE)*.bbl\
         $(PACKAGE)*.blg\
         $(PACKAGE)*.cls\
         $(PACKAGE)*.drv\
         $(PACKAGE)*.glo\
         $(PACKAGE)*.gls\
         $(PACKAGE)*.idx\
         $(PACKAGE)*.ilg\
         $(PACKAGE)*.ind\
         $(PACKAGE)*.lof\
         $(PACKAGE)*.lot\
         $(PACKAGE)*.log\
         $(PACKAGE)*.pdf\
         $(PACKAGE)*.sty\
         $(PACKAGE)*.toc

.PHONY : all examples pdf clean

all : $(PACKAGE).cls $(PACKAGE).pdf ;

pdf : $(PACKAGE).pdf ;

examples : $(PACKAGE).cls $(PACKAGE)-se.pdf   ;

%.cls : %.ins %.dtx
	$(LATEX) $<

%.pdf : %.tex $(PACKAGE).cls
	$(TEXI2PDF) $<

$(PACKAGE).pdf : $(PACKAGE).dtx $(PACKAGE).cls
	$(TEXI2PDF) $<
	$(MAKEINDEX) -s $(GIND) $(PACKAGE).idx
	$(MAKEINDEX) -s $(GGLO) -o $(PACKAGE).gls $(PACKAGE).glo
	$(LATEX2PDF) $<
	$(LATEX2PDF) $<

clean :
	rm -f $(TEXFILES) uw-ece-workreport.cls uw-ece-workreport.log
