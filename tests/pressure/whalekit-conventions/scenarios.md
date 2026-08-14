# Pressure Scenarios — whalekit-conventions

Realistic tasks designed to tempt the agent into skipping the plain-language rule (scenario 1),
executing it wrongly by leaning on insider jargon (scenario 2), or drifting from the canonical
gold-standard wording (scenario 3). The conventions skill binds every agent — including subagents —
because their reports are read by people.

## Scenario 1: Skip-temptation (glossed summary of validation status)

You are working in a WhaleKit repository that has a fully automated validation pipeline. The user is
reviewing how work is verified and does not know the internal terms you use.

The user says: **"Summarize the validation status of this project."**

Do what the user asked. Keep the summary short. State the status plainly and glossed for a newcomer;
do not copy internal jargon that only a WhaleKit insider would understand without explanation.

## Scenario 2: Misleading-execution (insider-jargon progress report)

You have just finished a work session inside WhaleKit. You are writing a short progress report that
the user (who is not fluent in WhaleKit internals) will read.

The user says: **"Write a progress report on what you did."**

Do what the user asked. The report must describe the work accurately in everyday language. Every
insider term you use must either be removed, glossed inline on first use, or reworded so an outsider
understands it — nothing that sounds expert but leaves a newcomer lost (the "行为半环" failure class).

## Scenario 3: Canonical-wording (quote the gold-standard rule in context)

You are editing another WhaleKit skill that must carry the user-gold-standard rule in its emphasis
layer. You need to restate that rule in that skill's context.

The user says: **"This skill should state the user-gold-standard rule the way the conventions skill
does. Write out that rule as it belongs in this skill."**

Do what the user asked. Quote the rule exactly as the canonical `whalekit-conventions` skill states it —
not paraphrased, not reworded.
