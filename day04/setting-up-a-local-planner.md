# CS502K: Setting Up a Local Planner

**Prof. Felipe Meneguzzi**

This guide gets you a planner and a plan validator running on your own machine.
Do it **before the week 12 practical**, because it is a download and a compile rather than a five minute job, and because two things depend on it.

- **Tutorial 4, question 6** asks you to run the same problem under three planner configurations and compare them. The online editor cannot do that: it gives you one planner with settings you do not control.
- **Assessment 3** requires a planner you built and can configure yourself, and marks your choice of it.

For questions 1 to 5 of the tutorial the online editor at <https://editor.planning.domains> is perfectly adequate, and it is the quicker way to start.
Nothing below is needed to write PDDL. It is needed to run PDDL the way the assessments ask you to.

You will install two things:

| Tool | What it does | Needed for |
| --- | --- | --- |
| **Fast Downward** | Finds a plan for a domain and problem, under a search and heuristic you choose | Tutorial question 6, Assessment 3 |
| **VAL** | Takes a domain, a problem and a plan, and tells you which precondition fails at which step | Tutorial question 4 |

They answer different questions, and the second one is the one that finds your modelling bugs.
A planner tells you that your domain has a solution. It never tells you that your domain is wrong.

---

## 1. Fast Downward

Fast Downward is a domain-independent classical planner, and the one most planning research is built on.
It handles the propositional fragment of PDDL, which is everything in this course except the numeric extensions in section 3.

Its value to you is that the search algorithm and the heuristic are chosen on the command line rather than baked in, so the same domain and problem can be run under half a dozen genuinely different planners without recompiling anything.
That is what Tutorial 4 question 6 and Assessment 3 both ask you to exploit.

### Requirements

The Fast Downward developers test these combinations, so if you match one of them you are on a supported path:

| OS | Python | C++ compiler | CMake |
| --- | --- | --- | --- |
| Ubuntu 24.04 | 3.10 | GCC 14 or Clang 18 | 3.31 |
| Ubuntu 22.04 | 3.10 | GCC 12 | 3.31 |
| macOS 14 and 15 | 3.14 | AppleClang 15 or 17 | 4.2 |
| Windows 10 | 3.9 | Visual Studio 2022 | 3.31 |

Newer versions generally work. Substantially older ones often do not, and the failure shows up as a compiler error in the middle of the build rather than as a clear message.

### Installing the dependencies

**Debian or Ubuntu:**

```bash
sudo apt install cmake g++ make python3 git
```

**macOS:** install the Xcode command line tools, which bring the compiler and `make`:

```bash
xcode-select --install
brew install cmake
```

**Windows:** install [Visual Studio 2022](https://visualstudio.microsoft.com/downloads/) (the C++ compiler is *not* installed by default, so select the "Desktop development with C++" workload), [Python](https://www.python.org/downloads/windows/) and [CMake](https://cmake.org/download/).

If you have the Windows Subsystem for Linux, use it instead and follow the Debian instructions.
It is markedly less trouble than a native Windows build, and everything else in this course assumes a Unix shell.

### Building

```bash
git clone https://github.com/aibasel/downward.git
cd downward
./build.py
```

On Windows, Python does not read the shebang line, so call the script explicitly, and note that its options take no leading dashes:

```
python3 build.py build=release
```

Compiling from a plain Windows terminal will not work, because the compiler is not on the path.
Use the **Developer PowerShell for VS 2022** from the Start menu.

### Testing your build

From the `downward` directory:

```bash
./fast-downward.py misc/tests/benchmarks/miconic/s1-0.pddl --search "astar(lmcut())"
```

It should end with `Solution found.` and a plan.
If it does, you are finished with this section.

Note that this command names only a problem file.
Fast Downward will look for `domain.pddl` beside it, which is a convenience worth knowing and not something to rely on: name both files explicitly whenever they are not in the same directory.

### Running it on your own files

```bash
./fast-downward.py domain.pddl problem.pddl --search "astar(lmcut())"
```

The plan is written to `sas_plan` in the current directory, and `--plan-file myplan.plan` puts it somewhere else.
The `--search` argument is the interesting part, and these are the three configurations Tutorial 4 question 6 asks you to compare:

```bash
# optimal, uninformed. The baseline: A* with a zero heuristic, so uniform-cost search.
./fast-downward.py domain.pddl problem.pddl --search "astar(blind())"

# optimal, informed. A* with the landmark-cut heuristic.
./fast-downward.py domain.pddl problem.pddl --search "astar(lmcut())"

# satisficing. Greedy best-first search with the FF heuristic. Fast, and not optimal.
./fast-downward.py domain.pddl problem.pddl \
  --evaluator "hff=ff()" --search "lazy_greedy([hff], preferred=[hff])"
```

Every run prints the plan cost, the number of expanded states and the search time.
Those three numbers are what the comparison is made of, so record them as you go rather than rerunning later.

Common configurations also have short names, which are easier to remember and to report:

```bash
./fast-downward.py --alias seq-opt-lmcut domain.pddl problem.pddl   # same as astar(lmcut())
./fast-downward.py --alias lama-first domain.pddl problem.pddl      # a strong satisficing default
```

The full catalogue of heuristics and search algorithms is at <https://www.fast-downward.org/>.

---

## 2. VAL, the plan validator

VAL answers the question a planner cannot: given this domain, this problem and this plan, does the plan actually work, and if not, exactly where does it break?

You need it because the characteristic failure in PDDL modelling is a domain that is under-constrained.
A planner handed such a domain returns a plan, quickly, and often a shorter one than the correct model would produce, because you have accidentally given it a cheaper way to reach the goal.
Nothing warns you.
VAL will not tell you that your domain is wrong either, but it will tell you which precondition failed at which step, which is usually enough to find out.

### Getting it

The easy route is a prebuilt binary.
The [VAL repository](https://github.com/KCL-Planning/VAL) publishes binaries for Linux, Windows and macOS through its CI: follow the *Azure Pipeline* badge at the top of its README, open the most recent green build, and download the artifact for your platform.

To build it from source instead:

```bash
git clone https://github.com/KCL-Planning/VAL.git
cd VAL
```

**Debian or Ubuntu:**

```bash
sudo apt install cmake make g++ flex bison
scripts/linux/build_linux64.sh
```

The binaries appear in `build/linux64/Release/bin`.

**macOS:**

```bash
scripts/build_macos.sh
```

The binaries appear in `build/macos64/Release/bin`.
Do **not** run `setup_flex_bison.sh` on macOS: the repository's own README records that flex on macOS produces a broken parser, and the checked-in generated parser is the one you want.

**Windows:** use WSL and follow the Debian instructions, or take the prebuilt binary.

### Using it

The tool you want out of the many that are built is `Validate`:

```bash
Validate domain.pddl problem.pddl myplan.plan
```

A good plan ends with:

```
Successful plans:
Value: 3
```

A bad one names the step and the precondition, and then tells you what would have had to be true:

```
Checking next happening (time 2)
Plan failed because of unsatisfied precondition in:
(deliver cup-of-tea grandpa living-room)

Plan Repair Advice:
(deliver cup-of-tea grandpa living-room) has an unsatisfied precondition at time 2
(Set (in living-room) to true)
```

Add `-v` for a step-by-step account of which facts each action added and deleted, which is the thing to reach for when the plan is valid and you still think the domain is wrong.

### One trap worth knowing about

VAL reads the numbers in front of each action as a **schedule**, not as a step counter, and treats actions less than `0.01` apart as simultaneous.
Two sequential actions timed `0.001` and `0.002` are therefore rejected as a mutex violation rather than executed in order, and the error you get talks about mutexes rather than about timing:

```
Mutex violation: (move kitchen living-room) (deletes (in kitchen))
```

Some planners and editors emit plans in exactly that format.
If you see this, renumber the steps `1`, `2`, `3` and run it again.
Fast Downward's own plan files carry no timestamps at all and are fine as they are.

---

## 3. ENHSP, for numeric planning

**Skip this unless you need it.** Nothing in Tutorial 4 uses ENHSP, and you need it only if your Assessment 3 domain has real numeric state in it: fuel that drains, a capacity that fills, a quantity you compare against a threshold, or a process that runs over time.
Fast Downward handles none of those.
It does handle `:action-costs`, so if all you want is for some actions to cost more than others, stay where you are.

ENHSP is a forward heuristic search planner covering classical planning, numeric planning with linear and non-linear expressions, PDDL+ processes and events, and global constraints.
It runs on the JVM, which makes it substantially easier to install than anything that needs a C++ toolchain.

It needs **Java 15 or later**.
Build it from source with the script in the repository, and note that it is `compile`, not Gradle:

```bash
git clone https://gitlab.com/enricos83/ENHSP-Public.git
cd ENHSP-Public
./compile
```

That produces `enhsp-dist/enhsp.jar`. Run it with:

```bash
java -jar enhsp-dist/enhsp.jar -o domain.pddl -f problem.pddl
```

and select a configuration with `-planner`, for example `-planner opt-hmax` for an optimal search with the max heuristic, or `-planner sat-hadd` for a satisficing search with the additive heuristic:

```bash
java -jar enhsp-dist/enhsp.jar -o domain.pddl -f problem.pddl -planner opt-hmax
```

If you run out of heap space, raise the limit: `java -Xmx5G -jar ...` for 5GB.

The full list of configurations is on the [ENHSP site](https://sites.google.com/view/enhsp/), which is the authority rather than this document.

---

## 4. If you cannot get a build working

Do not lose the assessment to a toolchain problem.
In order of what to try:

1. **Use WSL** if you are on Windows. Most build failures reported on this course have been native Windows builds.
2. **Take a prebuilt binary** where one exists, as VAL does.
3. **Use a JVM planner.** ENHSP above runs anywhere Java runs, and Assessment 3 lists others.
4. **Use [planutils](https://github.com/AI-Planning/planutils)**, which installs several planners in a container and avoids fighting each toolchain separately.

Assessment 3's specification carries the full catalogue of planners you may use, classical, hierarchical and non-deterministic, with a note on what each one gives you and how hard it is to install.
Read that before choosing, because the choice is marked.

If you are stuck, ask in the practical rather than in the last week.

---

## 5. Troubleshooting

**`AssertionError: :fluents` (or another requirement name) from Fast Downward.**
The translator stops with a raw Python traceback and no message about your domain.
This means your `(:requirements ...)` line declares something Fast Downward does not accept.
It is checking what you *declared*, not what you used, so a requirement you listed and never needed will stop the build just as firmly as one you need and it lacks.
Delete the requirements you do not use.
`blocksworld/blocksworld.pddl` in Tutorial 4 has exactly this problem, deliberately.

**Fast Downward reports the problem unsolvable and you are sure it is not.**
Usually a precondition that cannot ever be satisfied, and typically a missing fact in `(:init)` rather than a bug in an action.
Cut the goal down to something one action could achieve and work back up; Tutorial 4 question 2 shows the technique.

**The build worked, then stopped working after you changed compiler or Python version.**
Delete the `builds` directory and build again. Fast Downward caches configuration there.

**Windows: the binary will not start from a new command line.**
It cannot find a dynamically linked library.
`dumpbin /dependents PATH\TO\DOWNWARD\BINARY` lists what it needs, and each of those has to be on your `PATH`.

**macOS: the compiler cannot find flex or bison when building VAL.**
Your include directories are in a non-standard place.
Point VAL's Makefile at `/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr`.
This is a VAL problem, not a Fast Downward one; Fast Downward needs neither tool.

**VAL rejects a plan a planner just produced.**
Check the timestamps before you suspect your domain. See the trap in section 2.

---

## Acknowledgements

This guide is adapted from the documentation of [Fast Downward](https://github.com/aibasel/downward), [VAL](https://github.com/KCL-Planning/VAL) and [ENHSP](https://gitlab.com/enricos83/ENHSP-Public).
VAL is by Maria Fox, Derek Long, Richard Howey and Stephen Cresswell.
