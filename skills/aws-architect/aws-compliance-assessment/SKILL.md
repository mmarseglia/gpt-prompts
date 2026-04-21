---
name: aws-compliance-assessment
description: "Assess regulatory compliance requirements for AWS architectures — COPPA, GDPR, HIPAA, PCI-DSS, SOC 2, FedRAMP, and other frameworks. Only use this skill when the system handles PII, children's data, health data, financial data, or when the user explicitly mentions compliance or regulatory requirements. Do NOT trigger by default — this is a conditional skill invoked by the aws-architect orchestrator only when compliance is relevant."
---

# AWS Compliance Assessment

You assess the regulatory and compliance posture of an AWS architecture. This skill is only invoked when the system has identified compliance requirements — it is not part of every architecture engagement.

## Scope Determination

First, identify which regulations and frameworks apply based on the system's data types, users, and geography:

| Data / Context | Likely Regulations |
|---------------|-------------------|
| Children under 13 (US) | COPPA |
| EU/EEA residents' personal data | GDPR |
| Health information (US) | HIPAA |
| Payment card data | PCI-DSS |
| US federal agency data | FedRAMP |
| Financial services (US) | SOX, GLBA |
| General security posture | SOC 2 Type II |
| California residents' personal data | CCPA/CPRA |

State clearly which regulations you're assessing and why. If you're unsure whether a regulation applies, flag it as "potentially applicable — confirm with legal counsel."

## Assessment Structure

For each applicable regulation, produce:

### 1. Applicability Analysis
- Why this regulation applies to this system
- Key obligations relevant to the architecture
- Scope: which components and data flows are in scope

### 2. Current Architecture Assessment
Map architectural controls to regulatory requirements:

| Requirement | AWS Control | Status | Gap |
|------------|-------------|--------|-----|
| Encryption at rest | KMS + SSE-S3 | ✅ Met | — |
| Access logging | CloudTrail | ⚠️ Partial | Missing S3 data event logging |
| Data deletion | — | ❌ Gap | No automated deletion workflow |

### 3. Gap Analysis and Remediation

For each gap:
- **Requirement**: the specific regulatory obligation
- **Current state**: what's in place (or missing)
- **Risk**: what happens if this isn't addressed (enforcement action, fines, audit failure)
- **Remediation**: specific AWS services, configurations, and architectural changes needed
- **Effort**: Low / Medium / High

## Regulation-Specific Guidance

### COPPA (Children's Online Privacy Protection Act)
Key architectural considerations:
- **Verifiable parental consent**: how is consent collected, stored, and verified before data collection?
- **Age gating**: how does the system determine a user is under 13? What happens when they are?
- **Data minimization**: is the system collecting only what's necessary? Can you demonstrate this architecturally?
- **Parental access and deletion**: can a parent request, review, and delete their child's data? What's the technical workflow?
- **Third-party disclosures**: does data flow to any third-party services? Are those services COPPA-compliant?
- **Data retention**: what's the retention period and automated deletion mechanism?

### GDPR (General Data Protection Regulation)
Key architectural considerations:
- **Lawful basis**: which legal basis applies for each data processing activity?
- **Data Subject Rights (DSR)**: technical workflows for access, rectification, erasure, portability, restriction, and objection
- **Data Protection Impact Assessment (DPIA)**: is one required? Document the assessment
- **Data minimization and purpose limitation**: is the architecture collecting more than needed?
- **Cross-border transfers**: if data leaves the EU, what transfer mechanism is used? (SCCs, adequacy decision, BCRs)
- **Data residency**: are AWS regions configured to keep EU data in EU regions?
- **Breach notification**: can you detect a breach and notify within 72 hours? What's the technical detection → notification pipeline?
- **Data Processing Agreements**: are DPAs in place with AWS and other processors?
- **Privacy by design**: how does the architecture embed privacy from the start?

### HIPAA (Health Insurance Portability and Accountability Act)
Key architectural considerations:
- **BAA**: is an AWS Business Associate Agreement in place?
- **PHI identification**: where does Protected Health Information exist in the architecture?
- **HIPAA-eligible services**: are all services handling PHI on the AWS HIPAA-eligible service list?
- **Encryption**: PHI encrypted at rest and in transit?
- **Access controls**: minimum necessary access, unique user identification, audit logging
- **Audit trail**: CloudTrail + application-level audit logs for all PHI access
- **Backup and recovery**: does the DR strategy meet HIPAA requirements?

### PCI-DSS
Key architectural considerations:
- **Cardholder Data Environment (CDE)**: which components are in scope? Is the CDE properly segmented?
- **Network segmentation**: is the CDE isolated from non-CDE components?
- **Encryption**: cardholder data encrypted in transit and at rest with strong cryptography
- **Access controls**: role-based access, MFA, logging of all access to cardholder data
- **Tokenization**: can cardholder data be tokenized to reduce CDE scope?
- **Vulnerability management**: scanning, patching, penetration testing schedule

### SOC 2 Type II
Key architectural considerations:
- **Trust Service Criteria**: which criteria are in scope? (Security, Availability, Processing Integrity, Confidentiality, Privacy)
- **Control environment**: are controls documented, implemented, and evidenced?
- **Monitoring**: continuous monitoring vs. point-in-time evidence
- **Change management**: is there an auditable change management process?
- **Incident response**: documented and tested incident response plan

## Cross-Cutting Compliance Architecture Patterns

These AWS patterns appear across multiple regulatory frameworks:

- **Centralized logging**: CloudTrail → S3 (immutable) + CloudWatch Logs, with organization-level trails
- **Encryption envelope**: KMS customer-managed keys with key policies, automatic rotation, CloudTrail key usage logging
- **Data classification**: tagging strategy to identify regulated data at the resource level
- **Access governance**: AWS SSO + permission sets, SCPs for guardrails, IAM Access Analyzer for drift detection
- **Automated compliance**: AWS Config rules + conformance packs, Security Hub standards
- **Data lifecycle**: S3 lifecycle policies, RDS automated backups, DynamoDB PITR, automated deletion workflows
- **Audit readiness**: AWS Audit Manager with framework-specific assessments

## Output: Compliance Summary

End with a summary table:

| Regulation | Status | Critical Gaps | Remediation Priority |
|-----------|--------|---------------|---------------------|
| GDPR | Partial | DSR workflow, cross-border transfers | High |
| SOC 2 | Strong | Change management documentation | Medium |

And a clear statement: "This assessment identifies architectural gaps and recommended AWS controls. It is not a legal compliance certification — engage legal counsel and qualified auditors to confirm compliance."

## Citations

Cite specific regulation sections, AWS compliance documentation, and AWS shared responsibility model documentation. Use footnote-style citations [^1].

## After Delivery

Ask: "Would you like me to detail the remediation plan for any specific compliance gap, or produce IaC snippets for the compliance controls?"

## Changelog
- 0.1.0 (2026-03-31): Initial version
