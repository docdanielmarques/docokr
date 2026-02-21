#!/bin/zsh
set -e

PROJECT_DIR="/Users/marques/Documents/Drive Marques/Projetos Github/OKR AB2"
BRANCH="main"

cd "$PROJECT_DIR"

current_branch=$(git rev-parse --abbrev-ref HEAD)
if [ "$current_branch" != "$BRANCH" ]; then
  git checkout "$BRANCH"
fi

git add -A

if git diff --cached --quiet; then
  git pull --rebase origin "$BRANCH" || true
  git push origin "$BRANCH"
  /usr/bin/osascript -e 'display notification "Sem novas alterações locais. Apenas GitHub (docokr) sincronizado." with title "OKR AB2"'
  exit 0
fi

msg="sync: $(date '+%Y-%m-%d %H:%M:%S')"
git commit -m "$msg"

git pull --rebase origin "$BRANCH" || true
git push origin "$BRANCH"

/usr/bin/osascript -e 'display notification "Atualizações enviadas apenas para GitHub (docokr)." with title "OKR AB2"'
