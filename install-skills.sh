#!/bin/bash

# OpenYIDA Skills installer
# 功能：从 Git 仓库获取 skills 并安装到 .agents 目录

set -e

SKILLS_REPO="https://gh-proxy.org/https://github.com/openyida/yida-skills.git"
SKILLS_REPO_SSH="git@github.com:openyida/yida-skills.git"
SKILLS_BRANCH="main"
AGENTS_DIR=".agents"
CACHE_DIR=".cache"

if ssh -T -o BatchMode=yes git@github.com 2>/dev/null; then
    SKILLS_REPO="$SKILLS_REPO_SSH"
    echo "SSH authentication is available. Using SSH clone."
else
    echo "Using HTTP clone."
fi

echo "Installing OpenYIDA skills..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CACHE_PATH="$SCRIPT_DIR/$CACHE_DIR"
AGENTS_PATH="$SCRIPT_DIR/$AGENTS_DIR"
REPO_CACHE_PATH="$CACHE_PATH/yida-skills"

mkdir -p "$CACHE_PATH"
mkdir -p "$AGENTS_PATH"

if [ -d "$REPO_CACHE_PATH/.git" ] && [ -d "$REPO_CACHE_PATH/skills" ]; then
    echo "Cached repository found. Pulling latest changes..."
    cd "$REPO_CACHE_PATH"
    git pull origin "$SKILLS_BRANCH"
    cd "$SCRIPT_DIR"
else
    echo "Cloning skills repository..."
    rm -rf "$REPO_CACHE_PATH"
    git clone -b "$SKILLS_BRANCH" --depth 1 "$SKILLS_REPO" "$REPO_CACHE_PATH"
fi

if [ -d "$REPO_CACHE_PATH/skills" ]; then
    echo "Moving skills into $AGENTS_DIR..."
    rm -rf "$AGENTS_PATH/skills"
    mv "$REPO_CACHE_PATH/skills" "$AGENTS_PATH/skills"
else
    echo "Could not find skills directory in cached repository."
    exit 1
fi

if [ -d "$AGENTS_PATH/skills" ]; then
    echo "Skills installed successfully."
    echo "Install path: $AGENTS_PATH/skills"
    echo "Installed skills:"
    ls -1 "$AGENTS_PATH/skills" | cat
else
    echo "Installation failed."
    exit 1
fi

echo "Installation complete."
