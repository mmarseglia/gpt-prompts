#!/usr/bin/env node
// Validate a prompt's YAML frontmatter against the repository schema
// Uses only Node.js built-ins (no external dependencies)
// Simplified validator that checks critical fields without full YAML parsing

const fs = require('fs');
const path = require('path');

function extractFrontmatter(filePath) {
  const content = fs.readFileSync(filePath, 'utf8');
  const parts = content.split(/^---\s*$/m);

  if (parts.length < 3) {
    console.error(`Error: No YAML frontmatter found in ${filePath}`);
    process.exit(1);
  }

  return parts[1];
}

function getField(yaml, fieldName) {
  const regex = new RegExp(`^${fieldName}:\\s*(.+)$`, 'm');
  const match = yaml.match(regex);
  if (!match) return null;

  let value = match[1].trim();

  // Remove quotes
  if ((value.startsWith('"') && value.endsWith('"')) ||
      (value.startsWith("'") && value.endsWith("'"))) {
    value = value.slice(1, -1);
  }

  // Parse array [a, b, c]
  if (value.startsWith('[') && value.endsWith(']')) {
    const inner = value.slice(1, -1);
    if (!inner.trim()) return [];
    return inner.split(',').map(v => v.trim().replace(/^["']|["']$/g, ''));
  }

  // Parse numbers
  if (!isNaN(value) && value !== '') {
    return parseFloat(value);
  }

  // Parse booleans
  if (value === 'true') return true;
  if (value === 'false') return false;

  return value;
}

function hasArraySection(yaml, sectionName) {
  const regex = new RegExp(`^${sectionName}:\\s*$`, 'm');
  return regex.test(yaml);
}

function getArrayItems(yaml, sectionName) {
  // Find the section
  const regex = new RegExp(`^${sectionName}:\\s*$\\n((\\s+-\\s+.+\\n)+)`, 'm');
  const match = yaml.match(regex);

  if (!match) {
    // Try to find if section exists but is malformed
    if (yaml.includes(`${sectionName}:`)) {
      return []; // Section exists but has no items
    }
    return null; // Section doesn't exist
  }

  const items = match[1];
  const itemList = items.match(/^\s+-\s+(.+)$/gm);
  if (!itemList) return [];

  return itemList.map(item => item.replace(/^\s+-\s+/, '').trim());
}

function getNestedArrayOfObjects(yaml, sectionName, requiredFields) {
  // Check if section exists
  if (!yaml.includes(`${sectionName}:`)) return null;

  const sectionRegex = new RegExp(`^${sectionName}:\\s*$\\n((?:\\s+.+\\n)+)`, 'm');
  const sectionMatch = yaml.match(sectionRegex);

  if (!sectionMatch) return [];

  const sectionContent = sectionMatch[1];
  const items = [];
  let currentItem = {};

  const lines = sectionContent.split('\n');
  for (let line of lines) {
    if (!line.trim()) continue;

    if (line.trim().startsWith('- ')) {
      // New array item
      if (Object.keys(currentItem).length > 0) {
        items.push(currentItem);
      }
      currentItem = {};

      // Check for inline key:value after dash
      const inline = line.trim().substring(2).trim();
      if (inline.includes(':')) {
        const [k, ...v] = inline.split(':');
        currentItem[k.trim()] = v.join(':').trim().replace(/^["']|["']$/g, '');
      }
    } else if (line.includes(':')) {
      // Key-value in current object
      const [key, ...value] = line.trim().split(':');
      let val = value.join(':').trim();
      val = val.replace(/^["']|["']$/g, '');

      // Parse booleans and numbers
      if (val === 'true') val = true;
      else if (val === 'false') val = false;
      else if (!isNaN(val) && val !== '') val = parseFloat(val);

      currentItem[key.trim()] = val;
    }
  }

  if (Object.keys(currentItem).length > 0) {
    items.push(currentItem);
  }

  return items;
}

function isDate(value) {
  if (!value) return false;
  const str = value.toString();
  if (!/^\d{4}-\d{2}-\d{2}$/.test(str)) return false;
  const date = new Date(str);
  return !isNaN(date.getTime()) && date.toISOString().startsWith(str);
}

function isSemver(value) {
  if (!value) return false;
  return /^\d+\.\d+\.\d+$/.test(value.toString());
}

function matchesPattern(value, pattern) {
  if (!value) return false;
  return pattern.test(value.toString());
}

// Main validation
const promptFile = process.argv[2];
const expectedUseCase = path.basename(path.dirname(promptFile));

if (!promptFile) {
  console.error('Usage: node tests/validate-frontmatter.js <prompt-file>');
  process.exit(1);
}

if (!fs.existsSync(promptFile)) {
  console.error(`Error: File not found: ${promptFile}`);
  process.exit(1);
}

const yaml = extractFrontmatter(promptFile);
const errors = [];

// Check required fields
const requiredFields = ['title', 'description', 'use_case', 'models', 'tags', 'version', 'variables', 'examples'];

requiredFields.forEach(field => {
  if (!yaml.includes(`${field}:`)) {
    errors.push(`Missing required field '${field}'`);
  }
});

// Validate specific fields
const title = getField(yaml, 'title');
if (title && typeof title !== 'string') {
  errors.push('title must be a string');
}

const description = getField(yaml, 'description');
if (description && typeof description !== 'string') {
  errors.push('description must be a string');
}

const useCase = getField(yaml, 'use_case');
if (useCase && typeof useCase !== 'string') {
  errors.push('use_case must be a string');
} else if (useCase && useCase !== expectedUseCase && promptFile.includes('/prompts/')) {
  errors.push(`use_case '${useCase}' does not match directory '${expectedUseCase}'`);
}

const models = getField(yaml, 'models');
if (models) {
  if (!Array.isArray(models)) {
    errors.push('models must be an array');
  } else if (!models.every(m => matchesPattern(m, /^[a-z0-9.-]+$/))) {
    errors.push('models must match pattern ^[a-z0-9.-]+$');
  }
}

const tags = getField(yaml, 'tags');
if (tags) {
  if (!Array.isArray(tags)) {
    errors.push('tags must be an array');
  } else if (!tags.every(t => matchesPattern(t, /^[a-z0-9-]+$/))) {
    errors.push('tags must be lowercase with hyphens only');
  }
}

const version = getField(yaml, 'version');
if (version && !isSemver(version)) {
  errors.push('version must follow SemVer (X.Y.Z)');
}

const created = getField(yaml, 'created');
if (created && !isDate(created)) {
  errors.push('created must be YYYY-MM-DD');
}

const updated = getField(yaml, 'updated');
if (updated && !isDate(updated)) {
  errors.push('updated must be YYYY-MM-DD');
}

const qualityScore = getField(yaml, 'quality_score');
if (qualityScore !== null && (typeof qualityScore !== 'number' || qualityScore < 0 || qualityScore > 10)) {
  errors.push('quality_score must be a number between 0 and 10');
}

// Validate variables array
const variables = getNestedArrayOfObjects(yaml, 'variables');
if (variables === null) {
  errors.push('Missing required field \'variables\'');
} else if (variables.length === 0) {
  errors.push('variables must have at least one item');
} else {
  variables.forEach((v, idx) => {
    if (!v.name) errors.push(`variables[${idx}] missing 'name'`);
    if (!('required' in v)) errors.push(`variables[${idx}] missing 'required'`);
    if (!v.note) errors.push(`variables[${idx}] missing 'note'`);

    if (v.name && !matchesPattern(v.name, /^[a-z_][a-z0-9_]*$/)) {
      errors.push(`variables[${idx}].name must match ^[a-z_][a-z0-9_]*$`);
    }

    if ('type' in v && !['string', 'code', 'number', 'boolean'].includes(v.type)) {
      errors.push(`variables[${idx}].type must be string|code|number|boolean`);
    }
  });
}

// Validate examples array
const examples = getNestedArrayOfObjects(yaml, 'examples');
if (examples === null) {
  errors.push('Missing required field \'examples\'');
} else if (examples.length === 0) {
  errors.push('examples must have at least one item');
} else {
  examples.forEach((ex, idx) => {
    if (!ex.input) errors.push(`examples[${idx}] missing 'input'`);
    if (!ex.expected_behavior) errors.push(`examples[${idx}] missing 'expected_behavior'`);

    if (ex.test_date && !isDate(ex.test_date)) {
      errors.push(`examples[${idx}].test_date must be YYYY-MM-DD`);
    }
  });
}

// Validate tested_with array if present
if (yaml.includes('tested_with:')) {
  const testedWith = getNestedArrayOfObjects(yaml, 'tested_with');
  if (testedWith && testedWith.length > 0) {
    testedWith.forEach((t, idx) => {
      if (!t.model) errors.push(`tested_with[${idx}] missing 'model'`);
      if (!t.status) errors.push(`tested_with[${idx}] missing 'status'`);

      if (t.status && !['verified', 'experimental', 'deprecated'].includes(t.status)) {
        errors.push(`tested_with[${idx}].status must be verified|experimental|deprecated`);
      }

      if (t.last_tested && !isDate(t.last_tested)) {
        errors.push(`tested_with[${idx}].last_tested must be YYYY-MM-DD`);
      }
    });
  }
}

// Output results
if (errors.length === 0) {
  console.log(`✅ ${promptFile} passed schema validation`);
  process.exit(0);
} else {
  console.log(`❌ ${promptFile} failed validation:`);
  errors.forEach(e => console.log(`  - ${e}`));
  process.exit(1);
}
