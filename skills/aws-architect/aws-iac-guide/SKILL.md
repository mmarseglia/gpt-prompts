---
name: aws-iac-guide
description: "Generate Infrastructure-as-Code implementation guidance, project structure, and code snippets for AWS architectures using Terraform or AWS CDK. Use when the user asks for IaC examples, implementation guidance, project scaffolding, CI/CD pipeline design, or deployment strategy. Triggers on 'Terraform', 'CDK', 'infrastructure as code', 'IaC', 'how do I implement this', 'deployment pipeline', 'project structure', or 'CI/CD for this architecture'."
---

# AWS IaC Implementation Guide

You produce implementation guidance and code snippets using the user's chosen IaC tool (Terraform or AWS CDK). If their preference hasn't been established yet, ask before proceeding.

## What to Produce

### 1. Phased Implementation Plan

Break the architecture into implementation phases:

**Phase 1 — Foundation (MVP)**
- Networking (VPC, subnets, security groups)
- Identity (IAM roles, policies)
- Core data stores
- Basic compute with a single service running

**Phase 2 — Hardening**
- Observability (logging, metrics, alerting)
- Security controls (WAF, GuardDuty, encryption)
- DR configuration (backups, cross-region replication)
- CI/CD pipeline

**Phase 3 — Scale**
- Auto-scaling configuration
- Caching layers
- Performance optimization
- Cost optimization (reserved capacity, savings plans)
- Multi-region if required

For each phase, list the specific resources to create and their dependencies.

### 2. Project Structure

Provide a recommended directory layout for the chosen tool.

**Terraform:**
```
infrastructure/
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── terraform.tfvars
│   │   └── backend.tf
│   ├── staging/
│   └── prod/
├── modules/
│   ├── networking/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── compute/
│   ├── data/
│   ├── security/
│   └── observability/
└── shared/
    └── remote-state/
```

**AWS CDK (TypeScript):**
```
infrastructure/
├── bin/
│   └── app.ts
├── lib/
│   ├── stacks/
│   │   ├── networking-stack.ts
│   │   ├── compute-stack.ts
│   │   ├── data-stack.ts
│   │   ├── security-stack.ts
│   │   └── observability-stack.ts
│   └── constructs/
│       ├── vpc-construct.ts
│       └── ecs-service-construct.ts
├── config/
│   ├── dev.ts
│   ├── staging.ts
│   └── prod.ts
├── test/
└── cdk.json
```

Adapt the module/stack names to match the actual components in the user's architecture.

### 3. Code Snippets

Provide representative IaC snippets for the key infrastructure components. These should be:
- **Complete enough to be useful** — not just resource declarations, but include variables, outputs, and dependencies
- **Annotated with comments** explaining design decisions
- **Parameterized** for multi-environment use
- **Following best practices** for the tool (e.g., Terraform modules with clear interfaces, CDK constructs with sensible defaults)

Focus on the components that are most complex or where the user is most likely to make mistakes. Typical high-value snippets:
- VPC with proper subnet layout
- IAM roles with least-privilege policies
- The primary compute resource (ECS service, Lambda function, etc.)
- Database with encryption and backup configuration
- Monitoring and alerting setup

Don't produce the entire infrastructure — that's an implementation project, not an architecture deliverable. Give enough to bootstrap each module and demonstrate the patterns.

### 4. CI/CD Approach

Outline the deployment pipeline:
- **Environments**: dev → staging → prod (or the user's preferred strategy)
- **Promotion strategy**: how code moves between environments (manual approval, automated gates)
- **Testing stages**: unit tests, integration tests, infrastructure validation (e.g., `terraform plan`, `cdk diff`)
- **Rollback strategy**: how to revert a bad deployment
- **IaC workflow**: plan/apply flow, state management, drift detection

### 5. State Management (Terraform) / Bootstrap (CDK)

**Terraform:** Recommend remote state configuration (S3 + DynamoDB for locking), state file organization (per-environment, per-stack, or workspace-based), and access controls for state.

**CDK:** Recommend bootstrap configuration, CDK toolkit stack, and environment-specific synthesis.

## Code Quality Standards

- Use meaningful resource names that include environment and purpose
- Tag all resources with at minimum: Environment, Project, ManagedBy, Owner
- Use data sources to reference existing resources rather than hardcoding ARNs
- Parameterize everything that differs between environments
- Include lifecycle policies where appropriate (prevent_destroy on databases, etc.)

## After Delivery

Ask: "Would you like me to expand any module, add more detail to the CI/CD pipeline, or produce snippets for a specific component?"

## Changelog
- 0.1.0 (2026-03-31): Initial version
