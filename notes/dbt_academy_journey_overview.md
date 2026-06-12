# dbt Academy — Journey Overview & Context

A narrative map of everything covered in the DE Academy dbt track + the dbt.com courses,
how the pieces connect, and where the detailed notes live. This is the "big picture"
companion to the two bullet-point reference docs.

---

## The path taken
1. **DE Academy dbt module** (Lessons 1–20) — the foundation. Setup, models, tests,
   materializations (table/view/incremental/ephemeral), snapshots, seeds, macros,
   environments & jobs. *(Already in notes before this stretch.)*
2. **dbt Fundamentals course** (learn.getdbt.com) — models/layering, sources, data tests,
   documentation, deployment. Worked module-by-module on the real project.
3. **Materialization Fundamentals course** — pure review (already exceeded by DE Academy).
4. **Jinja, Macros & Packages course** — Jinja control flow, macros, packages, advanced macros.
5. **Git module** (DE Academy) — workflow, branching, rebasing, squashing, conflicts,
   + two build projects (ETL pipeline, data quality engine).

## The environment everything was built on
- **Snowflake**: `PC_DBT_DB` (database), raw sources in `PUBLIC` schema (`*_SRC` tables),
  dev builds into `DBT_CRANSI`, prod into `DBT_DB_PROD`.
- **dbt Cloud / Studio (Fusion)** connected to GitHub repo **`deacademydbt`**.
- Real data: employee, customer, sales, product, purchase, orders, patient, session.

---

## What was genuinely learned (the gaps that got closed)
Most "concepts" were already known — the value was in the gaps:

- **The git workflow for dbt** — connecting the repo, branch → commit → PR → merge.
  Realized that *running a model in the IDE ≠ committing it* (running hits Snowflake,
  committing hits GitHub — independent).
- **Layered modeling** — staging (1:1, light transforms, `source()`, views) →
  intermediate (joins) → marts (business logic, `ref()`, tables). The DE Academy project
  was *flat* (source → one model); this introduced the named-layer discipline.
- **Dev/prod isolation** — environments decide *where* models land; the model name is
  constant, `ref()` resolves per environment. Merge blesses code; the **job** deploys it.
- **Environment-aware routing** — `generate_schema_name` (a "hook" macro dbt runs for every
  model) controls schema naming per environment. Dev namespaces under your schema; prod
  uses clean names.
- **Source freshness** — `dbt source freshness` monitors the EL→warehouse boundary; gates
  pipelines via exit codes.
- **`dbt build`** — run + test + snapshot + seed, DAG-ordered, test-gated (skips downstream
  of a failed node). The production default.
- **Jinja as the programmatic layer over SQL** — loops/conditionals/variables generate SQL
  (same role Python played in a Python+SQL stack).
- **Version drift is real** — repeatedly hit v1.10/Fusion changes (e.g. `freshness` must be
  under `config:`) that the dev IDE only warned about but the deploy engine errored on.

## Real-world connections made (vs prior Verizon experience)
- dbt's dev/prod environments replace the manual Airflow + Python + SQL wiring (NP→NP,
  prod→prod) and the painful "prod launch day" re-wiring.
- Branch protection + PRs enforce review; Amplify-style direct-push-to-branch is the
  less-safe alternative.
- dbt_utils = "import a library of helper functions" (like pip).

---

## Where the detailed notes live
- **`dbt_reference_notes.docx`** — §1–22: DE Academy module + Fundamentals (big picture,
  core concepts, commands, tests, materializations, incremental, snapshots, seeds, macros,
  environments, architecture, interview lines) + git/environments + deployment.
- **`dbt_advanced_reference_notes.docx`** — §23–27: Materializations recap, Jinja basics,
  Macros & Packages, Advanced Jinja & Macros (generate_schema_name), Git.
- **`dbt_lesson_plan_materializations_jinja.md`** — the gap-focused plan for the later courses.
- **`git_module_notesheet.md`** — git quick reference.

## Status
DE Academy dbt track + dbt Fundamentals + Materialization Fundamentals + Jinja/Macros/
Packages + Git module — **all complete**, worked on the real `deacademydbt` project.
Two git build projects: ETL pipeline (done), Data Quality Engine (pending).
