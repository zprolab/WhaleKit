---
name: targeted-exploration
description: Use when a non-trivial task needs understanding before process selection - explores a fixed target (module, file, question, or whole project) with bounded scope and reports findings, evidence, risks, and scope estimate
---

# Targeted Exploration

## 1. Target Declaration

1.1 Before exploring, write an exploration brief and show it to the user in exactly this form, with these three lines, each prefixed literally with `Target:`, `Question:`, and `Budget:`:

```
Target: <module|file|question|whole project>
Question: <what must be learned>
Budget: <max steps>
```

1.2 The target must be an explicit point — a module, a file, a question, or the whole project — written down before any exploration begins. Substitute a concrete value for each placeholder; do not leave a placeholder unresolved.

1.3 An exploration begun without a declared `Target:` and `Budget:` is a violation of this skill.

## 2. Anti-Divergence Constraints

2.1 **Scope boundary:** explore only what the target needs. Do not read, search, or report anything that does not serve the `Question`. Wandering into unrelated modules, files, or search results is a violation.

2.2 **Step budget:** a hard stop at the declared `Budget`. When the budget is reached, stop exploring even if the report feels incomplete — extend the budget only with the user's approval.

2.3 **Stop condition:** stop early when the evidence is sufficient. "Sufficient" is defined per brief in the `Question` clause — stop once the evidence answers the question with confidence, before exhausting the budget.

## 3. Report Format

Deliver the exploration report with exactly these four labeled sections, in this order, using the exact headings below. Every report must carry all four; a report missing any section is not a valid targeted-exploration report.

3.1 `Findings` — a numbered list of what was learned about the target.

3.2 `Evidence` — concrete `file:line` references supporting each finding. Cite only target-relevant evidence.

3.3 `Risks` — a numbered list of risks the exploration surfaced, each tagged with a severity: `[low]` / `[medium]` / `[high]`.

3.4 `Scope estimate` — files touched, interfaces affected, and a tier signal L1–L5 (spec §5.2).

## 4. Recurring Rule

> **Tier recommendations for non-trivial tasks must be based on a targeted-exploration report, never on impression.**
