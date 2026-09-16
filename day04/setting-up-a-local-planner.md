# CS502K: Symbolic Artificial Intelligence

## Setting Up a Local Planner

**Prof. Felipe Meneguzzi**

In this guide, you will learn how to install and use planners that solve problems specified in PDDL, and a validator that checks the plans they return.
PDDL is a widely-used language for representing planning problems in artificial intelligence.
Different planners can be used to find solutions to PDDL problems, and this guide will walk you through the steps.

You should do this before the week 12 practical, since each planner is a download and a compile rather than a five minute job.
Question 4 of Tutorial 4 uses the validator, question 6 requires a planner whose search and heuristic you can set yourself, and Assessment 3 requires the same.
For the rest of the tutorial, the online editor at <https://editor.planning.domains> is enough, and it is quicker to start with.

## Prerequisites

Before you begin, ensure you have a way to locally edit PDDL files on your system.
This can be achieved by something like a text editor, or more preferably, this should be done using VSCode with the [PDDL plugin](https://marketplace.visualstudio.com/items?itemName=jan-dolejsi.pddl) enabled.

You will also need a C++ compiler, CMake, GNU make and Python 3 for the planners built from source, and a Java runtime for those that run on the JVM.
Each section below lists what it needs.

## Planner Selection

### 1. Fast Downward

Fast Downward is a domain-independent classical planning system.
It can deal with general deterministic planning problems encoded in the propositional fragment of PDDL2.2, which covers everything in this course apart from the numeric extensions in section 3.

The heuristic it was originally built around, the causal graph heuristic, computes its estimate from a hierarchical decomposition of the planning task.
This heuristic is very different from traditional HSP-like heuristics based on ignoring negative interactions of operators.
Fast Downward has since accumulated a large library of heuristics and search algorithms, and you select among them when you run it.

It is known for its speed and ability to solve a wide range of planning problems.
It is one of the most popular planning systems in use today, and it is used by researchers and practitioners in a variety of fields, including robotics, logistics, and scheduling.
Its search algorithm and heuristic are chosen on the command line rather than fixed at compile time, which is what question 6 of Tutorial 4 asks you to exploit.

---

### Installation

The Fast Downward developers test the following combinations, so matching one of them keeps you on a supported path.
Newer versions generally work; substantially older ones tend to fail partway through the build with a compiler error rather than a clear message.

| Operating system | Python | C++ compiler | CMake |
| --- | --- | --- | --- |
| Ubuntu 24.04 | 3.10 | GCC 14 or Clang 18 | 3.31 |
| Ubuntu 22.04 | 3.10 | GCC 12 | 3.31 |
| MacOS 14 and 15 | 3.14 | AppleClang 15 or 17 | 4.2 |
| Windows 10 | 3.9 | Visual Studio 2022 | 3.31 |

**Linux/MacOS:** you need a C++ compiler, CMake and GNU make.
To run the planner, you also need Python 3.

On Debian/Ubuntu, the following should install all these dependencies:
```bash
sudo apt install cmake g++ make python3 git
```

On MacOS, the compiler and make come with the Xcode command line tools:
```bash
xcode-select --install
brew install cmake
```

You will also be required to clone the `downward` repository:
```bash
git clone https://github.com/aibasel/downward.git
```

To build the planner:
```bash
cd path/to/downward
./build.py
```

**Windows:** install [Visual Studio 2022](https://visualstudio.microsoft.com/downloads/), [Python](https://www.python.org/downloads/windows/), and [CMake](https://cmake.org/download/).
During the installation of Visual Studio, the C++ compiler is not installed by default, so select the `Desktop development with C++` workload when prompted.

---

### Compiling on Windows

Windows does not interpret the shebang in Python files, so you have to call `build.py` as `python3 build.py` (make sure `python3` is on your `PATH`).
Also note that options are passed without `--`, e.g., `python3 build.py build=release`.

Note that compiling from the terminal is only possible with the right environment.
The easiest way to get such an environment is to use the `Developer PowerShell for VS 2022` or `Developer PowerShell`.

Alternatively, you can [create a Visual Studio Project](https://www.fast-downward.org/ForDevelopers/CMake#Custom_Builds), open it in Visual Studio and build from there.
Visual Studio creates its binary files in subdirectories of the project that our driver script currently does not recognise.
If you build with Visual Studio, you have to run the individual components of the planner yourself.

If you are not familiar with the individual compilation and installation steps for Windows, and have access to the Windows Subsystem for Linux (WSL), please use that instead and follow the instructions above.

---

### Testing Your Installation

To test your build, `cd` into the directory containing your built `fast-downward.py` file, and run:
```bash
./fast-downward.py misc/tests/benchmarks/miconic/s1-0.pddl --search "astar(lmcut())"
```
If a solution is found, then your installation is complete, and you can now use Fast Downward on any PDDL problem it can handle.

Note that this command names only a problem file.
Fast Downward looks for `domain.pddl` beside it when no domain is given, which is a convenience worth knowing, and not one to rely on: name both files whenever they are not in the same directory.

---

### Usage

To use the Fast Downward planner, you can use the following commands.
Please note that each command _should_ return you a plan, assuming that your problem and domain files are valid, and that your goal state can be achieved.
```bash
# landmark-cut heuristic, optimal
 ./fast-downward.py domain.pddl task.pddl --search "astar(lmcut())"

# blind heuristic, optimal, and the uninformed baseline to compare against
 ./fast-downward.py domain.pddl task.pddl --search "astar(blind())"

# iPDB heuristic with default settings
 ./fast-downward.py domain.pddl task.pddl --search "astar(ipdb())"

## using FF heuristic and context-enhanced additive heuristic (previously: "fFyY")
 ./fast-downward.py domain.pddl task.pddl \
 --evaluator "hff=ff()" --evaluator "hcea=cea()" \
 --search "lazy_greedy([hff, hcea], preferred=[hff, hcea])"

## using FF heuristic (previously: "fF")
 ./fast-downward.py domain.pddl task.pddl \
 --evaluator "hff=ff()" \
 --search "lazy_greedy([hff], preferred=[hff])"

## using context-enhanced additive heuristic (previously: "yY")
 ./fast-downward.py domain.pddl task.pddl \
 --evaluator "hcea=cea()" \
 --search "lazy_greedy([hcea], preferred=[hcea])"
```
Note that the fast-downward planner has a few key components:
- `domain.pddl` - this is the domain file relating to the problem you wish to solve.
- `task.pddl` - this is the problem that runs on the domain.
-- If either (or both) of your domain or problem files happen to be in other directories, you will have to provide the path to them.
- `--search "..."` provides the search algorithm with specific settings. For example, `--search "astar(lmcut())"` indicates the use of the A* search with the landmark-cut heuristic.
- `--plan-file myplan.plan` writes the plan where you want it. Without it, the plan goes to `sas_plan` in the current directory.

The first three of the configurations above are the ones question 6 of Tutorial 4 asks you to compare.
Each run prints the plan cost, the number of expanded states and the search time, so record those three numbers as you go rather than running everything twice.

Several common configurations also have short names, which are easier to remember and to report:
```bash
 ./fast-downward.py --alias seq-opt-lmcut domain.pddl task.pddl
 ./fast-downward.py --alias lama-first domain.pddl task.pddl
```
The first is the same search as `astar(lmcut())`, and the second is a strong satisficing default.
The full catalogue of heuristics and search algorithms is documented at <https://www.fast-downward.org/>.

---

### Troubleshooting

* If you changed the build environment, delete the `builds` directory and rebuild.
* If the translator stops with a Python traceback ending in `AssertionError: :fluents`, or another requirement name, then your `(:requirements ...)` line declares something Fast Downward does not accept. It checks what you declared rather than what you used, so a requirement you listed and never needed stops the build just as firmly as one you need and it lacks. Remove the requirements your domain does not use. The blocksworld domain in Tutorial 4 has exactly this problem, and question 5 asks you to deal with it.
* If the planner reports your problem unsolvable and you are confident that it is not, look for a precondition that can never hold, which is usually a fact missing from `(:init)` rather than an error in an action. Cut the goal down to something a single action could achieve and work back up from there; question 2 of Tutorial 4 shows the technique.
* **Windows:** If you cannot execute the Fast Downward binary in a new command line, then it might be unable to find a dynamically linked library.
  Use `dumpbin /dependents PATH\TO\DOWNWARD\BINARY` to list all required libraries and ensure that they can be found in your `PATH` variable.

---

### 2. VAL

VAL is a plan validator rather than a planner.
Given a domain, a problem and a plan, it reports whether each action's preconditions hold in the state it is applied to, and whether the resulting sequence of states satisfies the goal.
Where a plan fails, it names the step and the precondition that was not satisfied.

You need it because a planner only ever tells you that your domain admits a solution, and says nothing about whether your domain describes the world you meant.
A domain that is missing a precondition or a delete effect usually still returns a plan, often a shorter one than the correct model would produce, because the omission gives the planner a cheaper route to the goal.
Validating a plan step by step is how you find that, and question 4 of Tutorial 4 asks you to do it both by hand and with VAL.

---

### Installation

To save the hassle of compiling VAL, the developers publish binaries for Linux, Windows and MacOS through their continuous integration.
Follow the _Azure Pipeline_ badge at the top of the [VAL repository](https://github.com/KCL-Planning/VAL) README, open the most recent green build, and download the artifact for your operating system.

To build it from source instead, clone the repository:
```bash
git clone https://github.com/KCL-Planning/VAL.git
```

**Linux:** you need CMake, GNU make, a C++ compiler, and flex and bison for the parser.
```bash
sudo apt install cmake make g++ flex bison
cd path/to/VAL
scripts/linux/build_linux64.sh
```
The binaries can be found in `build/linux64/Release/bin`.

**MacOS:** the Xcode command line tools provide everything needed.
```bash
cd path/to/VAL
scripts/build_macos.sh
```
The binaries can be found in `build/macos64/Release/bin`.
Do not run `setup_flex_bison.sh` on MacOS, since the VAL README records that flex on MacOS generates a parser that does not compile; the generated parser checked into the repository is the one to use.

**Windows:** use the prebuilt binary, or build under WSL following the Linux instructions above.

---

### Usage

Several tools are built, and the one you want is `Validate`:
```bash
 Validate domain.pddl problem.pddl myplan.plan
```

A plan that executes correctly ends with the plan's value:
```
Successful plans:
Value: 3
```

A plan that does not names the step at which it failed, the precondition that was not satisfied, and what would have had to be true:
```
Checking next happening (time 2)
Plan failed because of unsatisfied precondition in:
(deliver cup-of-tea grandpa living-room)

Plan Repair Advice:
(deliver cup-of-tea grandpa living-room) has an unsatisfied precondition at time 2
(Set (in living-room) to true)
```

Adding `-v` reports every fact each action adds and deletes, which is what to use when a plan validates and you still believe the domain is wrong.

---

### Troubleshooting

* VAL reads the number in front of each action as a time stamp rather than as a step counter, and treats actions less than `0.01` apart as simultaneous. Two sequential actions timed `0.001` and `0.002` are therefore rejected with a message about a mutex violation rather than executed in order. Some planners and editors write plans in that format. If you see this, renumber the steps `1`, `2`, `3` and run it again. Plans produced by Fast Downward carry no time stamps and need no change.
* **MacOS:** If your compiler doesn't find flex or bison when building VAL, your include directories might be in a non-standard location. In this case you probably have to specify where to look for includes and libraries in VAL's
  Makefile (probably `/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr`).

---

### 3. ENHSP - Expressive Numeric Heuristic Planner

ENHSP is a forward heuristic search planner, but it is expressive in that it can handle:
1. Classical Planning
2. Numeric Planning with linear and non-linear expressions
3. Planning with discretised autonomous processes and events
4. Global constraints, which are the analogous of always constraints of PDDL

You only need ENHSP if your Assessment 3 domain has numeric state in it, such as fuel that drains, a capacity that fills, or a quantity compared against a threshold.
Fast Downward handles none of those, although it does handle `:action-costs`, so if all you want is for some actions to cost more than others then you already have what you need.
Nothing in Tutorial 4 requires ENHSP.

The planner reads in input a PDDL domain and problem file, and if you are lucky and your problem is not too complex, it provides you with a plan (a sequence of actions).
In the case of planning with processes, the plan is a time-stamped plan (associated to each action, you find the time at which that instance of the action has to be executed).
In dealing with autonomous processes, ENHSP discretises the problem (with a delta=1sec by default); so the plan is guaranteed to be valid only with respect to that discretisation.

The input language for the planner is PDDL.
PDDL is the standard de facto language to express planning problems.
The domain file expresses the signature of your predicates, functions and all the actions/processes/events available, in a parametrized way.
The problem file expresses the particular instance of the planning problem (e.g., what is the initial value of predicate A? What is the goal?).
For more information on PDDL I suggest you to start from [its wikipedia page](https://en.wikipedia.org/wiki/Planning_Domain_Definition_Language), and follow the links.
ENHSP supports PDDL 2.1 in particular, and PDDL+ (for the support of autonomous processes) and also events (only recently introduced).
We also allow to employ global constraint as a direct construct of the language (via the :constraint syntax).

The planner has been developed taking ideas from different papers (heuristics, decoupled deltas for discretisation):
E. Scala, P. Haslum, S. Thiebaux: **Heuristics for Numeric Planning via Subgoaling**, IJCAI 2016
E. Scala, P. Haslum, S. Thiebaux, M. Ramirez, **Interval-Based Relaxation for General Numeric Planning**, ECAI 2016
E. Scala, P. Haslum, D. Magazzeni, S. Thiebaux: **Landmarks for Numeric Planning Problems**, IJCAI 2017
M. Ramirez, E. Scala, P. Haslum, S. Thiebaux: **Numerical Integration and Dynamic Discretization in Heuristic Search Planning over Hybrid Domains** in arXiv
D. Li, E. Scala, P. Haslum, S. Bogomolov **Effect-Abstraction Based Relaxation for Linear Numeric Planning** In IJCAI 2018

The planner builds on the PPMaJaL library, which can be found [here](https://gitlab.com/enricos83/PPMAJAL-Expressive-PDDL-Java-Library).
PPMaJaL provides parsing, data structures, heuristics and search engine for ENHSP.

---

### Installation

ENHSP runs on the JVM, which makes it the least troublesome of the three to install.
You shall be required to have **at least** Java 15 for the planner to work correctly.
Versions can be found on the [Oracle](https://www.oracle.com/uk/java/technologies/downloads/) page, and `openjdk` from your package manager works equally well.
Install whichever distribution and version you require for your operating system.

Build the planner with the `compile` script in the repository, and not with Gradle:
```bash
git clone https://gitlab.com/enricos83/ENHSP-Public.git
cd ENHSP-Public
./compile
```
This produces `enhsp-dist/enhsp.jar`.

---

### Usage

The planner can be run by using the following command:
```bash
java -jar path/to/enhsp/enhsp.jar -o /path/to/domain/<domain_file> -f /path/to/problem/<problem_file>
```
Should you wish to run the planner with specific search options, you can add options to it:
```bash
java -jar path/to/enhsp/enhsp.jar -o /path/to/domain/<domain_file> -f /path/to/problem/<problem_file> -planner "<configuration>"
```
Where `<configuration>` can be replaced with one of `"sat" "opt" "aibr" "lm_opt" "sat-hmrp" "sat-hmrph" "sat-hmrphj" "sat-hadd" "sat-hradd" "sat-aibr" "sat-haddabs" "opt-hmax" "opt-hrmax" "opt-hlm" "opt-hlmrc"`.
Those beginning `opt` search for an optimal plan and those beginning `sat` for any plan, so they are the two ends of the comparison question 6 of Tutorial 4 asks about, in a different planner.
The configurations are documented on the [ENHSP site](https://sites.google.com/view/enhsp/), which is the authority on them rather than this guide.

If you are finding that you are running out of heap space, feel free to add the maximum memory allocation flag to your command.
`5G` is 5GB, `512M` would be 512MB, etc.
```bash
java -Xmx5G -jar ....
```

---

### If You Cannot Get a Planner Built

Do not lose marks to a toolchain problem.
If you are on Windows, try WSL first, since most of the build failures reported on this course have been native Windows builds.
Where a prebuilt binary exists, as it does for VAL, take it.
Where it does not, prefer a planner that runs on the JVM, such as ENHSP above.
You can also use [planutils](https://github.com/AI-Planning/planutils), which installs several planners in a container and saves you fighting each toolchain separately.

The specification for Assessment 3 lists the planners you may use for that assessment, classical, hierarchical and non-deterministic, with a note on what each provides and how difficult it is to install.
Read that before choosing, since the choice itself is assessed.

If you are stuck, ask during the practical rather than in the final week.

## Acknowledgments

This material was adapted from the [FastDownward](https://github.com/aibasel/downward), [VAL](https://github.com/KCL-Planning/VAL) and [ENHSP](https://gitlab.com/enricos83/ENHSP-Public) repositories.
VAL is by Maria Fox, Derek Long, Richard Howey and Stephen Cresswell.
