
REPORT_FOLDER = rapport/
#SLIDES_FOLDER = slides/
MATLAB_FOLDER = Codes/
PDFVIEWER=xdg-open # Default pdf viewer - GNU/Linux
#PDFVIEWER=evince
REPORT_BASE_NAME = rapport
REPORT_MAIN_NAME=$(REPORT_FOLDER)$(REPORT_BASE_NAME)
REPORT_PDF_NAME=$(REPORT_MAIN_NAME).pdf
IMAGES = $(REPORT_FOLDER)images/*.eps

# You want latexmk to *always* run, because make does not have all the info.
.PHONY: $(PDF_NAME)

# pdf to be opened by your preferred pdf viewer
default: show

all: $(PDF_NAME)

# MAIN LATEXMK RULE

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interactive=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

# Other depences are gessed automatically by latexmk
# see http://tex.stackexchange.com/questions/40738/how-to-properly-make-a-latex-project
$(REPORT_PDF_NAME): $(REPORT_MAIN_NAME).tex $(IMAGES)
	latexmk -pdf -pdflatex="pdflatex -shell-escape -enable-write18" \
	  -use-make -jobname=$(REPORT_MAIN_NAME) $(REPORT_MAIN_NAME).tex

clean:
	latexmk -CA

show: $(REPORT_PDF_NAME)
	$(PDFVIEWER) $(REPORT_PDF_NAME)

release: all
	smartcp -v config.yml
