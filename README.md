# Experiment Infrastructure

Docker/Podman 기반 DL 실험 환경 구축을 위한 인프라 파일들입니다.

## 📋 구조

```
├── experiment_infra
│   ├── builder
│   │   ├── docker-compose.yml
│   │   ├── Dockerfile
│   │   ├── env
│   │   ├── podman-compose.yml
│   │   └── README.md
│   ├── data
│   ├── experiments
│   ├── notebooks
│   └── src
│       ├── data
│       ├── models
│       │   └── __init__.py
│       └── utils
│           └── __init__.py
```

## 🚀 사용 방법

### 1. 새 실험 프로젝트 생성

```bash
# 실험 템플릿 복사 (github.com/JINAILAB/experiment_infra)
git clone https://github.com/JINAILAB/experiment_infra.git

###
cd ./data/common/experiment_infra/builder
```

### 2. 인프라 설정

```bash
# Podman
podman-compose -f podman-compose.yml --env-file env/.env build

# Docker
docker-compose -f docker-compose.yml --env-file env/.env build
```

이 명령어는 다음을 수행합니다:
- `builder/` 폴더 생성
- Dockerfile, docker-compose.yml, podman-compose.yml 복사
- run.sh 실행 스크립트 복사
- env/jyp.env 샘플 생성

### 3. 환경 설정

**필수 설정(env 파일):**
- `CONTAINER_NAME`: 컨테이너 이름
- `USER_WORKDIR`: workspace 경로 (예: jyp/my_experiment)
- `GIT_USER_NAME`, `GIT_USER_EMAIL`: Git 설정

**선택 설정:**
- `GPU_DEVICES`: 사용할 GPU (all, 0, 0,1 등)
- `WANDB_API_KEY`: Weights & Biases API 키
- `HF_TOKEN`: HuggingFace 토큰
- 그 외 환경변수 등등

### 5. 컨테이너 접속

```bash
# Podman
podman exec -it <CONTAINER_NAME> /bin/bash

# Docker
docker exec -it <CONTAINER_NAME> /bin/bash
```

## 🔧 주요 기능

### 자동 템플릿 초기화
컨테이너 최초 실행 시 workspace에 `src/` 폴더가 없으면 자동으로 템플릿을 복사합니다.

### GPU 지원
- Docker: `runtime: nvidia` 사용
- Podman: device mapping + nvidia capabilities

### uv 패키지 매니저
이미지에 uv가 사전 설치되어 있습니다:

```bash
# 패키지 설치
uv add numpy pandas torch

# 스크립트 실행
uv run python train.py
```

### 볼륨 마운트
- Host: `/data/${USER_WORKDIR}`
- Container: `/workspace`

## 📦 포함된 패키지

**Base Image:** `pytorch/pytorch:2.5.1-cuda12.4-cudnn9-runtime`

**시스템 패키지:**
- 개발 도구: git, curl, wget, tmux, vim, nano
- 빌드 도구: cmake, ninja, gcc, make
- 모니터링: htop, sudo

**Python 도구:**
- uv (Python 패키지 매니저)
- pip (최신 버전)
