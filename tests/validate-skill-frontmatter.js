#!/usr/bin/env node
// Validate a skill's YAML frontmatter against the skill schema
// Uses only Node.js built-ins (no external dependencies)

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

  return value;
}

// Main validation
const skillFile = process.argv[2];

if (!skillFile) {
  console.error('Usage: node tests/validate-skill-frontmatter.js <skill-file>');
  process.exit(1);
}

if (!fs.existsSync(skillFile)) {
  console.error(`Error: File not found: ${skillFile}`);
  process.exit(1);
}

const yaml = extractFrontmatter(skillFile);
const errors = [];

// Check required fields
const requiredFields = ['name', 'description'];
requiredFields.forEach(field => {
  if (!yaml.includes(`${field}:`)) {
    errors.push(`Missing required field '${field}'`);
  }
});

// Validate name
const name = getField(yaml, 'name');
if (name) {
  if (typeof name !== 'string') {
    errors.push('name must be a string');
  } else {
    if (name.length < 2) {
      errors.push('name must be at least 2 characters');
    }
    if (name.length > 50) {
      errors.push('name must be at most 50 characters');
    }
    if (!/^[a-z][a-z0-9-]*$/.test(name)) {
      errors.push(`name '${name}' must match pattern ^[a-z][a-z0-9-]*$ (lowercase, hyphens, starts with letter)`);
    }
  }

  // Validate name matches directory name
  const dirName = path.basename(path.dirname(skillFile));
  if (dirName !== '_template' && name !== dirName) {
    errors.push(`name '${name}' does not match directory name '${dirName}'`);
  }
}

// Validate description
const description = getField(yaml, 'description');
if (description) {
  if (typeof description !== 'string') {
    errors.push('description must be a string');
  } else if (description.length < 10) {
    errors.push('description must be at least 10 characters');
  }
}

// Validate optional version if present
const version = getField(yaml, 'version');
if (version && !/^\d+\.\d+\.\d+$/.test(version)) {
  errors.push('version must follow SemVer (X.Y.Z)');
}

// Output results
if (errors.length === 0) {
  console.log(`✅ ${skillFile} passed skill schema validation`);
  process.exit(0);
} else {
  console.log(`❌ ${skillFile} failed skill validation:`);
  errors.forEach(e => console.log(`  - ${e}`));
  process.exit(1);
}
