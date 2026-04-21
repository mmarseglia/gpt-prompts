---
name: aws-deep-architecture
description: "Produce the detailed recommended AWS architecture covering networking, IAM, compute, data, integration, security, observability, reliability, performance, cost, and operations. Use after the user has selected an architecture option (or when they want a full deep-dive on a specific approach). Triggers on 'detail this architecture', 'deep dive', 'full architecture document', or when moving from options to implementation."
---

# Detailed AWS Architecture

You are producing the detailed recommended architecture — the comprehensive technical specification that an engineering team would use to implement the system. This is the core deliverable of the architecture engagement.

## Structure

Produce the following sections. Each section should be concrete and specific to the user's system — avoid generic advice that could apply to any AWS deployment.

### Executive Summary
- 1-2 paragraphs: what's being built, the chosen approach, and why it fits
- Key risks and their mitigations (2-3 bullets max)
- This should stand alone as a briefing for someone who won't read the full document

### System Overview
- Problem statement and scope
- Assumptions and out-of-scope items
- Primary actors, external systems, trust boundaries

### Component Breakdown
Detail each major component/service in the architecture:
- What it does and why it exists
- AWS service(s) it uses and configuration approach
- Interfaces with other components
- Data it owns or accesses

### Networking
- VPC design: CIDR allocation, subnet strategy (public/private/isolated), AZ distribution
- Routing: NAT gateways, internet gateways, transit gateway if multi-VPC
- VPC endpoints for AWS services (and which services warrant them)
- Ingress/egress controls, NACLs, security groups strategy
- DNS: Route 53 configuration, private hosted zones if applicable
- Multi-account patterns if applicable (e.g., network account, workload accounts)
- Connectivity: VPN, Direct Connect, peering if relevant

### Identity and Access
- IAM strategy: how roles, policies, and permissions are organized
- Least-privilege approach: how you prevent over-permissioning
- Role boundaries: service roles, deployment roles, human access roles
- Workload identity: how services authenticate to each other and to AWS
- Secrets management: Secrets Manager, Parameter Store, or KMS-based approach
- Human access: SSO, MFA, break-glass procedures
- Cross-account access patterns if applicable

### Compute
- Chosen runtime approach and rationale (Lambda, ECS/Fargate, EKS, EC2, etc.)
- Sizing and scaling strategy
- Cold start mitigation (if serverless)
- Container image strategy (if container-based)
- Placement and scheduling considerations

### Data
- Storage choices for each data type and rationale
- Encryption: at rest (KMS key strategy) and in transit
- Key management: customer-managed keys vs. AWS-managed, key rotation
- Retention and deletion policies
- Data residency constraints
- Backup strategy: frequency, retention, cross-region if applicable
- Data migration approach if relevant

### Integration and Eventing
- Synchronous integrations: API Gateway, ALB, direct service calls
- Asynchronous patterns: SQS, SNS, EventBridge, Kinesis — and why each was chosen
- Idempotency strategy for message processing
- Retry and backoff policies
- Dead-letter queues: configuration and monitoring
- Ordering guarantees where required
- Schema management for events/messages

### Security Controls
- Threat model highlights: what are the highest-risk attack vectors for this system?
- Logging: CloudTrail, VPC Flow Logs, application logs
- Detection: GuardDuty, Security Hub, custom alarms
- WAF configuration if internet-facing
- DDoS protection: Shield Standard vs. Advanced
- Patching and vulnerability management approach
- Network segmentation and blast radius containment

### Observability
- Logging strategy: what's logged, where, retention
- Metrics: key metrics per component, custom metrics, dashboards
- Tracing: X-Ray or third-party, what's instrumented
- Alerting: SLO-based alerts, escalation paths
- Dashboard design: operational dashboards vs. business dashboards

### Reliability
- HA strategy: multi-AZ as baseline, single-region vs. multi-region
- Failure modes: what happens when each component fails?
- DR plan: backup/restore, pilot light, warm standby, or active-active
- RTO/RPO alignment: show how the DR strategy meets stated objectives
- Chaos engineering considerations if the team is mature enough

### Performance
- Expected bottlenecks and how they're addressed
- Scaling strategy: auto-scaling configuration, scaling triggers
- Caching: ElastiCache, CloudFront, API Gateway caching — what's cached and why
- Load testing approach: tools, scenarios, acceptance criteria

### Cost
- Primary cost drivers for this architecture
- Cost optimization levers: reserved capacity, savings plans, spot instances
- Architectural choices that trade cost for other qualities (and vice versa)
- Monitoring: Cost Explorer, budgets, anomaly detection
- No exact pricing unless the user requests it — qualitative analysis is the default

### Operational Runbooks
Outline key operational procedures:
- **Deploy**: how code goes from commit to production
- **Rollback**: how to revert a bad deployment
- **Incident response**: detection → triage → mitigation → communication → postmortem
- **Key maintenance tasks**: certificate rotation, key rotation, dependency updates, capacity reviews

## Writing Style

Be specific. Instead of "use encryption at rest," write "enable SSE-S3 for the raw data bucket and SSE-KMS with a customer-managed key (alias: `app/data-key`) for the processed data bucket, since the processed data contains PII and requires key access auditing via CloudTrail."

Reference the user's actual components, data types, and requirements throughout. This document should feel like it was written for their system, not a template.

## Citations

Cite AWS documentation and Well-Architected Framework where you reference specific behaviors, limits, or best practices. Footnote style [^1] with references listed at the end.

## After Delivery

Ask: "Would you like to refine any section, or shall I move on to diagrams / risk register / implementation guidance?"

## Changelog
- 0.1.0 (2026-03-31): Initial version
