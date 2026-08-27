# Build the LaTeX tutorials in two variants from one source.
#
#   make            student PDFs, then verify none of them contains an answer
#   make solutions  instructor PDFs, suffixed -solutions
#   make all        both
#   make verify     re-run the leak check on the student PDFs
#   make clean      remove latexmk auxiliary files
#   make distclean  also remove the PDFs
#
# The variant is chosen on the command line, never in the source. Each tutorial
# guards its \answer macro with \ifdefined\showanswers, and only the solutions
# rule below defines it. Editing the source to see the answers is what leaked
# them into a student PDF before, so there is nothing left to edit.

TUTORIALS := day01/CS502K-tutorial-week-1 day02/CS502K-tutorial-week-2

STUDENT   := $(addsuffix .pdf,$(TUTORIALS))
SOLUTIONS := $(addsuffix -solutions.pdf,$(TUTORIALS))

LATEXMK := latexmk -pdf -cd -silent -interaction=nonstopmode

.PHONY: all student solutions verify clean distclean
.DELETE_ON_ERROR:

student: $(STUDENT)
	@$(MAKE) --no-print-directory verify

solutions: $(SOLUTIONS)

all: student solutions

# The solutions rule must come first: for foo-solutions.pdf make prefers the
# pattern that yields the shorter stem, which is this one.
%-solutions.pdf: %.tex
	$(LATEXMK) -jobname=$(notdir $*)-solutions \
	  -pdflatex='pdflatex %O "\def\showanswers{}\input{%S}"' $<

%.pdf: %.tex
	$(LATEXMK) $<

# The backstop. A student PDF that contains the string "Answer:" is a leak,
# regardless of how it got there, so fail the build rather than ship it.
verify: $(STUDENT)
	@status=0; \
	for pdf in $(STUDENT); do \
	  if [ ! -f "$$pdf" ]; then continue; fi; \
	  if ! command -v pdftotext >/dev/null 2>&1; then \
	    echo "verify: pdftotext not found, cannot check $$pdf" >&2; exit 1; \
	  fi; \
	  n=$$(pdftotext "$$pdf" - | grep -c 'Answer:' || true); \
	  if [ "$$n" -gt 0 ]; then \
	    echo "LEAK: $$pdf contains $$n answer(s)" >&2; status=1; \
	  else \
	    echo "ok: $$pdf"; \
	  fi; \
	done; \
	exit $$status

clean:
	@for t in $(TUTORIALS); do \
	  latexmk -cd -c $$t.tex >/dev/null; \
	  latexmk -cd -c -jobname=$$(basename $$t)-solutions $$t.tex >/dev/null; \
	done

distclean: clean
	rm -f $(STUDENT) $(SOLUTIONS)
