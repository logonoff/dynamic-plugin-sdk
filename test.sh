#!/bin/bash
set -exuo pipefail

# Setup environment
export NODE_OPTIONS="--max-old-space-size=4096"

# Print system information
echo "node $(node -v)"
echo "npm $(npm -v)"
echo "pnpm $(pnpm -v)"

# Install dependencies
pnpm install --frozen-lockfile

# Build packages
pnpm build

# Analyze code for potential problems
pnpm lint

# Run unit tests
pnpm test

# Run Cypress component tests
pnpm test-component

# Upload code coverage
./prow-codecov.sh 2>/dev/null
