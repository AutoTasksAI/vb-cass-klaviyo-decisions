#!/usr/bin/env bash
# Deploy static decision app to GitHub Pages (AutoTasksAI/vb-cass-klaviyo-decisions).
set -euo pipefail
cd "$(dirname "$0")"
REPO="${REPO:-AutoTasksAI/vb-cass-klaviyo-decisions}"
BRANCH="${BRANCH:-main}"
echo "Pushing to ${REPO} (${BRANCH}) and ensuring GitHub Pages is on (root)…"
git status -sb || true
gh api -X POST "repos/${REPO}/pages" -f build_type=legacy -f source[branch]="${BRANCH}" -f source[path]=/ 2>/dev/null \
  || gh api -X PUT "repos/${REPO}/pages" -f build_type=legacy -f source[branch]="${BRANCH}" -f source[path]=/ 
gh api "repos/${REPO}/pages" --jq '{html_url:.html_url,status:.status,source:.source}'
