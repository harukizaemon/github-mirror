#!/bin/sh

# Load environment variables securely
set -a
if [ -f "$HOME/.env" ]; then
    . "$HOME/.env"
else
    echo "Error: $HOME/.env file not found"
    exit 1
fi
set +a

# Validate required variables
if [ -z "$GITHUB_USER" ] || [ -z "$GITHUB_PAT" ]; then
    echo "Error: GITHUB_USER and GITHUB_PAT must be set in $HOME/.env"
    exit 1
fi

# Configuration
TARGET_DIR="$HOME/github_mirrors"

# Create target directory
mkdir -p "$TARGET_DIR"

# Fetch repository list from GitHub API
repos=$(curl -s -H "Authorization: Bearer $GITHUB_PAT" "https://api.github.com/user/repos?per_page=100" | grep '"full_name"' | sed -E 's/.*"full_name": "([^"]+)".*/\1/')

# Mirror each repository
for repo in $repos; do
    repo_url="https://$GITHUB_PAT@github.com/$repo"
    mirror_dir="$TARGET_DIR/$repo"

    if [ -d "$mirror_dir" ]; then
        # Update existing mirror
        echo "Updating mirror for $repo"
        cd "$mirror_dir"
        git remote set-url origin "$repo_url"
        git remote update --prune
    else
        # Create new mirror
        echo "Creating mirror for $repo"
        git clone --mirror "$repo_url" "$mirror_dir"
    fi
done
