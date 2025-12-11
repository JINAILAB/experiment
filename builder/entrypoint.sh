#!/bin/bash
set -e

# Workspace Initialization
cd /workspace

# Git Configuration
if [ -n "$GIT_USER_NAME" ] && [ -n "$GIT_USER_EMAIL" ]; then
    git config --global user.name "$GIT_USER_NAME"
    git config --global user.email "$GIT_USER_EMAIL"
    echo "✅ Git configured: $GIT_USER_NAME <$GIT_USER_EMAIL>"
fi

# src 폴더가 없으면 초기화 진행 (최초 실행 시)
if [ ! -d "src" ]; then
    echo "🚀 Initializing workspace..."

    # .git 폴더가 없으면 초기화
    if [ ! -d ".git" ]; then
        git init
    fi
    
    # 1. 기존 origin 제거 및 새로 추가
    # git remote remove origin 2>/dev/null || true
    git remote add origin https://github.com/JINAILAB/experiment.git
    
    # 2. 코드 가져오기 (Github의 파일들이 들어옴)
    echo "📥 Pulling code from GitHub..."
    git pull origin main
    
    # 3. 리모트 삭제 (요청하신 대로)
    git remote remove origin
    
    # =========================================================
    # 4. [핵심] 로컬 설정 파일로 덮어쓰기 (교체 단계)
    # =========================================================
    echo "🔄 Overwriting configuration files from build context..."
    
    # Dockerfile 덮어쓰기
    if [ -d "/app/builder" ]; then
        cp -rf /app/builder/* /workspace/builder/
        echo "   - Dockerfile replaced."
    fi

    rm -r /app/builder

    echo "✅ Initialization complete."
fi

exec "$@"