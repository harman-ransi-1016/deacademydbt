# Lesson Plan — Materialization Fundamentals + Jinja, Macros & Packages

**Project:** existing `deacademydbt` (re-cloned from `main`). All practice on a branch → PR → merge.
**Approach:** skim review modules (don't skip outright), go deep on the genuinely new.
**Total focused time:** ~2.5 hrs (vs the ~4–5 hr beginner estimate).

---

## Course A — Materialization Fundamentals (~20 min, mostly review)

Single content module: tables / views / ephemeral + configuring materializations.
You already have this in notes §5–8 (and more — this course doesn't even cover incremental).

- **Skim:** "What are materializations?", "tables/views/ephemeral", "configuring materializations."
- **Confirm (already true in your project):** folder-level config in `dbt_project.yml`
  (`staging: +materialized: view`, `marts: +materialized: table`) vs inline `{{ config() }}`.
- **Do:** the Knowledge Check for the tick.
- **Output:** nothing new to notes unless the course phrases something fresh.

---

## Course B — Jinja, Macros & Packages (~2 hrs focused)

### Module 02 — Getting started with Jinja (NEW — do it) ~40 min
Your real gap. You have *macros* (§11) but not raw **Jinja control flow**.

Topics: `{% if %}`, `{% for %}` loops, `{% set %}` variables, `{{ }}` vs `{% %}`,
`loop.last`, building a **pivot** with a for-loop + `case when`, whitespace control (`{%- -%}`).

**Practice on your data:**
- Use `session` or `sales` to build a pivot (e.g. count sessions by `device_type`,
  or sum `total_amount` by something) using a `{% for %}` loop over a list + `case when`.
- Use `loop.last` to handle trailing commas in a generated column list.

**Notes output:** new section — Jinja control flow (if/for/set/loop.last/pivot/whitespace).

### Module 03 — Working with Macros (SKIM — you have §11) ~20 min
Topics: what macros are, `cents_to_dollars`, DRY vs readability.
- You already wrote `concat_macro`. This is reinforcement.
- **Worth a look:** the `cents_to_dollars` example (clean real-world macro) and the
  "DRY vs readability" tradeoff (when NOT to over-macro).
- **Optional practice:** write a `cents_to_dollars`-style macro and use it in a model.
- **Notes output:** maybe a one-liner on DRY-vs-readability; otherwise covered.

### Module 04 — Packages (SKIM — you have §5/§18) ~20 min
Topics: what packages are, installing, packages with macros, packages with models.
- You've done `packages.yml` + `dbt deps` (codegen). This generalizes it.
- **New-ish:** "packages with models" — a package that ships *models*, not just macros
  (e.g. `dbt_utils` macros like `star()`, `surrogate_key()`, `pivot()`; audit-helper).
- **Optional practice:** add `dbt_utils`, use `dbt_utils.star()` or `generate_surrogate_key()`
  in a model.
- **Notes output:** short addition — dbt_utils + packages-with-models.

### Module 05 — Advanced Jinja & Macros (NEW — highest value, do it fully) ~40 min
The standout. Builds directly on your dev/prod work from Lesson 8.

Topics + how each maps to your project:
- **`grant_select` macro** — auto-grant SELECT on built models to a role. Real ops pattern;
  connects to the GRANT pain you hit during deployment.
- **`union_tables_by_prefix`** — loop over warehouse tables matching a prefix and `UNION` them.
  Great fit: you have several `*_SRC` tables — practice unioning by prefix.
- **`clean_stale_macro`** — operational cleanup macro (drop stale relations).
- **`generate_schema_name` macro** — overrides how dbt names the target schema. THIS is the
  one that ties to your deployment: it's how you customize schema-per-environment.
- **Customizing schema by environment** — using `target.name` / `generate_schema_name` so
  dev and prod resolve to different schemas automatically. Directly extends §16/§22.

**Practice on your project:**
- Write `union_tables_by_prefix` and union your `*_SRC` tables (or a subset).
- Add a custom `generate_schema_name` macro and observe how it changes where models land
  in dev vs your prod environment.

**Notes output:** new section — advanced macros (grant_select, union_by_prefix,
generate_schema_name + schema-by-environment), explicitly linked to §16/§22.

---

## Suggested sequence
1. Materialization Fundamentals — skim + knowledge check (~20 min).
2. Jinja basics (Module 02) — hands-on pivot/loop practice (~40 min).
3. Macros (03) + Packages (04) — skim, optional dbt_utils practice (~40 min).
4. Advanced Jinja & Macros (05) — full hands-on, tie to prod env (~40 min).
5. Save each chunk to master notes as we go (new §23+).

## Git rhythm (same as before)
Branch off `main` → build/practice → `dbt run`/`build` to test in dev → commit → PR → merge.
Advanced macros (generate_schema_name) can be verified against your existing prod job.
