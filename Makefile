# Build the LaTeX tutorials in two variants from one source.
#
#   make            student PDFs and the day04 student archive, then verify
#   make solutions  instructor PDFs, suffixed -solutions, and the day04 solutions archive
#   make all        both
#   make archives   just the two day04 archives
#   make verify     re-run the leak check on the student PDFs
#   make clean      remove latexmk auxiliary files
#   make distclean  also remove the PDFs
#
# The variant is chosen on the command line, never in the source. Each tutorial
# guards its \answer macro with \ifdefined\showanswers, and only the solutions
# rule below defines it. Editing the source to see the answers is what leaked
# them into a student PDF before, so there is nothing left to edit.

TUTORIALS := day01/CS502K-tutorial-week-1 day02/CS502K-tutorial-week-2 \
             day03/CS502K-tutorial-week-3a day03/CS502K-tutorial-week-3b \
             day04/CS502K-tutorial-week-4

STUDENT   := $(addsuffix .pdf,$(TUTORIALS))
SOLUTIONS := $(addsuffix -solutions.pdf,$(TUTORIALS))

# Day 4 is the one tutorial whose handout is not just a PDF: the questions edit
# PDDL files, so the release is the PDF plus an archive of the skeletons, and
# the solutions release is the solutions PDF plus an archive of day04/solutions.
# Both archives go to MyAberdeen; the timed release is set there, not here.
DAY04_STUDENT_ZIP   := day04/tutorial-week-4-files.zip
DAY04_SOLUTION_ZIP  := day04/tutorial-week-4-solutions.zip
DAY04_STUDENT_SRC   := cup_of_tea blocksworld
# cup_of_tea/cheating/README.md is the worked answer to question 3, so it is
# excluded from the student archive and shipped with the solutions instead.
DAY04_STUDENT_EXCL  := '*.DS_Store' '*/.DS_Store' '*sas_plan*' '*.zip' \
                       'cup_of_tea/cheating/README.md'
DAY04_STUDENT_DEPS  := $(shell find day04/cup_of_tea day04/blocksworld -type f ! -name '.DS_Store' 2>/dev/null)
DAY04_SOLUTION_DEPS := $(shell find day04/solutions -type f ! -name '.DS_Store' 2>/dev/null)

LATEXMK := latexmk -pdf -cd -silent -interaction=nonstopmode

.PHONY: all student solutions archives verify verify-archive clean distclean
.DELETE_ON_ERROR:

student: $(STUDENT) $(DAY04_STUDENT_ZIP)
	@$(MAKE) --no-print-directory verify

solutions: $(SOLUTIONS) $(DAY04_SOLUTION_ZIP)

archives: $(DAY04_STUDENT_ZIP) $(DAY04_SOLUTION_ZIP)

# The student archive is the skeletons only. day04/solutions is deliberately not
# in DAY04_STUDENT_SRC, and verify-archive below fails the build if it ever
# appears there anyway.
$(DAY04_STUDENT_ZIP): $(DAY04_STUDENT_DEPS)
	@rm -f $@
	@cd day04 && zip -q -r $(notdir $@) $(DAY04_STUDENT_SRC) -x $(DAY04_STUDENT_EXCL)
	@$(MAKE) --no-print-directory verify-archive
	@echo "built: $@"

$(DAY04_SOLUTION_ZIP): $(DAY04_SOLUTION_DEPS)
	@rm -f $@
	@cd day04 && zip -q -r $(notdir $@) solutions cup_of_tea/cheating/README.md \
	  -x '*.DS_Store' '*/.DS_Store'
	@echo "built: $@"

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
verify: $(STUDENT) verify-archive
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

# The archive backstop, and the same idea as verify: a student archive that
# carries a reference solution is a leak however it got there. Two checks,
# because they fail differently. The first catches solutions/ being added to
# DAY04_STUDENT_SRC; the second catches somebody completing the skeleton in
# place and committing it, which no path check would notice.
verify-archive: $(DAY04_STUDENT_ZIP)
	@n=$$(unzip -Z1 $(DAY04_STUDENT_ZIP) | grep -c '^solutions/\|/solutions/' || true); \
	if [ "$$n" -gt 0 ]; then \
	  echo "LEAK: $(DAY04_STUDENT_ZIP) contains $$n file(s) from solutions/" >&2; exit 1; \
	fi; \
	c=$$(unzip -Z1 $(DAY04_STUDENT_ZIP) | grep -c 'cheating/README' || true); \
	if [ "$$c" -gt 0 ]; then \
	  echo "LEAK: $(DAY04_STUDENT_ZIP) contains cheating/README.md, which answers question 3" >&2; \
	  exit 1; \
	fi; \
	todo=$$(unzip -p $(DAY04_STUDENT_ZIP) cup_of_tea/domain.pddl | grep -c 'TODO' || true); \
	if [ "$$todo" -lt 2 ]; then \
	  echo "LEAK: cup_of_tea/domain.pddl in $(DAY04_STUDENT_ZIP) is not the skeleton" >&2; \
	  echo "      (expected the two TODO markers, found $$todo)" >&2; exit 1; \
	fi; \
	echo "ok: $(DAY04_STUDENT_ZIP)"

clean:
	@for t in $(TUTORIALS); do \
	  latexmk -cd -c $$t.tex >/dev/null; \
	  latexmk -cd -c -jobname=$$(basename $$t)-solutions $$t.tex >/dev/null; \
	done

distclean: clean
	rm -f $(STUDENT) $(SOLUTIONS) $(DAY04_STUDENT_ZIP) $(DAY04_SOLUTION_ZIP)
