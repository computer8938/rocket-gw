# Rocket Alpha Gateway

`C:\rocket-gw`는 Rocket Alpha 통합 게이트웨이다.

## 역할

- 외부 단일 진입점 제공
- admin/customer frontend 정적 서비스 연결
- auth / admin scraper / admin processor / customer API 프록시

## 현재 포트 체계

- Public gateway: `http://localhost:4760`

## 라우팅

- `/admin/` -> `rocket-alpha-admin-frontend:80`
- `/` -> `rocket-alpha-customer-frontend:80`
- `/api/auth/` -> `rocket-auth:8090`
- `/api/admin/scraper/` -> `scraper-api:8081`
- `/api/admin/processor/` -> `processor:8082`
- `/api/customer/` -> `customer-api:8091`

## 개별 기동

```powershell
cd C:\rocket-gw
.\start.ps1
```

중지:

```powershell
.\stop.ps1
```

## 수동 기동

```powershell
docker compose up -d --build
```

## 서비스 재기동 순서

| 순서 | 선행 대상 | 현재 패키지 위치 |
|---|---|---|
| 1 | `C:\rocket-alpha` | backend/API 네트워크 준비 |
| 2 | `C:\rocket-auth` | `/api/auth/` upstream |
| 3 | `C:\rocket-alpha-admin-fe` | `/admin/` upstream |
| 4 | `C:\rocket-alpha-cus-fe` | `/` upstream |
| 5 | `C:\rocket-gw` | 현재 패키지, 마지막 기동 권장 |

개별 재기동:

```powershell
cd C:\rocket-gw
.\stop.ps1
.\start.ps1
```

## 비고

- gateway는 admin/customer/auth 관련 컨테이너가 먼저 떠 있어야 정상 동작한다.
- 통합 사용자는 기본적으로 gateway `4760`만 진입점으로 사용한다.
