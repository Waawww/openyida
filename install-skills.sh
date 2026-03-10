#!/bin/bash

# OpenYIDA Skills 安装脚本
# 功能：从 Git 仓库获取 skills 并安装到 .claude 目录

set -e

# 配置
SKILLS_REPO="http://gitlab.alibaba-inc.com/alex.mm/yida-skills.git"
SKILLS_REPO_SSH="git@gitlab.alibaba-inc.com:alex.mm/yida-skills.git"
SKILLS_BRANCH="feat/init"
SKILLS_DIR=".claude"

# 检测是否可以使用 SSH
if ssh -T -o BatchMode=yes git@gitlab.alibaba-inc.com 2>/dev/null; then
    SKILLS_REPO="$SKILLS_REPO_SSH"
    echo "🔑 检测到 SSH 认证可用，使用 SSH 方式克隆"
else
    echo "📝 使用 HTTP 方式克隆（可能需要输入密码）"
fi

echo "🚀 开始安装 OpenYIDA Skills..."

# 获取绝对路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_PATH="$SCRIPT_DIR/$SKILLS_DIR"

# 检查是否已存在 .claude 目录
if [ -d "$TARGET_PATH" ]; then
    echo "📂 检测到已存在的 $SKILLS_DIR 目录，正在拉取最新代码..."
    
    # 备份 .gitkeep 文件（如果存在）
    GITKEEP_BACKUP=""
    if [ -f "$TARGET_PATH/.gitkeep" ]; then
        echo "📄 发现 .gitkeep 文件，正在备份..."
        cp "$TARGET_PATH/.gitkeep" "$TARGET_PATH/.gitkeep.backup"
        GITKEEP_BACKUP="true"
    fi
    
    cd "$TARGET_PATH"
    
    # 检查是否是 git 仓库
    if [ -d ".git" ]; then
        # 检查是否已配置稀疏检出
        if [ -f ".git/info/sparse-checkout" ]; then
            echo "🔄 执行 git pull..."
            git pull origin "$SKILLS_BRANCH"
            echo "🔄 恢复工作区文件..."
            git checkout .
            echo "✅ Skills 已更新到最新版本！"
        else
            echo "⚠️  未配置稀疏检出，正在配置..."
            git sparse-checkout init --cone
            git sparse-checkout set skills
            git checkout
            echo "✅ Skills 已配置并更新！"
        fi
    else
        echo "⚠️  $SKILLS_DIR 不是 git 仓库，需要重新克隆"
        cd "$SCRIPT_DIR"
        rm -rf "$SKILLS_DIR"
        echo "📦 克隆 skills 仓库..."
        git clone -b "$SKILLS_BRANCH" --no-checkout --depth 1 "$SKILLS_REPO" "$SKILLS_DIR"
        cd "$TARGET_PATH"
        git sparse-checkout init --cone
        git sparse-checkout set skills
        git checkout
        cd "$SCRIPT_DIR"
        echo "✅ Skills 克隆成功！"
    fi
    cd "$SCRIPT_DIR"
    
    # 清理非 skills 文件（只保留 .git 目录、skills 目录和 .gitkeep 文件）
    echo "🧹 清理非 skills 文件..."
    find "$TARGET_PATH" -maxdepth 1 -type f ! -name ".gitkeep" -delete
    if [ -n "$GITKEEP_BACKUP" ] && [ -f "$TARGET_PATH/.gitkeep.backup" ]; then
        echo "📄 恢复 .gitkeep 文件..."
        mv "$TARGET_PATH/.gitkeep.backup" "$TARGET_PATH/.gitkeep"
    fi
    echo "✅ 清理完成，仅保留 skills 目录"
else
    # 克隆 skills 仓库（只克隆 skills 目录）
    echo "📦 克隆 skills 仓库..."
    echo "   仓库地址：$SKILLS_REPO"
    echo "   分支：$SKILLS_BRANCH"
    echo "   只克隆 skills 目录"
    
    # 使用稀疏检出只克隆 skills 目录
    git clone -b "$SKILLS_BRANCH" --no-checkout --depth 1 "$SKILLS_REPO" "$SKILLS_DIR"
    cd "$TARGET_PATH"
    git sparse-checkout init --cone
    git sparse-checkout set skills
    git checkout
    cd "$SCRIPT_DIR"
    
    echo "✅ Skills 克隆成功！"
fi

# 验证安装
if [ -d "$TARGET_PATH/skills" ]; then
    echo "✅ Skills 安装成功！"
    echo ""
    echo "📂 安装位置：$TARGET_PATH/skills"
    echo ""
    
    # 显示安装的 skills 列表
    echo "📦 已安装的 Skills:"
    ls -1 "$TARGET_PATH/skills" | cat
else
    echo "❌ 安装失败"
    exit 1
fi

echo ""
echo "🎉 安装完成！"
