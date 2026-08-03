# DubuSPlayground Nebula 배포 관리

이 프로젝트는 Helios Launcher용 `distribution.json`을 생성하는 Nebula 작업 폴더입니다.

현재 서버 설정은 다음 기준으로 맞춰져 있습니다.

| 항목 | 값 |
| --- | --- |
| 서버 ID | `DubuSPlayground-26.2` |
| 표시 이름 | `Dubu's Playground` |
| Minecraft 버전 | `26.2` |
| 로더 | Fabric |
| Fabric Loader | `0.19.3` |
| 서버 접속 주소 | `{server_ip}:25565` |
| 파일 다운로드 주소 | `http://{server_ip}/` |
| Nebula 루트 | `NebulaRoot` |

## 가장 자주 쓰는 명령

작업은 이 폴더에서 실행합니다.

```powershell
cd "C:\Users Files\mjk\Game\Minecraft\Java\Server\DubuSPlaygroundSeason1Project\Development-DubuSPlaygroundSeason1PatchServer"
```

모드, 설정 파일, 아이콘을 바꾼 뒤 배포 파일을 다시 만들 때:

```powershell
npm.cmd run start -- generate distro
```

TypeScript 컴파일만 확인할 때:

```powershell
npm.cmd run tsc
```

PowerShell에서 `npm`이 실행 정책 때문에 막히면 `npm.cmd`를 사용합니다.

## 중요한 파일과 폴더

```text
.
├─ .env
├─ NebulaRoot/
│  ├─ distribution.json
│  ├─ meta/
│  │  └─ distrometa.json
│  ├─ repo/
│  ├─ schemas/
│  └─ servers/
│     └─ DubuSPlayground-26.2/
│        ├─ servermeta.json
│        ├─ fabricmods/
│        │  ├─ required/
│        │  ├─ optionalon/
│        │  └─ optionaloff/
│        ├─ files/
│        └─ libraries/
```

`.env`는 Nebula 실행 설정입니다. 이 파일은 `.gitignore`에 들어가 있으므로 보통 Git에 올라가지 않습니다.

`NebulaRoot/distribution.json`은 Helios Launcher가 읽는 최종 배포 파일입니다.

`NebulaRoot/repo/`는 Fabric Loader와 라이브러리처럼 런처가 다운로드해야 하는 파일들이 저장되는 캐시/배포 폴더입니다.

## 모드 추가 방법

Fabric 모드 `.jar` 파일은 아래 폴더 중 하나에 넣습니다.

```text
NebulaRoot/servers/DubuSPlayground-26.2/fabricmods/required/
NebulaRoot/servers/DubuSPlayground-26.2/fabricmods/optionalon/
NebulaRoot/servers/DubuSPlayground-26.2/fabricmods/optionaloff/
```

대부분의 서버 필수 모드는 `required`에 넣으면 됩니다.

`required`는 모든 플레이어가 반드시 받는 모드입니다.

`optionalon`은 선택 모드지만 기본으로 켜져 있는 모드입니다.

`optionaloff`는 선택 모드지만 기본으로 꺼져 있는 모드입니다.

모드를 넣은 뒤 반드시 다시 생성합니다.

```powershell
npm.cmd run start -- generate distro
```

## 설정 파일 추가 방법

클라이언트에 같이 배포해야 하는 설정 파일은 `files` 폴더 안에 실제 마인크래프트 폴더 구조대로 넣습니다.

예를 들어 클라이언트의 `config/example.toml`로 들어가야 하는 파일이면:

```text
NebulaRoot/servers/DubuSPlayground-26.2/files/config/example.toml
```

리소스팩을 같이 배포해야 하면:

```text
NebulaRoot/servers/DubuSPlayground-26.2/files/resourcepacks/팩파일.zip
```

파일을 넣은 뒤 다시 생성합니다.

```powershell
npm.cmd run start -- generate distro
```

## 서버 아이콘 추가 방법

서버 아이콘은 아래 폴더에 `.png` 또는 `.jpg`로 넣습니다.

```text
NebulaRoot/servers/DubuSPlayground-26.2/server-icon.png
```

파일 이름은 꼭 `server-icon.png`일 필요는 없지만, 관리하기 쉽게 이 이름을 추천합니다.

아이콘을 넣은 뒤 다시 생성합니다.

```powershell
npm.cmd run start -- generate distro
```

정상 생성되면 `distribution.json`의 `icon` 값이 다음처럼 바뀝니다.

```text
http://{server_ip}/servers/DubuSPlayground-26.2/server-icon.png
```

## 서버 메타 수정

서버 이름, 설명, 접속 주소, 자동 접속 여부는 이 파일에서 수정합니다.

```text
NebulaRoot/servers/DubuSPlayground-26.2/servermeta.json
```

현재 핵심 값:

```json
{
  "meta": {
    "name": "Dubu's Playground",
    "description": "DubuSPlayground Minecraft 26.2 Fabric server",
    "address": "{server_ip}:25565",
    "mainServer": true,
    "autoconnect": true
  },
  "fabric": {
    "version": "0.19.3"
  }
}
```

수정한 뒤 다시 생성합니다.

```powershell
npm.cmd run start -- generate distro
```

## RSS와 공지

RSS는 런처에 뉴스/공지 목록을 띄우는 용도입니다.

현재는 사용하지 않도록 비워져 있습니다.

```text
NebulaRoot/meta/distrometa.json
```

공지 사이트나 RSS 피드가 생기면 `rss`에 주소를 넣으면 됩니다.

```json
{
  "meta": {
    "rss": "https://example.com/rss.xml"
  }
}
```

## 웹서버에 올려야 하는 것

`BASE_URL`이 `http://{server_ip}/`이므로, 웹서버의 루트 경로가 `NebulaRoot` 내용을 그대로 제공해야 합니다.

즉 브라우저에서 아래 주소들이 접근 가능해야 합니다.

```text
http://{server_ip}/distribution.json
http://{server_ip}/repo/...
http://{server_ip}/servers/DubuSPlayground-26.2/...
```

웹서버에 올릴 대상은 `NebulaRoot` 폴더 안의 내용입니다.

```text
NebulaRoot/distribution.json
NebulaRoot/repo/
NebulaRoot/servers/
```

`schemas`와 `meta`는 런처 다운로드에는 보통 필요하지 않지만, 서버 관리용으로 같이 백업해두면 좋습니다.

### Caddy로 웹서버 실행

이 프로젝트는 Python 웹서버를 쓰지 않고 Caddy로 `NebulaRoot`를 그대로 제공합니다.

저장소 루트의 `Caddyfile`은 아래처럼 `NebulaRoot`를 웹 루트로 잡습니다.

```caddyfile
:80 {
	root * ./NebulaRoot
	file_server
}
```

프로젝트 루트에서 실행합니다.

```powershell
caddy run
```

테스트용으로 80번 포트 대신 8080번 포트를 쓰려면 `Caddyfile`의 첫 줄을 `:8080 {`로 바꾸고 아래 주소로 확인합니다.

```text
http://localhost:8080/distribution.json
```

## 새 배포 반영 순서

1. 모드나 설정 파일을 원하는 폴더에 넣습니다.
2. 아래 명령으로 `distribution.json`을 다시 생성합니다.

```powershell
npm.cmd run start -- generate distro
```

3. `NebulaRoot` 안의 변경된 파일을 웹서버에 업로드합니다.
4. 브라우저에서 `http://{server_ip}/distribution.json`이 열리는지 확인합니다.
5. Helios Launcher에서 서버 목록과 다운로드가 정상인지 확인합니다.

## 자주 나는 문제

### `icon`이 `null`로 나옴

서버 폴더에 `.png` 또는 `.jpg` 아이콘이 없다는 뜻입니다.

```text
NebulaRoot/servers/DubuSPlayground-26.2/server-icon.png
```

위치에 아이콘을 넣고 다시 생성합니다.

### 모드를 넣었는데 런처가 안 받음

`generate distro`를 다시 실행했는지 확인합니다.

모드 파일이 `fabricmods/required`, `fabricmods/optionalon`, `fabricmods/optionaloff` 중 하나에 들어갔는지 확인합니다.

웹서버에 변경된 `distribution.json`과 모드 파일이 같이 올라갔는지 확인합니다.

### 다운로드가 실패함

`distribution.json` 안의 URL이 실제로 열리는지 브라우저에서 확인합니다.

예:

```text
http://{server_ip}/repo/lib/net/fabricmc/fabric-loader/0.19.3/fabric-loader-0.19.3.jar
```

안 열리면 웹서버 루트가 `NebulaRoot`와 맞지 않거나 파일 업로드가 빠진 것입니다.

### `npm`이 PowerShell에서 막힘

이 프로젝트에서는 `npm.cmd`를 사용합니다.

```powershell
npm.cmd run start -- generate distro
```

### Fabric 버전을 바꾸고 싶음

`servermeta.json`의 Fabric 버전을 바꿉니다.

```json
"fabric": {
  "version": "0.19.3"
}
```

그 다음 캐시까지 새로 받고 싶으면:

```powershell
npm.cmd run start -- generate distro --invalidateCache
```

## 모드 업데이트 방법

업데이트할 때는 모드 파일만 교체하지 말고 항상 `distribution.json`을 다시 생성해야 합니다. Nebula가 파일 크기와 MD5를 기록하기 때문에, JSON이 오래되면 런처 다운로드 검증이 실패할 수 있습니다.
