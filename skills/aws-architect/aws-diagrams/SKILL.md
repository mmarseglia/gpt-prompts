---
name: aws-diagrams
description: "Generate Mermaid diagram-as-code for AWS architectures. Use whenever the user asks for architecture diagrams, system diagrams, sequence diagrams, deployment diagrams, data flow diagrams, or visual representations of their AWS system. Triggers on 'draw a diagram', 'visualize this architecture', 'diagram this', 'show me the architecture', 'C4 diagram', 'sequence diagram', or 'deployment diagram'."
---

# AWS Architecture Diagrams (Mermaid)

You generate diagram-as-code using Mermaid syntax. All diagrams should be copy-paste ready — the user should be able to drop them into any Mermaid renderer (GitHub, Notion, VS Code, mermaid.live) and get a clean result.

## Diagram Selection

Based on the architecture, recommend and produce the most appropriate set of diagrams. At minimum, produce:

1. **Context Diagram** — the system and its external actors/dependencies (C4-style)
2. **Component Diagram** — internal components and their relationships
3. **Deployment Diagram** — AWS infrastructure layout (VPCs, subnets, services, AZs)
4. **Sequence Diagram** — one critical flow (e.g., user request lifecycle, data processing pipeline)

Additionally, include when relevant:
- **Event Flow Diagram** — if the system is event-driven (show event sources, buses, consumers, DLQs)
- **Data Flow / Lineage Diagram** — if the system is data-heavy (show data sources, transforms, destinations)
- **CI/CD Pipeline Diagram** — if the implementation guide is part of the engagement

## Mermaid Patterns for AWS

### Context Diagram (use flowchart)
```mermaid
flowchart TB
    user["👤 End User\n(Web/Mobile)"]
    admin["👤 Admin\n(Internal)"]
    system["🏗️ System Name\n(AWS)"]
    ext1["📧 Email Service\n(SES)"]
    ext2["💳 Payment Provider\n(Stripe)"]

    user -->|"HTTPS"| system
    admin -->|"HTTPS/VPN"| system
    system -->|"SMTP"| ext1
    system -->|"API"| ext2
```

### Component Diagram (use flowchart with subgraphs)
```mermaid
flowchart TB
    subgraph vpc["VPC"]
        subgraph public["Public Subnet"]
            alb["ALB"]
        end
        subgraph private["Private Subnet"]
            ecs["ECS Service"]
            rds["RDS PostgreSQL"]
        end
    end

    cf["CloudFront"] --> alb
    alb --> ecs
    ecs --> rds
```

### Deployment Diagram (use flowchart with nested subgraphs for AZs)
```mermaid
flowchart TB
    subgraph region["us-east-1"]
        subgraph az1["AZ-1 (us-east-1a)"]
            sub1a["Private Subnet"]
            sub1b["Public Subnet"]
        end
        subgraph az2["AZ-2 (us-east-1b)"]
            sub2a["Private Subnet"]
            sub2b["Public Subnet"]
        end
    end
```

### Sequence Diagram
```mermaid
sequenceDiagram
    participant U as User
    participant CF as CloudFront
    participant ALB as ALB
    participant API as API Service
    participant DB as RDS

    U->>CF: GET /api/resource
    CF->>ALB: Forward (cache miss)
    ALB->>API: Route request
    API->>DB: Query
    DB-->>API: Result
    API-->>ALB: 200 OK
    ALB-->>CF: Response
    CF-->>U: Response (cached)
```

### Event Flow (use flowchart)
```mermaid
flowchart LR
    producer["Producer\nService"] -->|"publish"| sns["SNS Topic"]
    sns -->|"subscribe"| sqs1["SQS Queue\n(Consumer A)"]
    sns -->|"subscribe"| sqs2["SQS Queue\n(Consumer B)"]
    sqs1 -->|"poll"| lambda1["Lambda\nConsumer A"]
    sqs2 -->|"poll"| lambda2["Lambda\nConsumer B"]
    sqs1 -->|"failed"| dlq1["DLQ\nConsumer A"]
```

## Diagram Quality Checklist

For each diagram you produce:

- [ ] **Readable at a glance** — someone unfamiliar with the system can understand the high-level flow
- [ ] **Labeled edges** — connections show protocol, data type, or action (not just arrows)
- [ ] **AWS service names** — use actual service names (ALB, not "load balancer"; RDS, not "database")
- [ ] **Consistent styling** — similar components use similar shapes and naming
- [ ] **Not overcrowded** — if a diagram has more than 15-20 nodes, split into multiple diagrams
- [ ] **Accompanied by explanation** — each diagram gets a 2-3 sentence description explaining what it shows and how to read it

## Explanation Format

For each diagram, provide:
1. **What this shows**: one sentence describing the diagram's purpose
2. **How to read it**: directional flow, what the groupings mean
3. **Key takeaway**: the most important thing to notice

## Common Pitfalls to Avoid

- Don't use Mermaid features that are poorly supported (stick to flowchart, sequenceDiagram, and stateDiagram — avoid classDiagram for infrastructure)
- Don't mix too many arrow styles in one diagram
- Keep node labels concise (2-3 words + service name)
- Use subgraphs for logical grouping (VPCs, subnets, AZs, accounts) rather than flat layouts

## After Delivery

Ask: "Would you like me to adjust any diagram, add additional views, or proceed to the next section?"

## Changelog
- 0.1.0 (2026-03-31): Initial version
