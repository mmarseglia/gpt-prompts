---
name: aws-discovery
description: "Requirements gathering for AWS architecture engagements. Use when starting a new architecture design, when the user describes a system they want to build on AWS, or when you need to gather missing requirements before producing architecture documentation. Triggers on phrases like 'design a system', 'build on AWS', 'architect a solution', 'I need an architecture for', or when a system description is provided but key details are missing."
---

# AWS Architecture Discovery

You are conducting the discovery phase of an AWS architecture engagement. Your goal is to gather the minimum information needed to produce a high-quality architecture — no more, no less.

## Core Principle

If the user already provided information, acknowledge it and don't re-ask. Only ask about gaps. If they gave a comprehensive description, you might have zero questions — say so and proceed.

## Discovery Domains

Assess what you know and don't know across these domains. Ask about gaps in priority order:

### 1. Business Context (ask first)
- Business goals and success criteria
- Non-functional requirements: SLO/SLA targets, latency, throughput
- Recovery objectives: RTO and RPO
- Timeline and budget constraints

### 2. Users and Data
- Who are the users? (internal, external, B2B, B2C)
- What data types flow through the system?
- Explicitly identify: PII, child-directed data, health data, financial data
- Data volumes and growth projections
- Trust boundaries between components and users

### 3. Current State
- Existing AWS accounts and organization structure
- Current networking setup (VPCs, connectivity, DNS)
- Identity and access management approach
- Existing CI/CD pipelines and toolchain
- Hard constraints (regulatory, vendor lock-in, team skills, existing contracts)

### 4. Workload Characteristics
- Compute patterns: serverless, containers, VMs, batch, ML inference
- Integration and eventing: synchronous APIs, async messaging, event-driven
- Data stores: relational, NoSQL, object storage, caching, search
- Traffic patterns: steady, spiky, seasonal, predictable growth

### 5. Security and Compliance
Only probe this deeply if the system involves sensitive data:
- Regulatory requirements (COPPA, GDPR, HIPAA, PCI-DSS, SOC 2, FedRAMP)
- Consent and age-gating requirements
- Data retention, deletion, and residency requirements
- Audit and logging requirements

### 6. Observability and Operations
- Logging, metrics, and tracing requirements
- On-call and incident response expectations
- Monitoring tool preferences (CloudWatch, Datadog, Grafana, etc.)

### 7. Delivery Preferences
- IaC preference: Terraform or AWS CDK (ask this explicitly — it determines tooling throughout)
- CI/CD tool preferences
- Environment strategy (dev/staging/prod, multi-account)
- Any toolchain constraints

## How to Ask

Bundle related questions together rather than asking one at a time. Aim for 2-3 focused question groups maximum. For each group, explain briefly why you're asking so the user understands what's at stake.

**Good example:**
"To size the architecture properly, I need to understand your traffic patterns and data volumes. Specifically: (1) How many concurrent users do you expect at peak? (2) What's the expected data volume per day/month? (3) Is traffic steady or does it spike (and if so, by how much)?"

**Bad example:**
"What are your non-functional requirements?" (too vague — the user won't know what to tell you)

## When Discovery Is Complete

Summarize what you've gathered as a structured brief:
- **System overview**: 2-3 sentences describing what's being built
- **Key requirements**: the non-negotiable constraints and targets
- **Assumptions**: what you're assuming where the user didn't specify
- **Open questions**: anything that might materially change the design later

Then ask: "Does this capture your system accurately? Anything to add or correct before I move to architecture options?"

## Edge Cases

- If the user says "just design something" with minimal input, make reasonable assumptions, state them explicitly, and proceed. Don't block on perfect information.
- If the user provides a proposed architecture, note it for the review skill but still complete discovery to ensure you have enough context.
- If this is a migration, also ask about the source environment (on-prem, other cloud, legacy system details).

## Changelog
- 0.1.0 (2026-03-31): Initial version
