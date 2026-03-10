# Prompt Catalog

Quick reference for finding and discovering prompts in this repository.

## By Category

### Analysis
- **[Data Snapshot Summary](analysis/data-summary.md)**
  - Description: Summarize a dataset or analysis snippet with risks and next steps.
  - Tags: [analysis, summary, risks]
  - Models: [gpt-5.2, claude-opus-4-5]
  - Variables: context,metrics,audience,

### Coding
- **[Refactor a Function Safely](coding/refactor-function.md)**
  - Description: Stepwise refactor with reasoning, diff, and tests.
  - Tags: [refactor, testing, step-by-step]
  - Models: [gpt-5.2, claude-opus-4-5]
  - Variables: language,code,

### Writing
- **[Concise Blog Outline](writing/blog-outline.md)**
  - Description: Produce a tight, engaging outline with hooks and CTA.
  - Tags: [outline, blog, structure]
  - Models: [gpt-5.2, claude-opus-4-5]
  - Variables: topic,audience,goal,

- **[Persuasive Facebook Marketplace Listing](writing/facebook-marketplace-listing.md)**
  - Description: Craft a truthful, persuasive classified ad using Cialdini’s principles to sell items quickly.
  - Tags: [marketplace, sales, persuasion, listing]
  - Models: [gpt-5.2, claude-opus-4-5]
  - Variables: item_description,item_photo,item_age,condition_notes,accessories,pickup_area,delivery_option,price_info,selling_reason,time_pressure,interest_signals,

- **[GPT Generator](writing/gpt-generator.md)**
  - Description: Use this prompt to generate other prompts.
  - Tags: [prompt, prompts, prompt-generation]
  - Models: [gpt-5.2, claude-opus-4-5]
  - Variables: variable_name,

- **[Project Management Mentor for Event Planning](writing/project-management-mentor-event-planning.md)**
  - Description: Mentor-style prompt to guide volunteer event planners through project management for a one-day training session.
  - Tags: [project-management,event-planning,mentoring,scouting]
  - Models: [gpt-5.2]
  - Variables: project_name,event_date,event_location,target_audience,expected_attendance,project_goal,your_role,key_stakeholders,budget,confirmed_resources,known_constraints,current_status,communication_channels,your_pm_experience_level,mentoring_style_preference,project_name,event_date,event_location,target_audience,expected_attendance,project_goal,your_role,key_stakeholders,budget,confirmed_resources,known_constraints,current_status,communication_channels,your_pm_experience_level,mentoring_style_preference,


## By Tag

- **analysis**:
  - [analysis/data-summary.md](analysis/data-summary.md)
- **blog**:
  - [writing/blog-outline.md](writing/blog-outline.md)
- **event-planning**:
  - [writing/project-management-mentor-event-planning.md](writing/project-management-mentor-event-planning.md)
- **listing**:
  - [writing/facebook-marketplace-listing.md](writing/facebook-marketplace-listing.md)
- **marketplace**:
  - [writing/facebook-marketplace-listing.md](writing/facebook-marketplace-listing.md)
- **mentoring**:
  - [writing/project-management-mentor-event-planning.md](writing/project-management-mentor-event-planning.md)
- **outline**:
  - [writing/blog-outline.md](writing/blog-outline.md)
- **persuasion**:
  - [writing/facebook-marketplace-listing.md](writing/facebook-marketplace-listing.md)
- **project-management**:
  - [writing/project-management-mentor-event-planning.md](writing/project-management-mentor-event-planning.md)
- **prompt**:
  - [writing/gpt-generator.md](writing/gpt-generator.md)
- **prompt-generation**:
  - [writing/gpt-generator.md](writing/gpt-generator.md)
- **prompts**:
  - [writing/gpt-generator.md](writing/gpt-generator.md)
- **refactor**:
  - [coding/refactor-function.md](coding/refactor-function.md)
- **risks**:
  - [analysis/data-summary.md](analysis/data-summary.md)
- **sales**:
  - [writing/facebook-marketplace-listing.md](writing/facebook-marketplace-listing.md)
- **scouting**:
  - [writing/project-management-mentor-event-planning.md](writing/project-management-mentor-event-planning.md)
- **step-by-step**:
  - [coding/refactor-function.md](coding/refactor-function.md)
- **structure**:
  - [writing/blog-outline.md](writing/blog-outline.md)
- **summary**:
  - [analysis/data-summary.md](analysis/data-summary.md)
- **testing**:
  - [coding/refactor-function.md](coding/refactor-function.md)

## By Model

### claude-opus-4-5
- [analysis/data-summary.md](analysis/data-summary.md)
- [coding/refactor-function.md](coding/refactor-function.md)
- [writing/gpt-generator.md](writing/gpt-generator.md)
- [writing/facebook-marketplace-listing.md](writing/facebook-marketplace-listing.md)
- [writing/blog-outline.md](writing/blog-outline.md)
### gpt-5.2
- [analysis/data-summary.md](analysis/data-summary.md)
- [coding/refactor-function.md](coding/refactor-function.md)
- [writing/gpt-generator.md](writing/gpt-generator.md)
- [writing/project-management-mentor-event-planning.md](writing/project-management-mentor-event-planning.md)
- [writing/facebook-marketplace-listing.md](writing/facebook-marketplace-listing.md)
- [writing/blog-outline.md](writing/blog-outline.md)

## Quick Search Commands

Search by tag:
```bash
grep -r "tags:.*refactor" prompts/ --include="*.md"
```

Search by model:
```bash
grep -r "models:.*gpt-5.2" prompts/ --include="*.md"
```

Search by variable:
```bash
grep -r "{{language}}" prompts/ --include="*.md"
```

Find prompts with optional variables:
```bash
grep -r "required: false" prompts/ --include="*.md"
```

---

## Skills

Claude/Copilot skills that extend AI assistant capabilities.

- **[prompt-generator](../skills/updated-skills/prompt-generator/SKILL.md)**
  - Generate production-quality prompts through structured discovery.

- **[prompt-judge](../skills/updated-skills/prompt-judge/SKILL.md)**
  - Evaluate and refine prompts for production deployment.

- **[prompt-optimizer](../skills/updated-skills/prompt-optimizer/SKILL.md)**
  - Optimize prompts for token efficiency while preserving functionality.

*Last updated: 2026-03-09*
*To regenerate: `scripts/generate-index.sh`*
