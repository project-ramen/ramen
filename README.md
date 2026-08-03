# ramen

Real-time Automated Markdown Engine for Notes

## Clone

서브모듈까지 한 번에 받으려면:

```bash
git clone --recurse-submodules https://github.com/project-ramen/ramen.git
cd ramen
```

이미 clone한 상태라면:

```bash
git submodule update --init --recursive
```

서브모듈 최신 커밋으로 갱신:

```bash
git submodule update --remote --merge
```

## 환경변수

```bash
cp .env.example .env
```

`.env`를 열어 `POSTGRES_PASSWORD`, `RAMEN_ADMIN_PASSWORD`를 채우세요.

## 개발 (docker-compose.dev.yml)

로컬 소스(`Dockerfile`)로 이미지를 직접 빌드합니다.

```bash
docker compose -f docker-compose.dev.yml up --build
```

`server/src`, `server/package.json`, `web` 변경 감지(sync+restart / rebuild)가 필요하면 `watch` 사용:

```bash
docker compose -f docker-compose.dev.yml watch
```

종료:

```bash
docker compose -f docker-compose.dev.yml down
```

## 프로덕션 (docker-compose.prod.yml)

레지스트리에 미리 빌드/푸시된 이미지(`REGISTRY_IMAGE:IMAGE_TAG`, 기본 `docker.foxstar.app/ramen/server:latest`)를 사용합니다. 이미지 빌드/푸시는 [ramen-dev](https://github.com/project-ramen/ramen-dev)의 `scripts/docker-build-push.sh`를 참고하세요.

```bash
docker compose -f docker-compose.prod.yml up -d
```

로그 확인:

```bash
docker compose -f docker-compose.prod.yml logs -f
```

종료:

```bash
docker compose -f docker-compose.prod.yml down
```
