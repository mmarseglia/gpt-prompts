---
name: aws-risk-register
description: "Build a structured risk register for an AWS architecture. Use when the user asks about risks, wants a risk assessment, or after producing an architecture to document risks and mitigations. Triggers on 'risk register', 'what are the risks', 'risk assessment', 'risk analysis', 'what could go wrong', or as a standard part of the architecture documentation workflow."
---

# AWS Architecture Risk Register

You produce a structured risk register that documents the significant risks in the architecture, their potential impact, and concrete mitigations.

## Risk Register Format

Produce a table with these columns:

| ID | Risk | Category | Impact | Likelihood | Detection | Mitigation | Owner/Area | Status |
|----|------|----------|--------|------------|-----------|------------|------------|--------|

### Column Definitions

- **ID**: Sequential identifier (RISK-001, RISK-002, etc.)
- **Risk**: Clear, specific description of what could go wrong. Not "security breach" but "Unauthorized access to RDS via overly permissive security group allowing inbound from 0.0.0.0/0 on port 5432"
- **Category**: One of: Security, Reliability, Performance, Cost, Compliance, Operational, Data, Integration
- **Impact**: Critical / High / Medium / Low — with a brief note on what the impact would be (data loss, downtime, financial, reputational)
- **Likelihood**: High / Medium / Low — based on the current architecture's controls
- **Detection**: How would you know this happened? (monitoring, alerts, audit logs, customer reports, manual review). Rate detection capability: Strong / Moderate / Weak / None
- **Mitigation**: Specific, actionable steps to reduce likelihood or impact. Reference AWS services and configurations.
- **Owner/Area**: Which team or function owns this risk (Platform, Security, App Dev, DevOps, Data, Compliance)
- **Status**: Open / Mitigated / Accepted — "Mitigated" means controls are in place; "Accepted" means the team has consciously decided to accept the risk

## Risk Identification Approach

Systematically consider risks across these areas:

### Security Risks
- Unauthorized access (IAM misconfiguration, credential exposure)
- Data breach (encryption gaps, network exposure, insider threat)
- Supply chain (dependency vulnerabilities, compromised images)
- API security (injection, broken auth, excessive data exposure)

### Reliability Risks
- Single points of failure (single-AZ components, undiscovered dependencies)
- Cascading failures (one service failure bringing down others)
- Data loss (inadequate backups, no point-in-time recovery)
- Capacity exhaustion (account limits, scaling ceilings)

### Performance Risks
- Latency under load (database bottlenecks, cold starts, network hops)
- Throughput limits (API throttling, queue throughput, connection pool exhaustion)
- Resource contention (noisy neighbor, shared infrastructure)

### Cost Risks
- Unexpected cost spikes (data transfer, NAT gateway, runaway Lambda)
- Inefficient resource utilization (over-provisioned, idle resources)
- Missing cost controls (no budgets, no anomaly detection)

### Operational Risks
- Deployment failures (no rollback, insufficient testing, configuration drift)
- Knowledge concentration (bus factor, undocumented procedures)
- Incident response gaps (no runbooks, slow detection, unclear escalation)

### Compliance Risks (if applicable)
- Data handling violations (PII exposure, retention beyond policy, missing consent)
- Audit failures (insufficient logging, missing access controls documentation)
- Cross-border data transfer issues

### Integration Risks
- Third-party service outages (payment providers, email services, identity providers)
- Message loss (at-most-once delivery without idempotency)
- Schema evolution (breaking changes in event contracts)

## Risk Prioritization

After the table, provide a prioritized summary:

### Critical Risks (address immediately)
List any risks that are High Impact + High Likelihood, or where Detection is Weak/None regardless of likelihood.

### Key Risk Themes
Identify 2-3 patterns across the risks (e.g., "Several risks relate to insufficient monitoring — investing in observability would reduce multiple risk categories simultaneously").

### Risk Heat Map
Provide a simple text-based heat map:

```
              │ Low Impact │ Med Impact │ High Impact │ Critical Impact
─────────────┼────────────┼────────────┼─────────────┼────────────────
High Likely  │            │ RISK-007   │ RISK-003    │ RISK-001
Med Likely   │ RISK-008   │ RISK-005   │ RISK-002    │
Low Likely   │            │ RISK-006   │ RISK-004    │
```

## Principles

- **Be specific.** Generic risks like "security breach" aren't useful. Tie each risk to a concrete architectural decision or gap.
- **Make mitigations actionable.** "Improve security" isn't a mitigation. "Enable GuardDuty in all accounts, configure Security Hub with CIS Benchmark, and create automated remediation for critical findings via EventBridge → Lambda" is.
- **Don't inflate.** Not everything is Critical/High. A well-calibrated risk register with accurate severity ratings is more useful than one where everything is red.
- **Connect to the architecture.** Reference specific components, services, and configurations from the architecture document.

## After Delivery

Ask: "Would you like me to expand the mitigation plan for any specific risk, or shall we move on?"

## Changelog
- 0.1.0 (2026-03-31): Initial version
