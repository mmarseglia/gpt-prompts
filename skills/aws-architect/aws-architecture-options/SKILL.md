---
name: aws-architecture-options
description: "Generate and compare 2-4 viable AWS architecture options with tradeoff analysis. Use after discovery is complete and before deep-diving into the recommended architecture. Triggers when the user asks for architecture options, alternatives, comparisons, or 'what are my options for building X on AWS'."
---

# AWS Architecture Options Analysis

You are producing the architecture options analysis — a structured comparison of 2-4 viable approaches to solving the user's problem on AWS. This helps the user (and their stakeholders) understand the design space before committing to a direction.

## What to Produce

### For Each Option (2-4 options)

1. **Option Name** — a descriptive label (e.g., "Serverless-First", "Container-Based with ECS", "Event-Driven with Step Functions")

2. **Description** — 1-2 paragraphs explaining the approach, key design decisions, and the architectural philosophy behind it

3. **Key AWS Services** — the primary services this option relies on, and why each was chosen over alternatives

4. **Pros** — specific advantages of this approach for the user's requirements (not generic pros)

5. **Cons** — specific disadvantages, risks, or limitations for the user's context

6. **Operational Complexity** — what it takes to run this in production (team skills needed, monitoring complexity, deployment pipeline complexity, on-call burden)

7. **Security Posture** — how well this option handles the user's security requirements (blast radius, network isolation, secrets management, encryption approach)

8. **Fit Assessment** — how well this option aligns with the stated requirements, constraints, and team capabilities

### Tradeoff Table (required)

After presenting all options, produce a comparison table with these columns:

| Dimension | Option A | Option B | Option C |
|-----------|----------|----------|----------|
| Security | | | |
| Compliance fit | | | |
| Performance | | | |
| Reliability | | | |
| Cost drivers | | | |
| Operational complexity | | | |
| Time to deliver | | | |
| Team skill fit | | | |

Use qualitative ratings (Low / Medium / High, or descriptive phrases) rather than numeric scores. Add brief notes explaining each rating.

For compliance fit: only include this row if the system has compliance requirements identified during discovery. Otherwise omit it.

### Recommendation

End with a clear recommendation:
- Which option you recommend and why
- What the primary deciding factors are
- Any conditions under which you'd change the recommendation (e.g., "If your team has no Kubernetes experience, Option B becomes the better choice")

## Design Principles for Options

- **Make options genuinely different.** Don't present minor variations of the same approach. Each option should represent a distinct architectural philosophy (e.g., serverless vs. containers vs. managed services vs. self-hosted).

- **Include at least one simpler option.** The user may not need the most sophisticated architecture. Include a "start simple" option that's faster to deliver even if it has scaling limitations.

- **Ground options in the user's context.** Reference their specific requirements, constraints, and team capabilities. Don't produce generic "serverless vs. containers" comparisons.

- **Be honest about costs.** If an option is likely to be significantly more expensive, say so and explain why. Qualitative cost analysis is fine — no need for exact pricing unless the user asks.

## Citations

Reference AWS documentation, Well-Architected Framework pillars, or service-specific best practices where they support your analysis. Use footnote-style citations [^1] and list them at the end.

## After Delivery

Ask the user: "Which option resonates most, or would you like me to adjust any of these? Once you pick a direction (or if you'd like a hybrid), I'll produce the detailed architecture."

## Changelog
- 0.1.0 (2026-03-31): Initial version
