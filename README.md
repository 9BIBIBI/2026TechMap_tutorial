# Reality Composer Pro 3로 눈 내리는 겨울 마을 만들기

Reality Composer Pro 3에서 3D 에셋을 배치하고 Directional Light, 애니메이션 Sequence, Particle Emitter를 적용하는 한국어 DocC 튜토리얼 카탈로그입니다.

## 준비물

- Apple silicon Mac
- Reality Composer Pro 3 (Beta 4 이상)
- macOS Tahoe 26.5 이상
- Floor, Igloo, Tree, Rock, Log, Signpost, 애니메이션이 포함된 Snowman 에셋

## 폴더 구조

```text
2026TechMap_tutorial/
├── .github/workflows/deploy-docc.yml
├── SnowVillage.docc/
│   ├── Info.plist
│   ├── SnowVillage.tutorial
│   └── Tutorials/
│       ├── 01-BuildWinterVillage.tutorial
│       ├── 02-CreateWinterAtmosphere.tutorial
│       └── Resources/
│           └── 32개의 PNG placeholder
├── Scripts/
│   ├── build-docs.sh
│   ├── generate-placeholders.sh
│   ├── PlaceholderRenderer.swift
│   └── preview-docs.sh
├── ASSET-CHECKLIST.md
├── IMAGE-CHECKLIST.md
├── REFERENCES.md
└── README.md
```

## 로컬 미리보기

```sh
./Scripts/preview-docs.sh
```

브라우저에서 터미널에 표시된 로컬 주소를 엽니다. 종료할 때는 터미널에서 `Control-C`를 누릅니다.

## 정적 사이트 빌드

```sh
./Scripts/build-docs.sh
```

생성된 `docs/`는 저장소 이름 `2026TechMap_tutorial`을 base path로 사용하는 정적 호스팅용 DocC 출력입니다.

## 실제 스크린샷으로 교체

1. `IMAGE-CHECKLIST.md`의 촬영 항목을 따라 캡처합니다.
2. `SnowVillage.docc/Tutorials/Resources/` 안의 같은 이름 PNG를 실제 이미지로 덮어씁니다.
3. 이미지가 16:9 비율이면 현재 placeholder와 레이아웃이 비슷하게 유지됩니다.
4. `./Scripts/build-docs.sh`를 다시 실행해 누락 이미지와 DocC 경고를 확인합니다.

## GitHub Pages 배포

1. 이 폴더의 내용을 `2026TechMap_tutorial` 저장소 루트에 올립니다.
2. GitHub 저장소의 **Settings > Pages > Build and deployment > Source**를 **GitHub Actions**로 선택합니다.
3. `main` 브랜치에 push하면 `.github/workflows/deploy-docc.yml`이 DocC를 빌드하고 Pages에 배포합니다.
4. 기본 주소는 `https://<사용자명>.github.io/2026TechMap_tutorial/tutorials/snowvillage/` 형식입니다.

저장소 이름을 바꾸면 `Scripts/build-docs.sh`와 `.github/workflows/deploy-docc.yml`의 `HOSTING_BASE_PATH`도 같은 이름으로 바꿉니다.

Reality Composer Pro와 DocC 관련 근거 링크는 `REFERENCES.md`에서 확인할 수 있습니다.
