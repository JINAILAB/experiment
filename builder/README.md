### 인프라 설정

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
- env/.env 샘플 생성

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
